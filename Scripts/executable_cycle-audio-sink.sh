#!/bin/bash

# Script to cycle through PipeWire audio sinks
# Each run switches to the next available audio output device

# Get all available sink names
mapfile -t sinks < <(pactl list sinks short | awk '{print $2}')

# Check if we have any sinks
if [ ${#sinks[@]} -eq 0 ]; then
    echo "Error: No audio sinks found"
    exit 1
fi

# Get current default sink
current_default=$(pactl get-default-sink)

# Find the index of the current default
current_index=-1
for i in "${!sinks[@]}"; do
    if [ "${sinks[$i]}" = "$current_default" ]; then
        current_index=$i
        break
    fi
done

# Calculate next index (cycle back to 0 if at the end)
if [ $current_index -eq -1 ]; then
    # Current default not found in list, start with first sink
    next_index=0
else
    next_index=$(((current_index + 1) % ${#sinks[@]}))
fi

# Get the next sink name
next_sink="${sinks[$next_index]}"

# Set the new default
pactl set-default-sink "$next_sink"

# Get a human-readable description for the sink
sink_description=$(pactl list sinks | awk -v sink="$next_sink" '
    /^Sink #/ { current_sink = "" }
    /Name:/ { if ($2 == sink) current_sink = sink }
    /Description:/ { if (current_sink) { sub(/^[[:space:]]*Description: /, ""); print; exit } }
')

# Fallback to sink name if description not found
if [ -z "$sink_description" ]; then
    sink_description="$next_sink"
fi

# Print confirmation
echo "Switched to: $sink_description"

# Optional: Show desktop notification (requires notify-send)
if command -v notify-send &>/dev/null; then
    notify-send "Audio Output" "Switched to: $sink_description" -t 2000
fi
