/*
 * Simple Crackme Level 1
 * Password: "reverse_me_123"
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void print_banner() {
    printf("=== Simple Crackme Level 1 ===\n");
    printf("Find the correct password!\n");
}

int check_password(const char *input) {
    const char *password = "reverse_me_123";
    
    if(strlen(input) != strlen(password)) {
        return 0;
    }
    
    for(int i = 0; i < strlen(password); i++) {
        if(input[i] != password[i]) {
            return 0;
        }
    }
    
    return 1;
}

int main(int argc, char *argv[]) {
    char input[100];
    
    print_banner();
    
    if(argc != 2) {
        printf("Usage: %s <password>\n", argv[0]);
        return 1;
    }
    
    if(check_password(argv[1])) {
        printf("[+] Congratulations! Flag: FLAG{basic_reverse_1}\n");
    } else {
        printf("[-] Wrong password!\n");
    }
    
    return 0;
}
