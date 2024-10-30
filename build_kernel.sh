#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print messages with colors
print_message() {
    echo -e "${BLUE}$1${NC}"
}

# Function to display a loading bar
loading() {
    echo -ne "${YELLOW}$1"
    for ((i=0; i<3; i++)); do
        echo -ne "."
        sleep 0.5
    done
    echo -e "${NC}"
}

# Check Disk Space (75GB+)
available_space=$(df --output=avail -BG / | tail -1 | tr -dc '0-9')
if [ "$available_space" -lt 75 ]; then
    echo -e "${RED}Error: At least 75GB of free disk space is required.${NC}"
    exit 1
fi

# Check CPU Cores (3+)
cpu_cores=$(nproc)
if [ "$cpu_cores" -lt 3 ]; then
    echo -e "${RED}Error: At least 3 CPU cores are required.${NC}"
    exit 1
fi

# Check RAM (8GB+)
total_ram=$(free -g | awk '/^Mem:/{print $2}')
if [ "$total_ram" -lt 8 ]; then
    echo -e "${RED}Error: At least 8GB of RAM is required.${NC}"
    exit 1
fi

# Print Welcome Message
print_message "Welcome, $USER"

# Starting Package Install
loading "Starting Package Install"
sudo apt update -y
sudo apt install -y git

# Cloning Repo into ~/noble
loading "Cloning Repo into ~/noble"
git clone --depth 1 git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble ~/noble
cd ~/noble || { echo -e "${RED}Failed to enter ~/noble directory.${NC}"; exit 1; }

# Ask the user for their last name
read -rp "Please enter your last name: " last_name

# Replace line 1 in debian.master/changelog
sed -i "1s/.*/linux (6.8.0-30.30+${last_name}Project2) noble; urgency=medium/" debian.master/changelog

# Editing Sources
loading "Editing Sources"
sudo tee /etc/apt/sources.list.d/ubuntu.sources > /dev/null <<EOF
Types: deb deb-src
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb deb-src
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF

# Updating Sources
loading "Updating Sources"
sudo apt-get update -y
sudo apt-get upgrade -y

# Installing Packages
loading "Installing Packages"
sudo apt-get build-dep -y linux
sudo apt-get install -y fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

# Check required packages
required_packages=(
    "fakeroot"
    "build-essential"
#    "ncurses-dev"
    "xz-utils"
    "libssl-dev"
    "bc"
    "flex"
    "libelf-dev"
    "bison"
)

for pkg in "${required_packages[@]}"; do
    dpkg -s "$pkg" &> /dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Package $pkg is not installed.${NC}"
        exit 1
    fi
done

# Cleaning Build Directory
loading "Cleaning Build Directory"
fakeroot debian/rules clean

# Optimizing Build
loading "Optimizing Build"
export DEB_BUILD_OPTIONS=parallel=$(nproc)

# Building Kernel
loading "Building Kernel"
fakeroot debian/rules binary

echo -e "${GREEN}Kernel build completed successfully!${NC}"