#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

INSTALL_DIR=$(pwd)
APPIMAGE_URL="https://downloads.cursor.com/production/latest/linux/x64/Cursor-0.48.9-x86_64.AppImage"
APP_DIR="/opt/cursor"
APPIMAGE_FILE="$APP_DIR/cursor.AppImage"
ICON_SOURCE="$INSTALL_DIR/assets/images/cursor.png"
ICON_DEST="$APP_DIR/cursor.png"
DESKTOP_ENTRY="/usr/share/applications/cursor.desktop"
WRAPPER_SCRIPT="/usr/local/bin/cursor"

echo -e "${YELLOW}Installing Cursor...${RESET}"

# Create application directory
sudo mkdir -p "$APP_DIR"

# Download the AppImage
echo -e "${YELLOW}Downloading Cursor AppImage...${RESET}"
sudo wget -O "$APPIMAGE_FILE" "$APPIMAGE_URL"

# Make the AppImage executable
echo -e "${YELLOW}Making AppImage executable...${RESET}"
sudo chmod +x "$APPIMAGE_FILE"

# Copy the icon
echo -e "${YELLOW}Copying icon...${RESET}"
sudo cp "$ICON_SOURCE" "$ICON_DEST"

# Create desktop entry
echo -e "${YELLOW}Creating desktop entry...${RESET}"
sudo tee "$DESKTOP_ENTRY" > /dev/null <<EOF
[Desktop Entry]
Name=Cursor
Exec=$APPIMAGE_FILE --no-sandbox
Icon=$APP_DIR/cursor.png
Type=Application
Categories=Utility;
EOF

# Create a wrapper script for console access
echo -e "${YELLOW}Creating wrapper script for console access...${RESET}"
sudo tee "$WRAPPER_SCRIPT" > /dev/null <<EOF
#!/bin/bash
"$APPIMAGE_FILE" --no-sandbox "\$@"
EOF

# Make the wrapper script executable
sudo chmod +x "$WRAPPER_SCRIPT"

echo -e "${GREEN}Cursor installed successfully!${RESET}"