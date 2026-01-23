# Intermediate Challenges

## Challenge 4: Custom Encryption Algorithm
**File:** `challenge4.bin`
**Type:** x64 ELF
**Difficulty:** ★★★☆☆

### Description
Implements a custom encryption algorithm using bitwise operations and arithmetic.

### Tasks:
1. Reverse the encryption algorithm
2. Decrypt the flag without running the binary
3. Implement the algorithm in Python

### Hints:
- Algorithm uses XOR, rotation, and addition
- Key is derived from input length
- Each character is processed independently

## Challenge 5: Self-Modifying Code
**File:** `challenge5.bin`
**Type:** Windows PE
**Difficulty:** ★★★★☆

### Description
Program modifies its own code during execution to decrypt and execute payload.

### Tasks:
1. Analyze the unpacking routine
2. Dump the decrypted payload
3. Analyze the payload functionality

### Hints:
- Look for write permissions on code sections
- The decryption key is in the first 16 bytes
- Uses XOR with incremental key

## Challenge 6: Anti-Debug Techniques
**File:** `challenge6.bin`
**Type:** x64 ELF
**Difficulty:** ★★★☆☆

### Description
Implements multiple anti-debug techniques that must be bypassed.

### Tasks:
1. Identify all anti-debug techniques
2. Bypass each technique
3. Extract the hidden flag

### Techniques included:
- ptrace check
- /proc/self/status check
- Timing attack detection
- INT3 scan

## Challenge 7: Network Protocol
**File:** `challenge7.bin`
**Type:** x86 ELF
**Difficulty:** ★★★★☆

### Description
Client-server application with custom network protocol.

### Tasks:
1. Reverse the network protocol
2. Create a client that can communicate with server
3. Extract data from server responses

### Hints:
- Protocol uses simple XOR encryption
- Packet structure: [size][type][data][checksum]
- Checksum is sum of all bytes mod 256
