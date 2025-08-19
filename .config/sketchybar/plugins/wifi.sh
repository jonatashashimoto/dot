#!/usr/bin/env sh

LABEL="$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2 p' | tr -d '\t')"

if [[ "$LABEL" == *"You are not associated with an AirPort network."* ]]; then
   sketchybar --set wifi label="Disconnected"
else   LABEL=$(echo "$LABEL" | sed "s/Current Wi-Fi Network: //")
   sketchybar --set wifi label="$LABEL"
fi