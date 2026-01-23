/*
 * Simple Key Generator Example
 * Algorithm: XOR with 0x55 and add serial number
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void generate_key(const char *name, char *key) {
    int i;
    int serial = 0;
    
    // Calculate serial from name
    for(i = 0; name[i] != '\0'; i++) {
        serial += name[i];
    }
    
    // Generate key
    for(i = 0; i < 16; i++) {
        key[i] = ((serial + i) ^ 0x55) % 26 + 'A';
    }
    key[16] = '\0';
}

int main(int argc, char *argv[]) {
    char key[17];
    
    if(argc != 2) {
        printf("Usage: %s <name>\n", argv[0]);
        return 1;
    }
    
    generate_key(argv[1], key);
    printf("Name: %s\n", argv[1]);
    printf("Key: %s\n", key);
    
    return 0;
}
