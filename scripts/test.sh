#!/bin/bash
# Test script for assembly reverse engineering examples

set -e

echo "=== Testing Assembly Reverse Engineering Examples ==="

# Check if build directory exists
if [ ! -d "build" ]; then
    echo "[-] Build directory not found. Run build.sh first."
    exit 1
fi

cd build

# Test x86_64 binaries
echo -e "\n[+] Testing x86_64 binaries..."

test_binary() {
    local binary=$1
    local expected=$2
    
    if [ ! -f "$binary" ]; then
        echo "  [-] $binary not found"
        return 1
    fi
    
    echo -n "  [+] Testing $binary... "
    
    # Check file type
    file_type=$(file "$binary")
    if [[ "$file_type" == *"ELF"* ]]; then
        echo -n "ELF ✓ "
    else
        echo -n "File type mismatch ✗ "
        return 1
    fi
    
    # Check if executable
    if [ -x "$binary" ]; then
        echo -n "Executable ✓ "
    else
        echo -n "Not executable ✗ "
        return 1
    fi
    
    # Try to run (timeout after 2 seconds)
    timeout 2s "./$binary" >/dev/null 2>&1
    local exit_code=$?
    
    if [ $exit_code -eq 0 ] || [ $exit_code -eq 124 ]; then
        echo "Runs ✓"
        return 0
    elif [ $exit_code -eq 127 ]; then
        echo "Missing dependencies ✗"
        return 1
    else
        echo "Error: $exit_code ✗"
        return 1
    fi
}

# Test individual binaries
test_binary "x86_64/hello_world"
test_binary "x86_64/registers_demo"
test_binary "x86_64/ptrace_check"
test_binary "x86_64/timing_attack"

# Test C examples
echo -e "\n[+] Testing C examples..."

test_c_example() {
    local binary=$1
    local test_input=$2
    local expected_output=$3
    
    if [ ! -f "$binary" ]; then
        echo "  [-] $binary not found"
        return 1
    fi
    
    echo -n "  [+] Testing $binary... "
    
    # Run with test input
    output=$(timeout 2s "./$binary" "$test_input" 2>&1 || true)
    
    if echo "$output" | grep -q "$expected_output"; then
        echo "Pass ✓"
        return 0
    else
        echo "Fail ✗"
        echo "    Output: $output"
        echo "    Expected: $expected_output"
        return 1
    fi
}

# Test crackme
test_c_example "c_examples/crackme1" "reverse_me_123" "Congratulations"
test_c_example "c_examples/crackme1" "wrong_password" "Wrong password"

# Test Python tools
echo -e "\n[+] Testing Python tools..."

test_python_tool() {
    local script=$1
    local test_args=$2
    
    if [ ! -f "$script" ]; then
        echo "  [-] $script not found"
        return 1
    fi
    
    echo -n "  [+] Testing $script... "
    
    # Check if Python 3 is available
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found ✗"
        return 1
    fi
    
    # Test with --help or basic functionality
    if python3 "$script" --help >/dev/null 2>&1; then
        echo "Help works ✓"
        return 0
    elif python3 "$script" $test_args >/dev/null 2>&1; then
        echo "Runs ✓"
        return 0
    else
        echo "Error ✗"
        return 1
    fi
}

test_python_tool "c_examples/advanced_disasm.py" "--help"
test_python_tool "c_examples/pattern_finder.py" "--help"
test_python_tool "c_examples/simple_unpacker.py" "--help"

# Test shellcode runner
echo -e "\n[+] Testing shellcode runner..."
if [ -f "c_examples/shellcode_runner" ]; then
    echo -n "  [+] Testing shellcode_runner... "
    
    # Run in background and kill quickly (since it tries to exec shell)
    timeout 0.1s ./c_examples/shellcode_runner >/dev/null 2>&1
    local exit_code=$?
    
    if [ $exit_code -eq 124 ] || [ $exit_code -eq 139 ]; then
        # Timeout or segfault (expected for shellcode)
        echo "Runs (as expected) ✓"
    else
        echo "Exit code: $exit_code ✗"
    fi
fi

# Security checks
echo -e "\n[+] Running security checks..."

check_security() {
    local binary=$1
    
    if [ ! -f "$binary" ]; then
        return
    fi
    
    echo -n "  [+] Checking $binary... "
    
    # Check for security features
    if readelf -l "$binary" 2>/dev/null | grep -q "GNU_STACK.*RWE"; then
        echo "WARNING: Stack is executable!"
    elif readelf -l "$binary" 2>/dev/null | grep -q "GNU_STACK"; then
        echo "Stack protection ✓"
    else
        echo "No stack info"
    fi
}

check_security "x86_64/shellcode_execve"
check_security "c_examples/shellcode_runner"

# Final summary
echo -e "\n=== Test Summary ==="
echo "Tests completed. Check output above for any failures."

# List all built files
echo -e "\nBuilt files:"
find . -type f -executable ! -name "*.py" | sort
find . -name "*.py" -executable | sort

echo -e "\nTo run any example:"
echo "  cd build && ./path/to/binary"
echo "  cd build && python3 path/to/script.py"
