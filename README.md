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

**Make sure you have git installed**
    ```
    sudo apt update -y &&
    sudo apt install -y git
    ```

1. **Clone the Repository**: 
    ```bash
    git clone https://github.com/larson-carter/CSCI325-PROJECT2
    ```
2. **Navigate to the Script Directory**:
    ```bash
    cd CSCI325-PROJECT2
    ```
3. **Make the Script Executable**:
    ```bash
    chmod +x build_kernel.sh
    ```

4. **Run the Script Executable for Building Kernel**:
    ```bash
    ./build_kernel.sh
    ```

5. **Make the Script Executable**:
    ```bash
    chmod +x install_other_programs.sh
    ```

6. **Run the Script Executable for Building Kernel**:
    ```bash
    ./install_other_programs.sh
    ```
