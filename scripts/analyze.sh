#!/bin/bash
# Analysis script for reverse engineering

set -e

echo "=== Reverse Engineering Analysis Toolkit ==="

if [ $# -lt 1 ]; then
    echo "Usage: $0 <binary_file> [analysis_type]"
    echo ""
    echo "Analysis types:"
    echo "  basic     - Basic file analysis (default)"
    echo "  strings   - String extraction and analysis"
    echo "  functions - Function analysis and disassembly"
    echo "  imports   - Import/export analysis"
    echo "  security  - Security feature checking"
    echo "  full      - Complete analysis"
    exit 1
fi

BINARY=$1
ANALYSIS_TYPE=${2:-basic}

if [ ! -f "$BINARY" ]; then
    echo "[-] File not found: $BINARY"
    exit 1
fi

echo "[+] Analyzing: $BINARY"
echo "[+] File size: $(wc -c < "$BINARY") bytes"
echo "[+] Analysis type: $ANALYSIS_TYPE"
echo ""

# Create output directory
OUTPUT_DIR="analysis_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"
echo "[+] Output directory: $OUTPUT_DIR"

basic_analysis() {
    echo "=== BASIC ANALYSIS ==="
    
    # File type
    echo -e "\n[+] File type:"
    file "$BINARY" | tee "$OUTPUT_DIR/file_type.txt"
    
    # Magic bytes
    echo -e "\n[+] Magic bytes (first 64):"
    hexdump -C -n 64 "$BINARY" | tee "$OUTPUT_DIR/magic_bytes.txt"
    
    # Strings
    echo -e "\n[+] Strings (min 4 chars):"
    strings -n 4 "$BINARY" | head -50 | tee "$OUTPUT_DIR/strings_short.txt"
    strings -n 4 "$BINARY" > "$OUTPUT_DIR/strings_full.txt"
    echo "    (Full strings saved to $OUTPUT_DIR/strings_full.txt)"
    
    # Entropy
    if command -v ent &> /dev/null; then
        echo -e "\n[+] Entropy analysis:"
        ent "$BINARY" | tee "$OUTPUT_DIR/entropy.txt"
    fi
}

string_analysis() {
    echo "=== STRING ANALYSIS ==="
    
    # Extract all strings
    echo -e "\n[+] Extracting all strings..."
    strings -n 4 "$BINARY" > "$OUTPUT_DIR/all_strings.txt"
    echo "    Found $(wc -l < "$OUTPUT_DIR/all_strings.txt") strings"
    
    # Categorize strings
    echo -e "\n[+] Categorized strings:"
    
    # URLs
    echo "  [*] Possible URLs:"
    grep -E "(http|https|ftp)://" "$OUTPUT_DIR/all_strings.txt" | \
        tee "$OUTPUT_DIR/urls.txt"
    
    # IP addresses
    echo "  [*] Possible IP addresses:"
    grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$OUTPUT_DIR/all_strings.txt" | \
        tee "$OUTPUT_DIR/ips.txt"
    
    # Email addresses
    echo "  [*] Possible email addresses:"
    grep -E "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" \
        "$OUTPUT_DIR/all_strings.txt" | tee "$OUTPUT_DIR/emails.txt"
    
    # Windows paths
    echo "  [*] Windows paths:"
    grep -i "\.dll\|\.exe\|\.sys\|c:\\\|\\windows\\" "$OUTPUT_DIR/all_strings.txt" | \
        tee "$OUTPUT_DIR/windows_paths.txt"
    
    # Linux paths
    echo "  [*] Linux paths:"
    grep -E "(/bin/|/usr/|/lib/|/etc/|/tmp/|/dev/)" "$OUTPUT_DIR/all_strings.txt" | \
        tee "$OUTPUT_DIR/linux_paths.txt"
    
    # Interesting strings for RE
    echo "  [*] Interesting strings for reverse engineering:"
    grep -i "password\|key\|secret\|flag\|crack\|hack\|admin\|root\|backdoor" \
        "$OUTPUT_DIR/all_strings.txt" | tee "$OUTPUT_DIR/interesting_strings.txt"
}

function_analysis() {
    echo "=== FUNCTION ANALYSIS ==="
    
    # Check if it's an ELF file
    if file "$BINARY" | grep -q "ELF"; then
        echo -e "\n[+] ELF binary detected"
        
        # Symbols
        echo "  [*] Symbols:"
        nm "$BINARY" 2>/dev/null | tee "$OUTPUT_DIR/symbols.txt" || \
            echo "    (No symbols or stripped)"
        
        # Functions
        echo "  [*] Functions:"
        objdump -t "$BINARY" 2>/dev/null | grep "\.text" | \
            tee "$OUTPUT_DIR/functions.txt" || \
            echo "    (Could not extract functions)"
        
        # Disassemble
        echo "  [*] Disassembly (main section):"
        objdump -d "$BINARY" 2>/dev/null | head -100 | \
            tee "$OUTPUT_DIR/disassembly_sample.txt"
        objdump -d "$BINARY" 2>/dev/null > "$OUTPUT_DIR/disassembly_full.txt"
        echo "    (Full disassembly saved to $OUTPUT_DIR/disassembly_full.txt)"
    
    elif file "$BINARY" | grep -q "PE32"; then
        echo -e "\n[+] PE binary detected"
        
        # Use pefile if available
        if command -v python3 &> /dev/null; then
            echo "  [*] Using pefile for analysis..."
            python3 -c "
import pefile
import sys
try:
    pe = pefile.PE('$BINARY')
    print('Imports:')
    for entry in pe.DIRECTORY_ENTRY_IMPORT:
        print(f'  {entry.dll.decode()}:')
        for imp in entry.imports:
            if imp.name:
                print(f'    {imp.name.decode()}')
    print('\nExports:')
    if hasattr(pe, 'DIRECTORY_ENTRY_EXPORT'):
        for exp in pe.DIRECTORY_ENTRY_EXPORT.symbols:
            if exp.name:
                print(f'  {exp.name.decode()}')
except Exception as e:
    print(f'Error: {e}')
" | tee "$OUTPUT_DIR/pe_analysis.txt"
        fi
    
    else:
        echo "  [-] Not an ELF or PE binary, skipping function analysis"
    fi
}

import_analysis() {
    echo "=== IMPORT/EXPORT ANALYSIS ==="
    
    # Check file type and use appropriate tools
    if file "$BINARY" | grep -q "ELF"; then
        echo -e "\n[+] ELF imports/exports:"
        
        # Dynamic symbols
        echo "  [*] Dynamic symbols:"
        readelf -s "$BINARY" 2>/dev/null | grep -E "(UND|GLOBAL)" | \
            tee "$OUTPUT_DIR/dynamic_symbols.txt"
        
        # Needed libraries
        echo "  [*] Needed libraries:"
        readelf -d "$BINARY" 2>/dev/null | grep NEEDED | \
            tee "$OUTPUT_DIR/needed_libs.txt"
    
    elif file "$BINARY" | grep -q "PE32"; then
        echo -e "\n[+] PE imports/exports (if pefile available):"
        
        if command -v python3 &> /dev/null; then
            python3 -c "
import pefile
pe = pefile.PE('$BINARY')
print('Imported DLLs:')
for entry in pe.DIRECTORY_ENTRY_IMPORT:
    dll = entry.dll.decode().lower()
    print(f'  {dll}')
    with open('$OUTPUT_DIR/' + dll.replace('.', '_') + '_imports.txt', 'w') as f:
        for imp in entry.imports:
            if imp.name:
                f.write(imp.name.decode() + '\\n')
" 2>/dev/null || echo "    (pefile analysis failed)"
        fi
    fi
    
    # Check for suspicious imports
    echo -e "\n[+] Suspicious imports (common in malware):"
    SUSPICIOUS_IMPORTS=(
        "CreateRemoteThread" "VirtualAllocEx" "WriteProcessMemory"
        "RegSetValue" "CreateService" "WinExec" "ShellExecute"
        "URLDownloadToFile" "InternetOpen" "InternetReadFile"
        "GetProcAddress" "LoadLibrary" "VirtualProtect"
    )
    
    for import in "${SUSPICIOUS_IMPORTS[@]}"; do
        if grep -q -i "$import" "$OUTPUT_DIR"/*.txt 2>/dev/null; then
            echo "  [!] $import found"
        fi
    done
}

security_analysis() {
    echo "=== SECURITY ANALYSIS ==="
    
    # Check security features
    if file "$BINARY" | grep -q "ELF"; then
        echo -e "\n[+] ELF security features:"
        
        # Checksec-like analysis
        echo "  [*] checksec analysis:"
        
        # RELRO
        if readelf -l "$BINARY" 2>/dev/null | grep -q "GNU_RELRO"; then
            echo "    RELRO: Enabled"
        else
            echo "    RELRO: Disabled"
        fi
        
        # Stack canary
        if readelf -s "$BINARY" 2>/dev/null | grep -q "__stack_chk_fail"; then
            echo "    Stack Canary: Enabled"
        else
            echo "    Stack Canary: Disabled"
        fi
        
        # NX
        if readelf -l "$BINARY" 2>/dev/null | grep "GNU_STACK" | grep -q "RWE"; then
            echo "    NX: Disabled (stack executable)"
        else
            echo "    NX: Enabled"
        fi
        
        # PIE
        if file "$BINARY" | grep -q "shared object"; then
            echo "    PIE: Enabled (shared object)"
        elif readelf -h "$BINARY" 2>/dev/null | grep -q "Type:.*EXEC"; then
            echo "    PIE: Disabled (executable)"
        else
            echo "    PIE: Unknown"
        fi
    
    elif file "$BINARY" | grep -q "PE32"; then
        echo -e "\n[+] PE security features:"
        echo "  (Run with PE-bear or CFF Explorer for detailed analysis)"
    fi
    
    # Look for shellcode patterns
    echo -e "\n[+] Shellcode pattern check:"
    
    # Common shellcode patterns
    PATTERNS=(
        "\x31\xc0\x50\x68\x2f\x2f\x73\x68"  # execve x86
        "\x48\x31\xd2\x48\xbb\x2f\x2f\x62"  # execve x64
        "\x90\x90\x90\x90"                  # NOP sled
        "\xcc\xcc\xcc\xcc"                  # INT3 sled
    )
    
    for pattern in "${PATTERNS[@]}"; do
        count=$(grep -a -o -F "$(echo -n -e "$pattern")" "$BINARY" | wc -l)
        if [ $count -gt 0 ]; then
            echo "  [!] Found pattern (count: $count)"
        fi
    done
    
    # Check for XOR patterns (simple entropy check)
    echo -e "\n[+] Simple entropy/encryption detection:"
    
    # Calculate byte frequency
    python3 -c "
import collections
import math
import sys

with open('$BINARY', 'rb') as f:
    data = f.read(4096)  # First 4KB

# Calculate entropy
if len(data) == 0:
    sys.exit(0)
    
freq = collections.Counter(data)
entropy = 0
for count in freq.values():
    p_x = count / len(data)
    entropy += -p_x * math.log2(p_x)

print(f'  Entropy: {entropy:.2f}')
if entropy > 7.0:
    print('  [!] High entropy - possibly encrypted/compressed')
elif entropy < 4.0:
    print('  [ ] Low entropy - likely plain text/code')
else:
    print('  [ ] Normal entropy')
" 2>/dev/null || echo "  [-] Could not calculate entropy"
}

# Run selected analysis
case "$ANALYSIS_TYPE" in
    basic)
        basic_analysis
        ;;
    strings)
        string_analysis
        ;;
    functions)
        function_analysis
        ;;
    imports)
        import_analysis
        ;;
    security)
        security_analysis
        ;;
    full)
        basic_analysis
        string_analysis
        function_analysis
        import_analysis
        security_analysis
        ;;
    *)
        echo "[-] Unknown analysis type: $ANALYSIS_TYPE"
        exit 1
        ;;
esac

# Generate report
echo -e "\n=== ANALYSIS COMPLETE ==="
echo "[+] Analysis saved to: $OUTPUT_DIR/"
echo "[+] Files created:"
ls -la "$OUTPUT_DIR/"

echo -e "\n[+] Quick summary:"
if [ -f "$OUTPUT_DIR/file_type.txt" ]; then
    echo "File type: $(cat "$OUTPUT_DIR/file_type.txt")"
fi
if [ -f "$OUTPUT_DIR/strings_full.txt" ]; then
    echo "Strings found: $(wc -l < "$OUTPUT_DIR/strings_full.txt")"
fi

echo -e "\n[+] Next steps:"
echo "1. Review strings in $OUTPUT_DIR/interesting_strings.txt"
echo "2. Check for suspicious imports"
echo "3. Analyze disassembly if available"
echo "4. Use tools like Ghidra or Radare2 for deeper analysis"

echo -e "\n=== Analysis finished ==="
