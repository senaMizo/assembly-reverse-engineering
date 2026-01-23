#!/usr/bin/env python3
"""
GDB Helper Scripts for Reverse Engineering
"""

import gdb
import re

class ReverseEngineeringHelpers(gdb.Command):
    """Custom GDB commands for reverse engineering"""
    
    def __init__(self):
        super(ReverseEngineeringHelpers, self).__init__("re", gdb.COMMAND_USER)
    
    def invoke(self, args, from_tty):
        print("Reverse Engineering Commands:")
        print("  re strings           - Search for strings in memory")
        print("  re xorsearch <key>   - Search for XOR encrypted data")
        print("  re antidebug         - Check for anti-debug techniques")
        print("  re imports           - List imported functions")
        print("  re exports           - List exported functions")

class SearchStrings(gdb.Command):
    """Search for ASCII strings in memory"""
    
    def __init__(self):
        super(SearchStrings, self).__init__("search-strings", gdb.COMMAND_USER)
    
    def invoke(self, args, from_tty):
        args = gdb.string_to_argv(args)
        if len(args) != 2:
            print("Usage: search-strings <start_addr> <end_addr>")
            return
        
        start = int(args[0], 16)
        end = int(args[1], 16)
        
        # Read memory
        try:
            memory = gdb.selected_inferior().read_memory(start, end - start)
            data = memory.tobytes()
            
            # Search for strings
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
            
            # Print results
            for s in strings[:20]:  # Limit output
                print(f"String: {s}")
            
            if len(strings) > 20:
                print(f"... and {len(strings) - 20} more strings")
                
        except gdb.MemoryError as e:
            print(f"Memory read error: {e}")

class CheckAntiDebug(gdb.Command):
    """Check for anti-debug techniques"""
    
    def __init__(self):
        super(CheckAntiDebug, self).__init__("check-antidebug", gdb.COMMAND_USER)
    
    def invoke(self, args, from_tty):
        print("[*] Checking for anti-debug techniques...")
        
        # Check ptrace
        print("\n[+] Checking ptrace calls...")
        gdb.execute("info functions ptrace")
        
        # Check /proc/self/status
        print("\n[+] Checking /proc access...")
        gdb.execute("
