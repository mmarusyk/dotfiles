#!/bin/bash

set -e

echo -e "\n${BLUE}Available install scripts:${NC}"
ls "$INSTALL_DIR"/install/*.sh | xargs -n 1 basename
