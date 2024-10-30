#!/bin/bash

# This script displays the required commands and their outputs for project verification.

# Display Ubuntu version
echo "========================================"
echo "Ubuntu Version:"
echo "========================================"
echo "$ lsb_release -a"
lsb_release -a
echo ""

# Display Kernel version
echo "========================================"
echo "Kernel Version:"
echo "========================================"
echo "$ uname -a"
uname -a
echo ""

# Display locations of installed programs
echo "========================================"
echo "Locations of Installed Programs:"
echo "========================================"

# AppArmor
echo "$ which apparmor_parser"
echo -n "AppArmor: "
which apparmor_parser 2>/dev/null || whereis apparmor
echo ""

# ufw
echo "$ which ufw"
echo -n "ufw: "
which ufw 2>/dev/null || whereis ufw
echo ""

# Snort
echo "$ which snort"
echo -n "Snort: "
which snort 2>/dev/null || whereis snort
echo ""

# Ubuntu Advantage Tools
echo "$ which ua"
echo -n "Ubuntu Advantage Tools (ua): "
which ua 2>/dev/null || whereis ua
echo ""

# Display permissions of exampleFile.txt
echo "========================================"
echo "Permissions of exampleFile.txt:"
echo "========================================"
echo "$ ls -la ~/Desktop/exampleFile.txt"
ls -la ~Desktop/exampleFile.txt
echo ""
