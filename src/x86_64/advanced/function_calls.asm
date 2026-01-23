; x86_64 Function Calling Convention Demonstration
; System V ABI: RDI, RSI, RDX, RCX, R8, R9 for arguments

section .data
    fmt db "Result: %d", 0xA, 0

section .text
extern printf
global main

; Function to add two numbers
add_numbers:
    push rbp
    mov rbp, rsp
    
    ; Arguments in RDI and RSI
    mov rax, rdi
    add rax, rsi
    
    pop rbp
    ret

; Function with more than 6 arguments
complex_function:
    push rbp
    mov rbp, rsp
    
    ; Arguments in registers and stack
    ; RDI, RSI, RDX, RCX, R8, R9, then stack
    mov rax, rdi        ; arg1
    add rax, rsi        ; arg2
    add rax, rdx        ; arg3
    add rax, rcx        ; arg4
    add rax, r8         ; arg5
    add rax, r9         ; arg6
    
    ; Get 7th argument from stack
    mov r10, [rbp + 16]
    add rax, r10
    
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp
    
    ; Test add_numbers
    mov rdi, 10         ; First argument
    mov rsi, 20         ; Second argument
    call add_numbers
    
    ; Test complex_function
    mov rdi, 1          ; arg1
    mov rsi, 2          ; arg2
    mov rdx, 3          ; arg3
    mov rcx, 4          ; arg4
    mov r8, 5           ; arg5
    mov r9, 6           ; arg6
    push 7              ; arg7 on stack
    call complex_function
    add rsp, 8          ; Clean stack
    
    ; Prepare printf call
    mov rdi, fmt
    mov rsi, rax
    xor rax, rax        ; No floating point args
    call printf
    
    pop rbp
    ret
