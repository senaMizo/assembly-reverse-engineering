# MIPS Hello World
# mips-linux-gnu-as hello_mips.asm -o hello_mips.o
# mips-linux-gnu-ld hello_mips.o -o hello_mips

.data
msg:    .asciiz "Hello MIPS World!\n"
len = . - msg

.text
.globl _start

_start:
    # Write syscall (4000 + 4)
    li $v0, 4004        # syscall write
    li $a0, 1           # file descriptor 1
    la $a1, msg         # address of string
    li $a2, len         # length of string
    syscall

    # Exit syscall (4000 + 1)
    li $v0, 4001        # syscall exit
    li $a0, 0           # exit code 0
    syscall
