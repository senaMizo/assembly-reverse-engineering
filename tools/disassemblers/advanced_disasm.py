#!/usr/bin/env python3
"""
Advanced Multi-Architecture Disassembler
Supports x86, x64, ARM, ARM64, MIPS
"""

from capstone import *
from capstone.x86 import *
import argparse
import struct
import sys
import re

class AdvancedDisassembler:
    def __init__(self, arch='x64', mode='64'):
        self.arch_map = {
            'x86': (CS_ARCH_X86, CS_MODE_32),
            'x64': (CS_ARCH_X86, CS_MODE_64),
            'arm': (CS_ARCH_ARM, CS_MODE_ARM),
            'arm64': (CS_ARCH_ARM64, CS_MODE_ARM),
            'mips32': (CS_ARCH_MIPS, CS_MODE_MIPS32),
            'mips64': (CS_ARCH_MIPS, CS_MODE_MIPS64),
        }
        
        arch_key = arch.lower()
        if arch_key not in self.arch_map:
            raise ValueError(f"Unsupported architecture: {arch}")
        
        cs_arch, cs_mode = self.arch_map[arch_key]
        self.md = Cs(cs_arch, cs_mode)
        self.md.detail = True
        
        # Shellcode patterns
        self.shellcode_patterns = {
            'execve': [
                (b'\x31\xc0\x50\x68\x2f\x2f\x73\x68', 'x86 execve("/bin/sh")'),
                (b'\x48\x31\xd2\x48\xbb\x2f\x2f\x62', 'x64 execve("/bin/sh")'),
            ],
            'bind_shell': [
                (b'\x31\xc0\x31\xdb\x31\xc9\x31\xd2', 'x86 bind shell'),
            ],
            'reverse_shell': [
                (b'\x6a\x66\x58\x6a\x01\x5b\x31\xf6', 'x86 reverse shell'),
            ]
        }
    
    def disassemble(self, code, address=0x1000):
        """Disassemble binary code"""
        instructions = []
        
        for insn in self.md.disasm(code, address):
            instructions.append({
                'address': insn.address,
                'size': insn.size,
                'bytes': insn.bytes.hex(),
                'mnemonic': insn.mnemonic,
                'op_str': insn.op_str,
                'groups': insn.groups,
            })
        
        return instructions
    
    def analyze(self, code):
        """Analyze code for interesting patterns"""
        analysis = {
            'shellcode': [],
            'syscalls': [],
            'jumps': [],
            'calls': [],
            'strings': self.extract_strings(code),
        }
        
        # Check for shellcode patterns
        for category, patterns in self.shellcode_patterns.items():
            for pattern, description in patterns:
                if pattern in code:
                    offset = code.find(pattern)
                    analysis['shellcode'].append({
                        'type': category,
                        'description': description,
                        'offset': offset,
                        'pattern': pattern.hex()
                    })
        
        # Disassemble and analyze instructions
        for insn in self.md.disasm(code, 0x1000):
            # Check for syscalls/interrupts
            if insn.mnemonic in ['syscall', 'int', 'svc', 'swi']:
                analysis['syscalls'].append({
                    'address': insn.address,
                    'instruction': f"{insn.mnemonic} {insn.op_str}",
                })
            
            # Check for jumps
            if insn.mnemonic.startswith('j'):
                analysis['jumps'].append({
                    'address': insn.address,
                    'type': insn.mnemonic,
                    'target': insn.op_str,
                })
            
            # Check for calls
            if insn.mnemonic == 'call':
                analysis['calls'].append({
                    'address': insn.address,
                    'target': insn.op_str,
                })
        
        return analysis
    
    def extract_strings(self, data, min_len=4):
        """Extract ASCII strings from binary data"""
        strings = []
        current = []
        
        for byte in data:
            if 32 <= byte <= 126:  # Printable ASCII
                current.append(chr(byte))
            else:
                if len(current) >= min_len:
                    strings.append(''.join(current))
                current = []
        
        if len(current) >= min_len:
            strings.append(''.join(current))
        
        return strings
    
    def print_disassembly(self, instructions):
        """Pretty print disassembly"""
        print("Address     Bytes              Mnemonic         Operands")
        print("-" * 60)
        
        for insn in instructions:
            addr = f"0x{insn['address']:08x}"
            bytes_str = insn['bytes'][:16].ljust(16)
            mnemonic = insn['mnemonic'].ljust(10)
            op_str = insn['op_str']
            
            print(f"{addr}: {bytes_str} {mnemonic} {op_str}")

def main():
    parser = argparse.ArgumentParser(description='Advanced Disassembler')
    parser.add_argument('file', help='Input file')
    parser.add_argument('-a', '--arch', default='x64', 
                       choices=['x86', 'x64', 'arm', 'arm64', 'mips32', 'mips64'],
                       help='Architecture')
    parser.add_argument('-o', '--offset', type=lambda x: int(x, 0), default=0,
                       help='Start offset')
    parser.add_argument('-s', '--size', type=lambda x: int(x, 0), default=0,
                       help='Size to disassemble (0 for all)')
    parser.add_argument('--analyze', action='store_true',
                       help='Perform full analysis')
    
    args = parser.parse_args()
    
    try:
        with open(args.file, 'rb') as f:
            f.seek(args.offset)
            if args.size > 0:
                code = f.read(args.size)
            else:
                code = f.read()
        
        disasm = AdvancedDisassembler(args.arch)
        
        if args.analyze:
            print(f"\n=== Analysis of {args.file} ===\n")
            analysis = disasm.analyze(code)
            
            if analysis['shellcode']:
                print("[!] Shellcode patterns detected:")
                for sc in analysis['shellcode']:
                    print(f"    - {sc['description']} at 0x{sc['offset']:x}")
            
            if analysis['syscalls']:
                print("\n[+] System calls detected:")
                for sc in analysis['syscalls']:
                    print(f"    - {sc['instruction']} at 0x{sc['address']:x}")
            
            if analysis['strings']:
                print(f"\n[+] Strings found ({len(analysis['strings'])}):")
                for s in analysis['strings'][:10]:  # Show first 10
                    print(f"    - {s}")
                if len(analysis['strings']) > 10:
                    print(f"    ... and {len(analysis['strings']) - 10} more")
            
        else:
            instructions = disasm.disassemble(code)
            disasm.print_disassembly(instructions)
            
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
