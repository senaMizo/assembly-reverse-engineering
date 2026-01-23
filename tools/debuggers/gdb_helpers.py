#!/usr/bin/env python3
"""
Pattern Finder for Reverse Engineering
Finds common patterns in binaries
"""

import re
import struct
import argparse
from typing import List, Dict, Tuple

class PatternFinder:
    def __init__(self):
        self.patterns = {
            # Function prologues
            'function_prologue_x64': [
                (b'\x55\x48\x89\xe5', 'push rbp; mov rbp, rsp'),
                (b'\x48\x83\xec', 'sub rsp, XX'),  # Stack allocation
            ],
            'function_prologue_x86': [
                (b'\x55\x89\xe5', 'push ebp; mov ebp, esp'),
                (b'\x83\xec', 'sub esp, XX'),
            ],
            
            # System calls
            'syscall_x64': [
                (b'\x0f\x05', 'syscall'),
            ],
            'syscall_x86': [
                (b'\xcd\x80', 'int 0x80'),
                (b'\x0f\x34', 'sysenter'),
            ],
            'syscall_arm': [
                (b'\x00\x00\x00\xef', 'svc #0'),
            ],
            
            # Cryptographic constants
            'crypto_constants': [
                (b'\x67\x45\x23\x01', 'MD5 constant'),
                (b'\xef\xcd\xab\x89', 'SHA1 constant'),
                (b'\x98\xba\xdc\xfe', 'AES S-box related'),
            ],
            
            # Anti-debug
            'antidebug': [
                (b'\x65\x48\x8b\x04\x25\x30\x00\x00\x00', 'gs:0x30 (TEB access)'),
                (b'\x64\xa1\x30\x00\x00\x00', 'fs:0x30 (TEB access x86)'),
                (b'\x31\xc0\xb0\x65\xcd\x80', 'ptrace check'),
            ],
            
            # Shellcode markers
            'shellcode': [
                (b'\x90' * 10, 'NOP sled (10+)'),
                (b'\xcc' * 5, 'INT3 sled (5+)'),
            ],
        }
    
    def find_patterns(self, data: bytes, min_matches: int = 1) -> Dict[str, List[Tuple[int, str]]]:
        """Find all patterns in the data"""
        results = {}
        
        for category, pattern_list in self.patterns.items():
            matches = []
            for pattern, description in pattern_list:
                # Handle wildcard bytes (XX)
                if b'XX' in pattern:
                    # Convert to regex pattern
                    regex_pattern = re.escape(pattern).replace(b'XX', b'.')
                    regex = re.compile(regex_pattern, re.DOTALL)
                    for match in regex.finditer(data):
                        matches.append((match.start(), description))
                else:
                    # Simple byte search
                    offset = 0
                    while True:
                        pos = data.find(pattern, offset)
                        if pos == -1:
                            break
                        matches.append((pos, description))
                        offset = pos + 1
            
            if matches:
                results[category] = matches
        
        return results
    
    def find_xor_keys(self, data: bytes) -> List[Tuple[int, float]]:
        """Find potential XOR keys by analyzing byte frequency"""
        candidates = []
        
        for key in range(256):
            # Try XOR decryption
            decrypted = bytes(b ^ key for b in data[:1024])  # First 1KB
            
            # Check for high ASCII content (potentially strings)
            ascii_count = sum(1 for b in decrypted if 32 <= b <= 126 or b == 0)
            ratio = ascii_count / len(decrypted)
            
            if ratio > 0.7:  # High ASCII ratio suggests text
                candidates.append((key, ratio))
        
        # Sort by ratio (highest first)
        candidates.sort(key=lambda x: x[1], reverse=True)
        return candidates[:10]  # Return top 10
    
    def find_possible_offsets(self, data: bytes) -> Dict[str, List[int]]:
        """Find possible offsets/addresses in the data"""
        results = {
            '32bit_offsets': [],
            '64bit_offsets': [],
            'rvas': [],
        }
        
        # Find 32-bit pointers (little endian)
        for i in range(len(data) - 4):
            value = struct.unpack('<I', data[i:i+4])[0]
            if 0x1000 <= value <= 0x7fffffff:  # Reasonable range
                results['32bit_offsets'].append((i, hex(value)))
        
        # Find 64-bit pointers (little endian)
        for i in range(len(data) - 8):
            value = struct.unpack('<Q', data[i:i+8])[0]
            if 0x10000 <= value <= 0x7fffffffffff:  # Reasonable range
                results['64bit_offsets'].append((i, hex(value)))
        
        # Find RVA-like values (offsets from base)
        for i in range(len(data) - 4):
            value = struct.unpack('<I', data[i:i+4])[0]
            if value < 0x100000:  # Likely RVA
                results['rvas'].append((i, hex(value)))
        
        return results

def main():
    parser = argparse.ArgumentParser(description='Pattern Finder for Reverse Engineering')
    parser.add_argument('file', help='Binary file to analyze')
    parser.add_argument('-v', '--verbose', action='store_true', help='Verbose output')
    parser.add_argument('--xor', action='store_true', help='Find XOR keys')
    parser.add_argument('--offsets', action='store_true', help='Find possible offsets')
    
    args = parser.parse_args()
    
    with open(args.file, 'rb') as f:
        data = f.read()
    
    finder = PatternFinder()
    
    print(f"Analyzing {args.file} ({len(data)} bytes)")
    print("=" * 60)
    
    # Find patterns
    patterns = finder.find_patterns(data)
    
    for category, matches in patterns.items():
        print(f"\n{category.upper()}:")
        for offset, description in matches[:10]:  # Limit output
            print(f"  0x{offset:08x}: {description}")
        if len(matches) > 10:
            print(f"  ... and {len(matches) - 10} more")
    
    # Find XOR keys
    if args.xor:
        print("\n" + "=" * 60)
        print("POTENTIAL XOR KEYS:")
        keys = finder.find_xor_keys(data)
        for key, ratio in keys:
            print(f"  Key 0x{key:02x}: ASCII ratio {ratio:.2%}")
    
    # Find offsets
    if args.offsets:
        print("\n" + "=" * 60)
        print("POSSIBLE OFFSETS/ADDRESSES:")
        offsets = finder.find_possible_offsets(data[:4096])  # First 4KB
        
        for category, values in offsets.items():
            print(f"\n{category}:")
            for offset, value in values[:5]:  # Limit output
                print(f"  Offset 0x{offset:04x}: -> {value}")
            if len(values) > 5:
                print(f"  ... and {len(values) - 5} more")

if __name__ == "__main__":
    main()
