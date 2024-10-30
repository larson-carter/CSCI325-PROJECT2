#!/bin/bash

# This script modifies the GRUB configuration to display the menu and set the timeout to 100 seconds.

# Ensure the script is run with sudo privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with sudo privileges (e.g., sudo ./modify_grub.sh)"
  exit
fi

# Backup the current GRUB configuration
backup_file="/etc/default/grub.backup.$(date +%F-%T)"
cp /etc/default/grub "$backup_file"
echo "Backed up /etc/default/grub to $backup_file"

# Modify GRUB_TIMEOUT_STYLE from 'hidden' to 'menu'
sed -i 's/^GRUB_TIMEOUT_STYLE=hidden/GRUB_TIMEOUT_STYLE=menu/' /etc/default/grub

# Modify GRUB_TIMEOUT from '0' to '100'
sed -i 's/^GRUB_TIMEOUT=0/GRUB_TIMEOUT=100/' /etc/default/grub

echo "Modified GRUB_TIMEOUT_STYLE and GRUB_TIMEOUT in /etc/default/grub"

# Update GRUB configuration
update-grub
echo "GRUB configuration has been updated."

# Prompt the user to reboot
read -p "Do you want to reboot now to apply the changes? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Rebooting the system..."
    reboot
else
    echo "Please remember to reboot later to apply the GRUB configuration changes."
fi
