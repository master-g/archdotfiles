#!/bin/bash

APPIMAGE_PATH=$(find /opt/Chatbox/ -maxdepth 1 -type f -executable -name "Chatbox-*.AppImage" | sort | tail -n 1)

if [ -z "$APPIMAGE_PATH" ]; then
  echo "Error: chatbox AppImage not found in /opt/Chatbox/"
  exit 1
fi

"$APPIMAGE_PATH" &

