; Timing-based anti-debug technique
; Uses RDTSC instruction to detect breakpoints

section .text
global _start

_start:
    ; First RDTSC
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov rbx, rax        ; Store first timestamp
    
    ; Some dummy operations
    mov rcx, 1000000
delay_loop:
    dec rcx
    jnz delay_loop
    
    ; Second RDTSC
    rdtsc
    shl rdx, 32
    or rax, rdx
    
    ; Calculate difference
    sub rax, rbx
    
    ; If difference is too small, likely a breakpoint
    cmp rax, 10000      ; Arbitrary threshold
    jl debugger_detected
    
    ; Normal execution
    mov rax, 1
    mov rdi, 1
    mov rsi, ok_msg
    mov rdx, ok_len
    syscall
    jmp exit

debugger_detected:
    mov rax, 1
    mov rdi, 1
    mov rsi, detect_msg
    mov rdx, detect_len
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
ok_msg db 'Timing check passed', 0xA
ok_len equ $ - ok_msg

detect_msg db 'Debugger detected via timing!', 0xA
detect_len equ $ - detect_msg
