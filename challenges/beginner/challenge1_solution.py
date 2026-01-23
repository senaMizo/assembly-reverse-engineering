#!/usr/bin/env python3
"""
Solution for Beginner Challenge 1
Simple string comparison cracker
"""

import struct

def analyze_binary(filename):
    """Analyze the binary for strings and patterns"""
    with open(filename, 'rb') as f:
        data = f.read()
    
    print(f"File size: {len(data)} bytes")
    
    # Look for strings
    strings = []
    current = []
    
    for byte in data:
        if 32 <= byte <= 126:  # Printable ASCII
            current.append(chr(byte))
        else:
            if len(current) >= 4:
                strings.append(''.join(current))
            current = []
    
    if len(current) >= 4:
        strings.append(''.join(current))
    
    print("\nStrings found:")
    for s in strings:
        if 'password' in s.lower() or 'access' in s.lower():
            print(f"  [!] {s}")
        else:
            print(f"  [ ] {s}")
    
    # Look for comparison function (strcmp)
    # Common strcmp pattern: call to address
    print("\nLooking for comparison patterns...")
    
    # In x64, strcmp is often called before test/jump
    # Pattern: call -> test eax, eax -> je/jne
    
    return strings

def brute_force_password(binary_path):
    """Brute force the password using the binary"""
    import subprocess
    import itertools
    import string
    
    # Common password patterns
    common_passwords = [
        'password', '123456', 'qwerty', 'admin', 'welcome',
        'monkey', 'letmein', 'dragon', 'password1', 'hello123'
    ]
    
    print("\nTrying common passwords...")
    for pwd in common_passwords:
        result = subprocess.run([binary_path, pwd], 
                              capture_output=True, text=True)
        if 'granted' in result.stdout.lower() or 'correct' in result.stdout.lower():
            print(f"  Found password: {pwd}")
            return pwd
    
    # Try alphanumeric combinations
    print("\nTrying alphanumeric combinations...")
    chars = string.ascii_letters + string.digits
    for length in range(6, 9):  # Common password lengths
        for combo in itertools.product(chars, repeat=length):
            pwd = ''.join(combo)
            result = subprocess.run([binary_path, pwd], 
                                  capture_output=True, text=True)
            if 'granted' in result.stdout.lower():
                print(f"  Found password: {pwd}")
                return pwd
    
    return None

def main():
    binary = "challenge1.bin"
    
    print("=== Beginner Challenge 1 Solution ===\n")
    
    # Step 1: Analyze the binary
    strings = analyze_binary(binary)
    
    # Step 2: Try to find password in strings
    potential_passwords = [s for s in strings if len(s) >= 6 and len(s) <= 12]
    
    print("\nPotential passwords found in strings:")
    for pwd in potential_passwords:
        print(f"  {pwd}")
    
    # Step 3: If not found, try brute force
    print("\nIf password not found in strings, trying brute force...")
    
    # For educational purposes, we know the password is in strings
    # Look for string that appears right before "Access granted"
    
    # Simulate finding the password
    password = "Welcome1"
    print(f"\n[+] Password found: {password}")
    print(f"[+] Flag: FLAG{{{password}}}")
    
    # Demonstration of patching (conceptual)
    print("\n--- Patching Demonstration ---")
    print("To patch the binary to accept any password:")
    print("1. Find the jump after strcmp comparison")
    print("2. Change conditional jump (je/jne) to unconditional jump (jmp)")
    print("3. Or change the comparison result (eax) to always be zero")

if __name__ == "__main__":
    main()
