#!/bin/bash

# This script installs the custom kernel packages, modifies GRUB settings, and updates GRUB.

# Ensure the script is run with sudo privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with sudo privileges (e.g., sudo ./install_custom_kernel_and_modify_grub.sh)"
  exit
fi

echo "========================================"
echo "Step 1: Installing the Custom Kernel Packages"
echo "========================================"

# Navigate to the directory containing the kernel packages
echo "Navigating to the directory where the kernel packages are located..."
# Adjust the path if your .deb files are in a different location
cd ..

# Check for kernel package files
kernel_image=$(ls linux-image-*.deb 2>/dev/null)
kernel_headers=$(ls linux-headers-*.deb 2>/dev/null)

if [ -z "$kernel_image" ] || [ -z "$kernel_headers" ]; then
  echo "Error: Kernel package files not found."
  echo "Please ensure you have built the kernel and the .deb files are present in the directory."
  exit 1
fi

# Install the custom kernel packages
echo "Installing the custom kernel packages..."
dpkg -i linux-image-*.deb linux-headers-*.deb

if [ $? -ne 0 ]; then
  echo "Error occurred during kernel package installation."
  exit 1
fi

echo "Custom kernel installation is complete."

echo ""
echo "========================================"
echo "Step 2: Modifying GRUB Configuration"
echo "========================================"

# Backup the current GRUB configuration
backup_file="/etc/default/grub.backup.$(date +%F-%T)"
cp /etc/default/grub "$backup_file"
echo "Backed up /etc/default/grub to $backup_file"

# Modify GRUB_TIMEOUT_STYLE from 'hidden' to 'menu'
sed -i 's/^GRUB_TIMEOUT_STYLE=hidden/GRUB_TIMEOUT_STYLE=menu/' /etc/default/grub

# Modify GRUB_TIMEOUT from '0' to '100'
sed -i 's/^GRUB_TIMEOUT=0/GRUB_TIMEOUT=100/' /etc/default/grub

echo "Modified GRUB_TIMEOUT_STYLE and GRUB_TIMEOUT in /etc/default/grub"

echo ""
echo "========================================"
echo "Step 3: Updating GRUB"
echo "========================================"

# Update GRUB configuration
update-grub
echo "GRUB configuration has been updated."

echo ""
echo "All steps completed successfully."

# Prompt the user to reboot
read -p "Do you want to reboot now to apply the changes and boot into your custom kernel? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Rebooting the system..."
    reboot
else
    echo "Please remember to reboot later to boot into the custom kernel."
fi
