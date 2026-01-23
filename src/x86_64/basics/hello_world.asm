; x86_64 Linux Hello World
; nasm -f elf64 hello_world.asm && ld hello_world.o -o hello_world

section .data
    msg db 'Hello, Reverse Engineer!', 0xA
    len equ $ - msg

section .text
    global _start

_start:
    ; write syscall (1)
    mov rax, 1          ; syscall number for write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, msg        ; pointer to message
    mov rdx, len        ; message length
    syscall

    ; exit syscall (60)
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; exit code 0
    syscall
