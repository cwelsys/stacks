# Komodo Periphery Setup

This guide will help you set up Komodo Periphery with 1Password integration.

## Prerequisites

- Python 3
- 1Password CLI

## Installation Steps

1. **Install 1Password CLI**

   Follow the official instructions to install the 1Password CLI:
   https://1password.com/downloads/command-line/

   ```bash
   # For Debian/Ubuntu:
   sudo apt-get update && sudo apt-get install 1password-cli
   
   # For macOS with Homebrew:
   brew install 1password-cli
   ```

2. **Sign in to 1Password**

   Before running the setup script, you need to authenticate with 1Password:

   ```bash
   op signin
   ```

   Follow the prompts to complete the authentication process.

3. **Make the script executable**

   ```bash
   chmod +x init_komodo.sh
   ```

4. **Run the installation script**

   ```bash
   ./init_komodo.sh
   ```

   The script will check for prerequisites, install Komodo Periphery, and configure it with your 1Password secrets.

