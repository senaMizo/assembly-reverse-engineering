

# Assembly Reverse Engineering Mastery

## Repository Structure

```
assembly-reverse-engineering/
├── README.md
├── LICENSE
├── .github/
│   └── workflows/
│       └── ci.yml
├── src/
│   ├── x86_64/
│   │   ├── basics/
│   │   ├── advanced/
│   │   ├── anti-debug/
│   │   └── malware-analysis/
│   ├── arm/
│   │   ├── arm32/
│   │   └── arm64/
│   ├── mips/
│   └── shellcode/
├── examples/
│   ├── crackmes/
│   ├── keygenners/
│   ├── packers/
│   └── unpackers/
├── tools/
│   ├── disassemblers/
│   ├── debuggers/
│   └── custom-scripts/
├── challenges/
│   ├── beginner/
│   ├── intermediate/
│   └── advanced/
├── docs/
│   ├── cheat-sheets/
│   ├── tutorials/
│   └── references/
└── scripts/
    ├── build.sh
    ├── test.sh
    └── analyze.sh
```

## README.md Template

```markdown
# 🛡️ Assembly Reverse Engineering Mastery

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/yourusername/assembly-reverse-engineering.svg)](https://github.com/yourusername/assembly-reverse-engineering/stargazers)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

A comprehensive collection of assembly language resources, tools, and challenges for reverse engineering and binary analysis.

## 🔥 Features

- **Multi-architecture Support**: x86/x64, ARM, MIPS, PowerPC
- **Real-world Examples**: Malware samples, packed executables, anti-debug techniques
- **Hands-on Challenges**: Crackmes, keygenners, and reversing challenges
- **Production Tools**: Custom disassemblers, debugger scripts, analysis frameworks
- **Educational Content**: From basics to advanced exploitation techniques

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/solomonkassa/assembly-reverse-engineering.git
cd assembly-reverse-engineering

# Setup environment
./scripts/setup.sh

# Build examples
./scripts/build.sh
```

## 📚 Architecture Modules

### x86/x64
- Basic to advanced instruction sets
- System calls and calling conventions
- Shellcode development
- Anti-analysis techniques

### ARM
- ARM32 and ARM64 architectures
- Thumb/ARM mode switching
- iOS/Android binary analysis
- Embedded systems reversing

### MIPS/PowerPC
- Router/embedded device firmware
- Game console reversing
- Network device analysis

## 🛠️ Tools Included

### Custom Disassemblers
```python
# Example: Capstone-based disassembler
from capstone import *
import struct

class AdvancedDisassembler:
    def __init__(self, arch=CS_ARCH_X86, mode=CS_MODE_64):
        self.md = Cs(arch, mode)
        self.md.detail = True
        
    def analyze_function(self, binary, address):
        # Advanced function analysis
        pass
```

### Debugger Scripts
- GDB/PEDA enhancements
- WinDbg scripts for Windows reversing
- Radare2 automation scripts
- Frida hooks for dynamic analysis

### Analysis Frameworks
- Binary similarity detection
- Vulnerability pattern matching
- Code emulation sandbox

## 🎯 Challenges

### Beginner Level
1. **Simple Crackme** - Basic string comparison
2. **License Validator** - Serial number generation
3. **Simple Packer** - XOR-based encryption

### Intermediate Level
1. **Anti-Debug Bypass** - Ptrace detection evasion
2. **Obfuscated Code** - Control flow flattening
3. **Custom Crypto** - Roll-your-own encryption

### Advanced Level
1. **VM Protected Binary** - Virtual machine analysis
2. **Kernel Driver** - Ring-0 code analysis
3. **APT Malware** - Real-world threat analysis

## 📖 Documentation

- [Getting Started](docs/GETTING_STARTED.md)
- [Assembly Cheat Sheets](docs/cheat-sheets/)
- [Tool Usage Guides](docs/tutorials/)
- [Research Papers](docs/references/)

