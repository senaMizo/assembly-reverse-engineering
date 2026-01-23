// ARM64 Hello World
// aarch64-linux-gnu-as hello_arm64.asm -o hello_arm64.o
// aarch64-linux-gnu-ld hello_arm64.o -o hello_arm64

.global _start

.section .data
message:
    .asciz "Hello ARM64 World!\n"
len = . - message

.section .text
_start:
    // Write syscall (64)
    mov x8, #64         // syscall number for write
    mov x0, #1          // file descriptor 1 (stdout)
    adr x1, message     // pointer to message
    mov x2, #len        // message length
    svc #0              // supervisor call

    // Exit syscall (93)
    mov x8, #93         // syscall number for exit
    mov x0, #0          // exit code 0
    svc #0
