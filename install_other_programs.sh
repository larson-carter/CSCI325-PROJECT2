#!/bin/bash

# Color codes
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

# Welcome message
echo -e "${BLUE}Starting installation process...${RESET}"

# Progress bar function
show_progress() {
    local progress=$1
    local completed=$((progress / 2))
    local remaining=$((50 - completed))
    printf "\r${YELLOW}["
    printf "%0.s#" $(seq 1 $completed)
    printf "%0.s " $(seq 1 $remaining)
    printf "] ${progress}%% ${RESET}"
}

# Install function with progress and color
install_package() {
    local package=$1
    echo -e "${GREEN}Installing ${package}...${RESET}"
    sudo apt-get install -y "$package" >/dev/null 2>&1 &
    local pid=$!
    local progress=0
    while kill -0 "$pid" 2>/dev/null; do
        show_progress "$progress"
        sleep 0.1
        progress=$((progress + 1))
        if [ "$progress" -gt 100 ]; then progress=0; fi
    done
    wait "$pid"
    echo -e "\n${GREEN}${package} installed successfully!${RESET}\n"
}

# Update and install packages
echo -e "${GREEN}Updating package lists...${RESET}"
sudo apt-get update >/dev/null 2>&1 &
pid=$!
progress=0
while kill -0 "$pid" 2>/dev/null; do
    show_progress "$progress"
    sleep 0.1
    progress=$((progress + 1))
    if [ "$progress" -gt 100 ]; then progress=0; fi
done
wait "$pid"
echo -e "\n${GREEN}Update complete!${RESET}\n"

# Install each package
packages=("apparmor" "ufw" "snort" "ubuntu-advantage-tools")
for package in "${packages[@]}"; do
    install_package "$package"
done

# Clear the terminal before the final message
clear

# Completion message
echo -e "${BLUE}All packages have been installed successfully!${RESET}\n"