#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
#


ORANGE="0x60ff4f00"
TRANS="0x00000000"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color="$ORANGE"
else
    sketchybar --set $NAME background.color=0x00000000
fi
