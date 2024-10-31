 #!/bin/bash

# Get the ID of the frontmost window
frontmost_window=$(yabai -m query --windows --window | jq -r '.pid')

# Get all windows in the current stack
stack_windows=$(yabai -m query --windows --space | jq -r '.[] | select(."stack-index" != null) | .pid')

# Debugging
# echo $frontmost_window
# echo $stack_windows


# Loop through each window and hide if it’s not the frontmost
for win in $stack_windows; do
    if [[ "$win" != "$frontmost_window" ]]; then
      osascript -e "tell application \"System Events\" to set visible of (application processes where unix id is $win) to false"
    else
      osascript -e "tell application \"System Events\" to set visible of (application processes where unix id is $win) to true"
    fi
done