/*
 * Simple XOR Packer
 * Demonstrates basic executable packing technique
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

// XOR encryption key
#define XOR_KEY 0xAA

// Simple stub to decrypt and execute
unsigned char stub[] = {
    0x48, 0x31, 0xC0,                         // xor rax, rax
    0x48, 0x8D, 0x35, 0x00, 0x00, 0x00, 0x00, // lea rsi, [rel payload]
    0x48, 0x8D, 0x3E,                         // lea rdi, [rsi]
    0x48, 0xB9, 0x00, 0x00, 0x00, 0x00, 0x00, // mov rcx, payload_size
    0x00, 0x00, 0x00,
    0x8A, 0x06,                               // l0: mov al, [rsi]
    0x34, 0xAA,                               // xor al, XOR_KEY
    0x88, 0x07,                               // mov [rdi], al
    0x48, 0xFF, 0xC6,                         // inc rsi
    0x48, 0xFF, 0xC7,                         // inc rdi
    0x48, 0xFF, 0xC9,                         // dec rcx
    0x75, 0xF2,                               // jnz l0
    0xE9, 0x00, 0x00, 0x00, 0x00              // jmp payload
};

void encrypt_payload(unsigned char *data, size_t size) {
    for(size_t i = 0; i < size; i++) {
        data[i] ^= XOR_KEY;
    }
}

int main(int argc, char *argv[]) {
    if(argc != 3) {
        printf("Usage: %s <input> <output>\n", argv[0]);
        return 1;
    }
    
    FILE *input = fopen(argv[1], "rb");
    FILE *output = fopen(argv[2], "wb");
    
    if(!input || !output) {
        printf("File error!\n");
        return 1;
    }
    
    // Read input file
    fseek(input, 0, SEEK_END);
    size_t size = ftell(input);
    fseek(input, 0, SEEK_SET);
    
    unsigned char *payload = malloc(size);
    fread(payload, 1, size, input);
    
    // Encrypt payload
    encrypt_payload(payload, size);
    
    // Write stub + encrypted payload
    fwrite(stub, 1, sizeof(stub), output);
    fwrite(payload, 1, size, output);
    
    free(payload);
    fclose(input);
    fclose(output);
    
    printf("Packed file created: %s\n", argv[2]);
    return 0;
}
