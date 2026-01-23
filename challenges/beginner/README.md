# Beginner Challenges

## Challenge 1: Simple String Comparison
**File:** `challenge1.bin`
**Type:** x64 ELF
**Difficulty:** ★☆☆☆☆

### Description
A simple program that asks for a password and compares it with a hardcoded string.

### Tasks:
1. Find the correct password
2. Understand the comparison routine
3. Patch the binary to accept any password

### Hints:
- Use `strings` command
- Look for "Access granted" and "Access denied" strings
- The password is 8 characters long

## Challenge 2: Basic Arithmetic Check
**File:** `challenge2.bin`
**Type:** x86 ELF
**Difficulty:** ★★☆☆☆

### Description
The program performs a mathematical operation on the input and compares the result.

### Tasks:
1. Reverse the algorithm
2. Create a keygen
3. Find at least 3 valid inputs

### Hints:
- The algorithm uses only addition and multiplication
- Input is a number between 1000 and 9999
- Result must equal 0xDEADBEEF

## Challenge 3: XOR Encryption
**File:** `challenge3.bin`
**Type:** Windows PE
**Difficulty:** ★★☆☆☆

### Description
Simple XOR encryption with a single-byte key.

### Tasks:
1. Find the XOR key
2. Decrypt the password
3. Write a decryptor script

### Hints:
- Look for high-frequency bytes
- The encrypted data contains English words
- Key is between 0x20 and 0x7F

## Solutions
*Note: Try the challenges before looking at solutions!*

### Challenge 1 Solution:
Password: `Welcome1`

### Challenge 2 Solution:
Algorithm: `(input * 0x539) + 0xABCD == 0xDEADBEEF`

### Challenge 3 Solution:
XOR Key: `0x55`
