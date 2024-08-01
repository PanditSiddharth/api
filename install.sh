#!/bin/bash

# Colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to prompt the user for a yes/no response
prompt_yes_no() {
  while true; do
    read -p "$1 (y/n): " yn
    case $yn in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo -e "${RED}Please answer yes or no.${NC}";;
    esac
  done
}

# Animated printing function
print_animated() {
  message=$1
  for (( i=0; i<${#message}; i++ )); do
    echo -n "${message:$i:1}"
    sleep 0.02
  done
  echo ""
}

# Welcome message
clear
print_animated "${CYAN}Welcome to the IO Compiler Installation Script!${NC}"
print_animated "${CYAN}Let's get started...${NC}"
sleep 1

# Install Node.js
print_animated "${YELLOW}Installing Node.js...${NC}"
pkg install nodejs -y
print_animated "${GREEN}Node.js installed successfully!${NC}"
sleep 1

# Prompt for Python3 installation
if prompt_yes_no "Do you want to install Python3?"; then
  print_animated "${YELLOW}Installing Python3...${NC}"
  pkg install python3 -y
  print_animated "${GREEN}Python3 installed successfully!${NC}"
else
  print_animated "${CYAN}Skipping Python3 installation.${NC}"
fi
sleep 1

# Prompt for Java installation
if prompt_yes_no "Do you want to install Java for Termux?"; then
  print_animated "${YELLOW}Installing Java...${NC}"
  pkg install openjdk-17 -y
  print_animated "${GREEN}Java installed successfully!${NC}"
else
  print_animated "${CYAN}Skipping Java installation.${NC}"
fi
sleep 1

# Prompt for Go installation
if prompt_yes_no "Do you want to install Go?"; then
  print_animated "${YELLOW}Installing Go...${NC}"
  pkg install golang -y
  print_animated "${GREEN}Go installed successfully!${NC}"
else
  print_animated "${CYAN}Skipping Go installation.${NC}"
fi
sleep 1

# Check for existing compiler folder
if [ -d "compiler" ]; then
  if prompt_yes_no "A compiler folder already exists. Do you want to override it?"; then
    print_animated "${YELLOW}Removing existing compiler folder...${NC}"
    rm -rf compiler
    print_animated "${GREEN}Existing compiler folder removed!${NC}"
  else
    print_animated "${CYAN}Skipping removal of existing compiler folder.${NC}"
  fi
fi
sleep 1

# Create compiler directory and set up the project
print_animated "${YELLOW}Creating compiler directory and setting up the project...${NC}"
mkdir -p compiler
cd compiler
npm init -y
npm install iocompiler
print_animated "${GREEN}Compiler directory created and project set up successfully!${NC}"
sleep 1

# Prompt for Telegram bot token and allowed user IDs
read -p "Please enter your Telegram bot token: " bot_token
read -p "Please enter allowed Telegram user IDs (comma-separated): " user_ids

# Generate the bot script
print_animated "${YELLOW}Generating bot script...${NC}"
cat > bot.js <<EOL
const { compiler } = require('iocompiler');

// Specify allowed users; without this, all users can access your bot
const { bot } = compiler('${bot_token}', { allowed: [${user_ids}] });

// Launching Telegraf bot in polling mode
bot.launch({ dropPendingUpdates: true });
EOL
print_animated "${GREEN}Bot script generated successfully!${NC}"
sleep 1

# Completion message
print_animated "${CYAN}IO Compiler installation process is done.${NC}"
print_animated "${CYAN}Thank you for using our installer!${NC}"
