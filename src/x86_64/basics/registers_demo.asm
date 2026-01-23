; x86_64 Register Demonstration
section .text
global _start

_start:
    ; Demonstrating register usage
    mov rax, 0x1122334455667788
    mov rbx, rax        ; Copy RAX to RBX
    
    ; Arithmetic operations
    add rax, 0x100
    sub rbx, 0x50
    
    ; Bit operations
    xor rax, rax        ; Clear RAX
    or  rbx, 0xFF       ; Set lower byte
    
    ; Stack operations
    push 0xDEADBEEF
    pop rcx
    
    ; Compare and jump
    cmp rax, rbx
    je  equal_label
    jmp exit
    
equal_label:
    mov rdx, 1

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
