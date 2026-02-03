#!/bin/bash

# Name of the application to check
app_name="Path Of Exile"

# Get the ID of the focused window
focused_window_id=$(xdotool getwindowfocus)
# Get the ID of the application's window
app_window_id=$(xdotool search --name "$app_name" | head -1)

# if [ "$focused_window_id" != "$app_window_id" ]; then
#     echo 'Not focused' $app_name
#     exit
# fi

mouse_location=$(xdotool getmouselocation --shell)
eval $mouse_location

# Steps for clicking
w_step=50
h_step=48

# if [ $1 == 2 ]; then
#    width=$((w_step*6))
#    height=$((h_step*6))
# else
    width=$((w_step*12))
    height=$((h_step*6))
# fi

# Calculate the number of steps in both x and y directions
steps_x=$((width / w_step))
steps_y=$((height / h_step))

start_X=$X
start_Y=$Y

# Move the mouse to the starting position
xdotool mousemove $start_X $start_Y

# Loop through each column
for ((j = 0; j < steps_x; j++)); do
    # Loop through each row
    for ((i = 0; i < steps_y; i++)); do
        # Calculate current position
        current_x=$((start_X + j * w_step))
        current_y=$((start_Y + i * h_step))

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
        sleep 0.1
        # Confir Enter to Faustus shop (F9)
        if [ $1 == 2 ]; then
            xdotool keydown Enter
            xdotool keyup Enter
        fi

    done
done

