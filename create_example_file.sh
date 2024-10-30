#!/bin/bash

# This script creates exampleFile.txt and sets specific permissions in the current directory.

# Create exampleFile.txt in the current directory
touch exampleFile.txt

# Set the required permissions
chmod u=rwx,g=wx,o=r exampleFile.txt

# Display the permissions of the file
echo "========================================"
echo "Permissions of exampleFile.txt:"
echo "========================================"
echo "$ ls -la exampleFile.txt"
ls -la exampleFile.txt
