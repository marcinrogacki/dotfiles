#!/bin/bash

# Name of the application to check
app_name="Path Of Exile"

# Get the ID of the focused window
focused_window_id=$(xdotool getwindowfocus)
# Get the ID of the application's window
app_window_id=$(xdotool search --name "$app_name" | head -1)

if [ "$focused_window_id" != "$app_window_id" ]; then
    echo 'Not focused' $app_name
    exit
fi

mouse_location=$(xdotool getmouselocation --shell)
eval $mouse_location

# Steps for clicking
step=50

if [ $1 == 2 ]; then
    width=$((step*6))
    height=$((step*6))
else
    width=$((step*12))
    height=$((step*6))
fi

# Calculate the number of steps in both x and y directions
steps_x=$((width / step))
steps_y=$((height / step))

start_X=$X
start_Y=$Y

# Move the mouse to the starting position
xdotool mousemove $start_X $start_Y

# Loop through each column
for ((j = 0; j < steps_x; j++)); do
    # Loop through each row
    for ((i = 0; i < steps_y; i++)); do
        # Calculate current position
        current_x=$((start_X + j * step))
        current_y=$((start_Y + i * step))

        # Move to the current position
        xdotool mousemove $current_x $current_y

        sleep 0.01
        mouse_location=$(xdotool getmouselocation --shell)
        eval $mouse_location
        if [[ $current_x != $X || $current_y != $Y ]]; then
            exit
        fi

        # Simulate Ctrl+Click by pressing Ctrl key, clicking, and releasing Ctrl key
        xdotool keydown Control
        xdotool click 1
        xdotool keyup Control
    done
done

