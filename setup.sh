#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rmakoni <rmakoni@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+              #
#    Created: 2025/07/30 15:30:00 by rmakoni           #+#    #+#               #
#    Updated: 2025/07/30 15:30:00 by rmakoni          ###   ########.fr         #
#                                                                              #
# **************************************************************************** #

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Inception Environment Setup${NC}"
echo -e "${BLUE}================================${NC}"

# Function to check if running in WSL
is_wsl() {
    if [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
        return 0  # true - is WSL
    else
        return 1  # false - not WSL
    fi
}

# Function to add domain to hosts file
add_to_hosts() {
    local hosts_file=$1
    local domain_line="127.0.0.1 rmakoni.42.fr www.rmakoni.42.fr"
    
    if grep -q "rmakoni.42.fr" "$hosts_file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Domain already exists in $(basename $hosts_file)${NC}"
        return 0
    fi
    
    echo "$domain_line" | sudo tee -a "$hosts_file" > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Added domain to $(basename $hosts_file)${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to add domain to $(basename $hosts_file)${NC}"
        return 1
    fi
}

# Main setup logic
echo -e "${BLUE}🔍 Detecting environment...${NC}"

if is_wsl; then
    echo -e "${YELLOW}🐧 WSL Environment Detected${NC}"
    echo -e "${BLUE}📝 Setting up for WSL development...${NC}"
    
    # Add to Linux hosts file (for curl/terminal access)
    echo -e "${BLUE}🔧 Setting up Linux hosts file...${NC}"
    add_to_hosts "/etc/hosts"
    
    # Add to Windows hosts file (for browser access)
    echo -e "${BLUE}🪟 Setting up Windows hosts file...${NC}"
    WINDOWS_HOSTS="/mnt/c/Windows/System32/drivers/etc/hosts"
    
    if [ -f "$WINDOWS_HOSTS" ]; then
        add_to_hosts "$WINDOWS_HOSTS"
        echo -e "${GREEN}✅ Windows hosts file updated${NC}"
        echo -e "${BLUE}💡 You can now access via:${NC}"
        echo -e "   • ${GREEN}https://localhost${NC} (recommended for WSL)"
        echo -e "   • ${GREEN}https://rmakoni.42.fr${NC} (works in Windows browser)"
    else
        echo -e "${YELLOW}⚠️  Windows hosts file not accessible${NC}"
        echo -e "${BLUE}💡 Use: ${GREEN}https://localhost${NC} for development"
    fi
    
else
    echo -e "${GREEN}🐧 Standard Linux Environment Detected${NC}"
    echo -e "${BLUE}📝 Setting up for Linux deployment...${NC}"
    
    # Add to hosts file
    add_to_hosts "/etc/hosts"
    
    echo -e "${GREEN}✅ Setup complete for Linux environment${NC}"
    echo -e "${BLUE}💡 You can access via:${NC}"
    echo -e "   • ${GREEN}https://rmakoni.42.fr${NC} (primary domain)"
    echo -e "   • ${GREEN}https://localhost${NC} (fallback)"
fi

echo ""
echo -e "${BLUE}🔧 Additional Setup Information:${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "📁 Project Structure:"
echo -e "   • ${YELLOW}Development${NC}: Use 'make' to start"
echo -e "   • ${YELLOW}Cleanup${NC}: Use 'make clean' to stop"
echo -e "   • ${YELLOW}Logs${NC}: Use 'make logs' to debug"
echo ""
echo -e "🌐 Network Configuration:"
echo -e "   • ${YELLOW}HTTP${NC}: Automatically redirects to HTTPS"
echo -e "   • ${YELLOW}HTTPS${NC}: SSL certificate supports both domains"
echo -e "   • ${YELLOW}Ports${NC}: 80 (HTTP) and 443 (HTTPS)"
echo ""
echo -e "${GREEN}🎯 Setup Complete! Run 'make' to start Inception${NC}"