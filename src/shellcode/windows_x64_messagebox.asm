; Windows x64 MessageBox shellcode
; Uses PEB walking to find kernel32.dll and GetProcAddress

[BITS 64]

start:
    ; Save registers
    push rsi
    push rdi
    
    ; Find kernel32.dll base address
    mov rax, [gs:0x60]      ; PEB
    mov rax, [rax + 0x18]   ; PEB_LDR_DATA
    mov rax, [rax + 0x20]   ; InMemoryOrderModuleList
    mov rax, [rax]          ; ntdll.dll
    mov rax, [rax]          ; kernel32.dll
    mov rax, [rax + 0x20]   ; DllBase
    mov rbx, rax            ; Save kernel32 base
    
    ; Find GetProcAddress
    ; (Simplified - real implementation needs parsing PE headers)
    
    ; Prepare MessageBox parameters
    xor rcx, rcx        ; hWnd = NULL
    lea rdx, [rel msg]  ; Text
    lea r8, [rel title] ; Title
    mov r9, 0           ; MB_OK
    
    ; Cleanup and return
    pop rdi
    pop rsi
    ret

msg:    db 'Shellcode executed!', 0
title:  db 'Reverse Engineering', 0
