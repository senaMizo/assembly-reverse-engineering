@ ARM32 Hello World
@ arm-linux-gnueabi-as hello_arm.asm -o hello_arm.o
@ arm-linux-gnueabi-ld hello_arm.o -o hello_arm

.global _start

.section .data
message:
    .asciz "Hello ARM World!\n"
len = . - message

.section .text
_start:
    @ Write syscall (4)
    mov r7, #4          @ syscall number for write
    mov r0, #1          @ file descriptor 1 (stdout)
    ldr r1, =message    @ pointer to message
    mov r2, #len        @ message length
    swi #0              @ software interrupt

    @ Exit syscall (1)
    mov r7, #1          @ syscall number for exit
    mov r0, #0          @ exit code 0
    swi #0
