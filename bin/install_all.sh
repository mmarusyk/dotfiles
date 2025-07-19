#!/bin/bash

set -e

echo -e "\n${BLUE}Installing all scripts...${NC}"
for script in "$INSTALL_DIR"/install/*.sh; do
if [ -f "$script" ]; then
    echo -e "${BLUE}\nInstalling ${script_name}...${NC}"
    source "$script"
    echo -e "${GREEN}\nInstalling completed.${NC}"
fi
done
echo -e "\n${GREEN}All scripts installed.${NC}"
