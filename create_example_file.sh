#!/bin/bash

# This script creates exampleFile.txt and sets specific permissions in the current directory.

# Create exampleFile.txt
touch ~/Desktop/exampleFile.txt

# Set the required permissions
sudo chmod u=rwx,g=wx,o=r ~/Desktop/exampleFile.txt

# Display the permissions of the file
echo "========================================"
echo "Permissions of exampleFile.txt:"
echo "========================================"
echo "$ ls -la ~/Desktop/exampleFile.txt"
ls -la ~/Desktop/exampleFile.txt