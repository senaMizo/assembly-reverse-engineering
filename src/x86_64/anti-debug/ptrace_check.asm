; Anti-debug technique: ptrace check
; ptrace returns -1 if already being traced

section .text
global _start

_start:
    ; Try to ptrace ourselves
    xor rax, rax
    mov al, 101         ; syscall ptrace
    
    xor rdi, rdi        ; PTRACE_TRACEME = 0
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    
    syscall
    
    ; Check if ptrace returned -1 (error)
    cmp rax, -1
    je debugger_detected
    
    ; Normal execution path
    mov rax, 1
    mov rdi, 1
    mov rsi, normal_msg
    mov rdx, normal_len
    syscall
    jmp exit

debugger_detected:
    ; Debugger detected - do something malicious or exit
    mov rax, 1
    mov rdi, 1
    mov rsi, debug_msg
    mov rdx, debug_len
    syscall
    
    ; Exit with error code
    mov rax, 60
    mov rdi, 99
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
normal_msg db 'No debugger detected', 0xA
normal_len equ $ - normal_msg

debug_msg db 'Debugger detected! Exiting...', 0xA
debug_len equ $ - debug_msg
