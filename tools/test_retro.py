#!/usr/bin/env python3

import sys
import time
from datetime import datetime

def print_color(text, color):
    """Print text in specified color"""
    print(f"\033[{color}m{text}\033[0m")

def retro_boot_sequence():
    """Simulate a retro computer boot sequence"""
    print("\033[2J\033[H")  # Clear screen
    
    print_color("RETRO LEGENDS TERMINAL TEST SEQUENCE", "1;32")
    print_color("=====================================", "1;32")
    print(f"Current Time: {datetime.now().strftime('%H:%M:%S')}\n")
    
    # Simulate memory check
    print_color("MEMORY CHECK:", "33")
    for i in range(0, 65536, 16384):
        print_color(f"Testing RAM at 0x{i:04X}... OK", "36")
        time.sleep(0.2)
    
    # Color test pattern
    print("\nCOLOR TEST PATTERN:")
    print_color("■ Standard Green (VT100 P1)", "32")
    print_color("■ Amber Alert (Wyse 60)", "33")
    print_color("■ Error Red (Commodore 64)", "31")
    print_color("■ IBM Blue (3278)", "34")
    print_color("■ System Purple (Kaypro)", "35")
    print_color("■ Info Cyan (Osborne 1)", "36")
    
    # Bright variants
    print("\nENHANCED PHOSPHOR STATES:")
    print_color("■ Bright Green", "1;32")
    print_color("■ Bright Amber", "1;33")
    print_color("■ Bright Red", "1;31")
    print_color("■ Bright Blue", "1;34")
    print_color("■ Bright Purple", "1;35")
    print_color("■ Bright Cyan", "1;36")
    
    # Simulated system status
    print("\nSYSTEM STATUS:")
    print_color("✓ SYSTEM READY", "1;32")
    print_color("! DISK DRIVE WARMING UP", "1;33")
    print_color("× NO PRINTER DETECTED", "1;31")
    print_color("? CHECKING NETWORK", "1;34")
    
    # Loading animation
    print("\nLOADING SYSTEM FILES:")
    for _ in range(20):
        for char in "■□▪▫":
            sys.stdout.write(f"\r\033[32m{char} Processing...")
            sys.stdout.flush()
            time.sleep(0.1)
    print_color("\r✓ System Ready!", "1;32")
    
    # File listing simulation
    print("\nDIRECTORY LISTING:")
    print_color("AUTOEXEC.BAT", "1;33")
    print_color("CONFIG  .SYS", "1;33")
    print_color("COMMAND .COM", "1;32")
    print_color("README  .TXT", "1;37")
    
    # Error message test
    print("\nDIAGNOSTIC MESSAGES:")
    print_color("ERROR: Drive A: not responding", "1;31")
    print_color("WARNING: System clock not set", "1;33")
    print_color("INFO: Terminal speed 9600 baud", "1;36")
    print_color("SUCCESS: POST completed", "1;32")
    
    # Final status
    print("\nTERMINAL TEST COMPLETE")
    print_color("====================", "1;32")
    print_color("All colors functioning within normal parameters", "32")
    print_color("Ready for input_", "1;32")

if __name__ == "__main__":
    retro_boot_sequence()