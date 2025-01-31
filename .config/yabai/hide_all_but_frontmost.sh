 #!/bin/bash

# Get the ID of the frontmost window
frontmost_window=$(yabai -m query --windows --window | jq -r '.pid')

# Get all windows in the current stack
stack_windows=$(yabai -m query --windows --space | jq -r '.[] | select(."stack-index" != null) | .pid')

frontmost_window_app=$(yabai -m query --windows --window | jq -r '.app')

is_stacked=$(yabai -m query --spaces --space | jq -r '.type')

# Debugging
# echo $frontmost_window
 echo $is_stacked


# Loop through each window and hide if it’s not the frontmost
# if [[ "$frontmost_window_app" == "kitty" && "$is_stacked" == "stack" ]]; then
#   echo "entrou"
#   for win in $stack_windows; do
#       if [[ "$win" != "$frontmost_window" ]]; then
#           osascript -e "tell application \"System Events\" to set visible of (application processes where unix id is $win) to false"
#       else
#         osascript -e "tell application \"System Events\" to set visible of (application processes where unix id is $win) to true"
#       fi
#   done
# fi