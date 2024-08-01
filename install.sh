#!/bin/bash

# Colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

prompt_yes_no() {
  while true; do
    read -p "$1 (yes/no): " yn
    case $yn in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Please answer yes or no.";;
    esac
  done
}
pkg updated

clear
echo -e "${CYAN}"
echo " ██╗ ██████╗    ██████╗ ██████╗ ███╗  ███╗██████╗ "
echo " ██║██╔═══██╗  ██╔════╝██╔═══██╗████╗ ████║██╔══██╗"
echo " ██║██║   ██║  ██║    ██║   ██║██╔████╔██║██████╔╝"
echo " ██║██║   ██║  ██║    ██║   ██║██║╚██╔╝██║██╔═══╝ "
echo " ██║╚██████╔╝  ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║    "
echo " ╚═╝ ╚═════╝    ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝   ILER "
echo "                       by t.me/PanditSiddharth"
echo -e "${NC}"
sleep 3


# Check if Node.js is installed
if command -v node > /dev/null 2>&1; then
    echo "${GREEN}Node.js is already installed. Version: $(node -v)${NC}"
else
    # Install Node.js
    echo -e "${YELLOW}Installing Node.js...${NC}"
    pkg install nodejs -y
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Node.js installed successfully${NC}"
    else
      echo -e "${RED}Failed to install Node.js.${NC}"
      exit 1
    fi
    sleep 2
fi

# Check if python is installed
if command -v python > /dev/null 2>&1; then
    echo "${GREEN}Python is already installed. Version: $(python --version)${NC}"
else
   # Prompt for Python3 installation
    if prompt_yes_no "Do you want to install Python3?"; then
        echo -e "${YELLOW}Installing Python3...${NC}"
        pkg install python3 -y
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Python3 installed successfully${NC}"
        else
            echo -e "${RED}Failed to install Python3.${NC}"
        fi
    else
        echo -e "${CYAN}Skipping Python3 installation.${NC}"
    fi
    sleep 1
fi

# Check if Java is installed
if command -v java > /dev/null 2>&1; then
    echo "${GREEN}Java is already installed. Version: $(java --version)${NC}"
else
  # Prompt for Java installation
  if prompt_yes_no "Do you want to install Java for Termux?"; then
    echo -e "${YELLOW}Installing Java...${NC}"
    pkg install openjdk-20 -y
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Java installed successfully${NC}"
    else
      echo -e "${RED}Failed to install Java.${NC}"
    fi
  else
    echo -e "${CYAN}Skipping Java installation.${NC}"
  fi
  sleep 1
fi

# Check if Go is installed
if command -v go > /dev/null 2>&1; then
    echo "${GREEN}Go is already installed. Version: $(go version)${NC}"
else
  # Prompt for Go installation
  if prompt_yes_no "Do you want to install Go?"; then
    echo -e "${YELLOW}Installing Go...${NC}"
    pkg install golang -y
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Go installed successfully${NC}"
    else
      echo -e "${RED}Failed to install Go.${NC}"
    fi
  else
    echo -e "${CYAN}Skipping Go installation.${NC}"
  fi
  sleep 1
fi

# Check for existing compiler folder
if [ -d "~/compiler" ]; then
  if prompt_yes_no "A compiler folder already exists. Do you want to override it?"; then
    echo -e "${YELLOW}Removing existing compiler folder...${NC}"
    rm -rf ~/compiler
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Existing compiler folder removed${NC}"
    else
      echo -e "${RED}Failed to remove existing compiler folder.${NC}"
      exit 1
    fi
  fi
fi
sleep 1

# Create compiler directory and set up the project
echo -e "${YELLOW}Creating compiler directory and setting up the project...${NC}"
mkdir -p ~/compiler
cd ~/compiler
npm init -y
npm install iocompiler
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Compiler directory created and project set up successfully${NC}"
else
  echo -e "${RED}Failed to set up the project.${NC}"
  exit 1
fi
sleep 1

# Prompt for Telegram bot token and allowed user IDs
read -p "Please enter your Telegram bot token: " bot_token
read -p "Please enter allowed Telegram user IDs (comma-separated): " user_ids

# Generate the bot script
echo -e "${YELLOW}Generating bot script...${NC}"
cat > index.js <<EOL
const { compiler } = require('iocompiler');

// Specify allowed users; without this, all users can access your bot
const { bot } = compiler('${bot_token}', { allowed: [${user_ids}] });

// Launching Telegraf bot in polling mode
bot.launch({ dropPendingUpdates: true });
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Bot script generated successfully${NC}"
else
  echo -e "${RED}Failed to generate bot script.${NC}"
  exit 1
fi
sleep 1

# Completion message
echo -e "${CYAN}IO Compiler installation process is done.${NC}"
echo -e "${CYAN}Thank you for using our installer${NC}"