## 🔬 Example: Analyzing Shellcode

```assembly
; Position-independent shellcode example
section .text
global _start

_start:
    ; Linux x64 execve("/bin/sh", NULL, NULL)
    xor     rdx, rdx        ; NULL envp
    push    rdx             ; NULL terminate
    mov     rbx, '/bin//sh' ; 8 bytes
    push    rbx
    mov     rdi, rsp        ; ptr to "/bin//sh"
    push    rdx             ; NULL argv[1]
    push    rdi             ; argv[0] = "/bin//sh"
    mov     rsi, rsp        ; ptr to argv
    xor     rax, rax
    mov     al, 59          ; syscall execve
    syscall
```

## 🧪 Testing Framework

```python
import pytest
from src.tools.disassembler import Disassembler

class TestDisassembler:
    def test_x86_disassembly(self):
        code = b"\x55\x48\x89\xe5"  # push rbp; mov rbp, rsp
        disasm = Disassembler(CS_ARCH_X86, CS_MODE_64)
        result = disasm.disassemble(code, 0x1000)
        assert len(result) == 2
        
    def test_shellcode_analysis(self):
        # Test shellcode detection
        pass
```

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/assembly-reverse-engineering&type=Date)](https://star-history.com/#yourusername/assembly-reverse-engineering)

## 🙏 Acknowledgments

- [Capstone Engine](http://www.capstone-engine.org/)
- [Radare2](https://rada.re/n/)
- [Ghidra](https://ghidra-sre.org/)
- All security researchers and reversers

---

**Disclaimer**: This repository is for educational purposes only. Only analyze binaries you own or have permission to analyze.
```

## Key Files to Include

### 1. **CONTRIBUTING.md**
```markdown
# Contributing Guidelines

## Adding New Challenges
1. Include both binary and source code
2. Provide solution write-up
3. Add difficulty rating
4. Include hints

## Code Standards
- Use NASM syntax for x86
- Use GCC inline assembly for modern examples
- Comment complex assembly instructions
- Include build scripts
```

### 2. **src/tools/advanced_disassembler.py**
```python
#!/usr/bin/env python3
"""
Advanced Multi-Architecture Disassembler
"""

from capstone import *
from capstone.x86 import *
import argparse
import struct
import pefile
import elftools

class ReverseEngineeringToolkit:
    def __init__(self):
        self.architectures = {
            'x86': (CS_ARCH_X86, CS_MODE_32),
            'x64': (CS_ARCH_X86, CS_MODE_64),
            'arm': (CS_ARCH_ARM, CS_MODE_ARM),
            'arm64': (CS_ARCH_ARM64, CS_MODE_ARM),
            'mips': (CS_ARCH_MIPS, CS_MODE_MIPS32)
        }
        
    def analyze_binary(self, filepath):
        """Complete binary analysis with multiple techniques"""
        analysis = {
            'sections': [],
            'imports': [],
            'exports': [],
            'functions': [],
            'strings': [],
            'potential_shellcode': []
        }
        
        # Add analysis logic here
        return analysis
    
    def find_shellcode_patterns(self, code):
        """Detect common shellcode patterns"""
        patterns = {
            'execve': [
                b'\x31\xc0\x50\x68\x2f\x2f\x73\x68',  // xor eax, eax; push eax; etc.
                b'\x48\x31\xd2\x48\xbb\x2f\x2f\x62'   // x64 execve
            ],
            'bind_shell': [
                b'\x31\xc0\x31\xdb\x31\xc9\x31\xd2'   // socket creation
            ]
        }
        
        for name, pattern_list in patterns.items():
            for pattern in pattern_list:
                if pattern in code:
                    return name
        return None
```

### 3. **examples/crackmes/level1/solution.md**
```markdown
# Level 1 Crackme Solution

## Binary Analysis
- Architecture: x64 ELF
- Protections: None
- Difficulty: Easy

## Reversing Process
1. Strings analysis reveals "Password: " and "Access Granted"
2. IDA Pro/Ghidra shows simple strcmp at 0x401234
3. Password is stored at 0x402000

## Key Points
```assembly
; Main validation routine
lea     rdi, [rip+password]  ; Load password
call    _strcmp
test    eax, eax
jz      access_granted
```

## Password: `MyFirstCrackme123!`
```

### 4. **scripts/setup.sh**
```bash
#!/bin/bash
# Setup script for reverse engineering environment

echo "Setting up Assembly Reverse Engineering Environment..."

# Install dependencies
sudo apt-get update
sudo apt-get install -y \
    nasm \
    gcc \
    gdb \
    radare2 \
    binutils \
    build-essential \
    python3 \
    python3-pip

# Install Python packages
pip3 install capstone keystone-engine unicorn ropper angr

# Install optional tools
sudo apt-get install -y \
    ltrace \
    strace \
    checksec \
    seccomp-tools

echo "Environment setup complete!"
```

### 5. **docs/cheat-sheets/x64.md**
```markdown
# x64 Assembly Cheat Sheet

## Registers
- RAX, RBX, RCX, RDX - General purpose
- RSI, RDI - Source/Destination index
- RBP, RSP - Base/Stack pointers
- RIP - Instruction pointer
- R8-R15 - Additional general purpose

## Common Instructions
```
mov rax, rbx        ; Move
add rax, 0x10       ; Add
sub rsp, 0x20       ; Subtract
cmp rax, rbx        ; Compare
jz label            ; Jump if zero
call function       ; Call function
ret                 ; Return
syscall             ; System call
```

## System Calls (Linux x64)
- 0 - read
- 1 - write
- 2 - open
- 59 - execve
- 60 - exit
```

## Advanced Features to Implement

### 1. **Automated Analysis Pipeline**
```python
class AutomatedAnalyzer:
    def __init__(self):
        self.analyzers = [
            StringsAnalyzer(),
            FunctionAnalyzer(),
            CFGAnalyzer(),
            VulnerabilityScanner()
        ]
    
    def full_analysis(self, binary):
        results = {}
        for analyzer in self.analyzers:
            results.update(analyzer.analyze(binary))
        return self.generate_report(results)
```

### 2. **CTF Challenge Generator**
```python
class ChallengeGenerator:
    def generate_crackme(self, difficulty):
        template = self.load_template(difficulty)
        obfuscation = self.apply_obfuscation(template)
        return self.compile_challenge(obfuscation)
```

### 3. **Shellcode Encoder/Decoder**
```python
class ShellcodeEngine:
    def encode(self, shellcode, encoder_type="xor"):
        if encoder_type == "xor":
            key = random.randint(1, 255)
            encoded = bytes([b ^ key for b in shellcode])
            decoder = self.generate_xor_decoder(key)
            return decoder + encoded
```

## GitHub Actions Workflow (.github/workflows/ci.yml)
```yaml
name: CI/CD Pipeline

on: [push, pull_request]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup environment
      run: ./scripts/setup.sh
    
    - name: Build examples
      run: ./scripts/build.sh
    
    - name: Run tests
      run: ./scripts/test.sh
    
    - name: Security scan
      run: |
        checksec ./examples/crackmes/*.elf
        strings ./examples/crackmes/*.elf | grep -i "password\|key\|secret"
```

## Repository Features to Highlight

1. **Comprehensive Documentation**: From basics to advanced topics
2. **Real-world Examples**: Actual malware samples (anonymized)
3. **Interactive Learning**: Jupyter notebooks with assembly
4. **Community Challenges**: Regularly updated CTF-style challenges
5. **Tool Development**: Learn by building your own RE tools
6. **Multi-Platform**: Windows, Linux, macOS, embedded systems
7. **Modern Techniques**: Anti-RE, virtualization, obfuscation

