#!/bin/bash

# install_deps.sh - Install dependencies for vifm configuration
# This script installs all the tools needed for the vifm configuration to work properly

# Text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Homebrew is installed
check_brew() {
  if ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew is not installed.${NC}"
    echo -e "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH if needed
    if [[ $(uname -m) == "arm64" ]]; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo -e "${GREEN}Homebrew is already installed.${NC}"
  fi
}

# Check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Install a package if it's not already installed
install_package() {
  local package=$1
  local command=${2:-$1}
  
  echo -e "${BLUE}Checking for ${package}...${NC}"
  
  if command_exists "$command"; then
    echo -e "${GREEN}${package} is already installed.${NC}"
  else
    echo -e "${YELLOW}Installing ${package}...${NC}"
    brew install "$package"
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}${package} installed successfully.${NC}"
    else
      echo -e "${RED}Failed to install ${package}.${NC}"
    fi
  fi
}

# Main installation process
main() {
  echo -e "${BLUE}=== Installing dependencies for vifm configuration ===${NC}"
  
  # Check and install Homebrew first
  check_brew
  
  # Update Homebrew
  echo -e "${BLUE}Updating Homebrew...${NC}"
  brew update
  
  # Install core dependencies
  install_package "exa"
  install_package "glow"
  install_package "highlight"
  install_package "xsv"
  install_package "fuse-zip"
  install_package "unzip"
  install_package "unrar"
  install_package "hexdump" "hexdump"
  install_package "imagemagick" "convert"
  install_package "poppler" "pdfinfo"
  install_package "ffmpegthumbnailer" "ffmpegthumbnailer"
  
  # Check for visualpreview script
  if [ -f "$HOME/.config/vifm/scripts/visualpreview" ]; then
    echo -e "${GREEN}visualpreview script is already present.${NC}"
  else
    echo -e "${YELLOW}Warning: visualpreview script not found in ~/.config/vifm/scripts/${NC}"
    echo -e "Make sure to install or create this script for visual previews to work."
  fi
  
  echo -e "\n${GREEN}=== Installation complete! ===${NC}"
  echo -e "You may need to restart vifm for all changes to take effect."
}

# Run the main function
main
