#!/usr/bin/env python3
"""
Simple XOR Unpacker
Demonstrates basic unpacking technique
"""

import sys
import struct

def find_xor_key(data):
    """Try to find XOR key by analyzing encrypted data"""
    # Common plaintext patterns in executables
    patterns = [
        b'\x7fELF',  # ELF header
        b'MZ',       # PE header
        b'\x4d\x5a', # MZ in little-endian
    ]
    
    for pattern in patterns:
        for key in range(256):
            decrypted = bytes(b ^ key for b in data[:len(pattern)])
            if decrypted == pattern:
                return key
    
    return None

def unpack_xor(filename, key=None):
    """Unpack XOR encrypted file"""
    with open(filename, 'rb') as f:
        data = f.read()
    
    if key is None:
        key = find_xor_key(data)
        if key is None:
            print("Could not determine XOR key automatically")
            return
    
    print(f"Using XOR key: 0x{key:02x}")
    
    # Decrypt data
    decrypted = bytes(b ^ key for b in data)
    
    # Write decrypted file
    output = filename + ".unpacked"
    with open(output, 'wb') as f:
        f.write(decrypted)
    
    print(f"Unpacked file saved as: {output}")
    
    # Try to identify file type
    if decrypted[:4] == b'\x7fELF':
        print("File type: ELF executable")
    elif decrypted[:2] == b'MZ':
        print("File type: PE executable")
    else:
        print("File type: Unknown")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <file> [xor_key]")
        sys.exit(1)
    
    key = None
    if len(sys.argv) > 2:
        key = int(sys.argv[2], 0)
    
    unpack_xor(sys.argv[1], key)
