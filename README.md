# Automated Ubuntu Kernel Build Script

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [System Requirements](#system-requirements)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Script Workflow](#script-workflow)
- [Output](#output)
- [Troubleshooting](#troubleshooting)
- [Notes](#notes)
- [License](#license)
- [Contact](#contact)

## Introduction
This bash script automates the process of building the Ubuntu kernel from source. It simplifies tasks such as installing necessary packages, cloning the kernel repository, editing configuration files, and compiling the kernel. With colorized output and loading animations, the script provides a user-friendly experience.

## Features
- **System Requirement Checks**: Validates that the system meets minimum disk space, CPU, and RAM requirements.
- **Interactive User Input**: Prompts for the user's last name to personalize the kernel build.
- **Automated Package Management**: Installs and verifies all necessary packages for building the kernel.
- **Customized Kernel Version**: Modifies the kernel version in the changelog with the user's last name.
- **Colorized Output and Loading Animations**: Enhances readability and provides visual feedback during execution.
- **Error Handling**: Exits gracefully with informative messages if any step fails.

## System Requirements
Before running the script, ensure your system meets the following requirements:
- **Disk Space**: At least 75 GB of free disk space.
- **CPU Cores**: Minimum of 3 CPU cores.
- **RAM**: At least 8 GB of RAM.
- **Operating System**: Ubuntu (compatible with the 'noble' kernel source).

## Prerequisites
- **sudo Privileges**: The script requires administrative rights to install packages and modify system files.
- **Internet Connection**: Necessary for downloading packages and cloning repositories.

## Installation

1. **Make sure you have git installed**:
    ```
    sudo apt update -y && sudo apt install -y git
    ```
    **NOTE: This will take about 3 minutes**
2. **Clone the Repository**: 
    ```bash
    git clone https://github.com/larson-carter/CSCI325-PROJECT2 && cd CSCI325-PROJECT2
    ```
    **NOTE: This can take a while depending on internet speeds**
3. **Make the Script Executable**:
    ```bash
    chmod +x *.sh
    ```
4. **Run the Script Executable for Building Kernel**:
    **This took exactly one hour on my macine**
    ```bash
    ./build_kernel.sh
    ```
     **NOTE: This will take a while depends on computer resources**
5. **Run the Script Executable for Modifying GRUB Settings and installing the new custom kernel**:
    ```bash
    sudo ./install_custom_kernel_and_modify_grub.sh
    ```
    **NOTE: Your system will need to restart**

    **Select Advanced options for Ubuntu>Ubuntu, with Linux 6.8.0-30-generic when you are booting back up**

    **IF you need to revert the above changes:**
    ```bash
    sudo cp /etc/default/grub.backup.[timestamp] /etc/default/grub
    sudo update-grub
    ```
6. **Navigate back to project Directory**:
    ```bash
    cd CSCI325-PROJECT2
    ```
7. **Run the Script Executable for Installing Other Programs**:
    **This took around 2-3 minutes on my machine**
    ```bash
    sudo ./install_other_programs.sh
    ```
     **NOTE: This will take about 5 minutes**
8. **Run the Script Executable for File Permissions**:
    ```bash
    ./create_example_file.sh
    ```
9. **Run the Script Executable for Showing all Project Requirements**:
    ```bash
    ./show_all_required_commands.sh
    ```