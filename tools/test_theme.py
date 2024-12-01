#!/usr/bin/env python3

import time
from datetime import datetime

def print_with_color(text, color_code):
    """Print text with specified color code"""
    print(f"\033[{color_code}m{text}\033[0m")

def main():
    # Clear screen
    print("\033[2J\033[H")
    
    # Header
    print("\n=== RetroFusion Theme Test ===")
    print("Current time:", datetime.now().strftime("%H:%M:%S"))
    
    # Basic colors test
    print("\n=== Standard Colors (Base P1 Green) ===")
    print_with_color("Standard Green Text (Base P1 Phosphor)", "32")
    print_with_color("Amber Alert (P3 Phosphor)", "33")
    print_with_color("Error Message (Red)", "31")
    print_with_color("Info Message (Cool White)", "34")
    print_with_color("Special Note (Magenta)", "35")
    print_with_color("System Message (Cyan)", "36")
    
    # Bright variants
    print("\n=== Enhanced Phosphor Colors ===")
    print_with_color("Bright Green (Enhanced P1)", "1;32")
    print_with_color("Bright Amber (Enhanced P3)", "1;33")
    print_with_color("Critical Alert (Enhanced Red)", "1;31")
    print_with_color("Bright Cool White", "1;34")
    
    # File system simulation
    print("\n=== Directory Listing ===")
    print_with_color("drwxr-xr-x  user  group   ", "34")
    print_with_color("Documents/", "1;34")
    print_with_color("-rw-r--r--  user  group   ", "32")
    print_with_color("README.md", "0")
    print_with_color("-rwxr-xr-x  user  group   ", "32")
    print_with_color("script.sh", "1;32")
    
    # Git status simulation
    print("\n=== Git Status (Multi-Phosphor Display) ===")
    print_with_color("On branch ", "36")
    print_with_color("main", "1;36")
    print_with_color("Your branch is up to date with 'origin/main'", "32")
    print_with_color("Modified:   ", "33")
    print_with_color("src/main.py", "0")
    print_with_color("Added:      ", "32")
    print_with_color("docs/README.md", "0")
    print_with_color("Deleted:    ", "31")
    print_with_color("old/script.js", "0")
    
    # Loading animation
    print("\n=== Classic Terminal Loading ===")
    for _ in range(10):
        for char in "|/-\\":
            print(f"\r\033[32mProcessing... {char}", end="", flush=True)
            time.sleep(0.1)
    print("\r\033[32mComplete!      ")
    
    # System messages
    print("\n=== System Messages ===")
    print_with_color("ERROR: Could not connect to server", "1;31")
    print_with_color("WARNING: Disk space is running low", "1;33")
    print_with_color("INFO: Background tasks completed", "1;34")
    print_with_color("SUCCESS: All tests passed", "1;32")
    
    print("\n=== Test Complete ===")

if __name__ == "__main__":
    main()