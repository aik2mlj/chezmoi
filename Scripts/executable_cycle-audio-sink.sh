#!/bin/bash

# Script to cycle through PipeWire audio sinks
# Each run switches to the next available audio output device

# Get all available audio sink names (from both Sinks and Filters sections)
# This extracts lines that contain audio sink names
get_all_sinks() {
    wpctl status --name | awk '
        /Audio/,/^[[:space:]]*$/ {
            # Match lines in Sinks section (regular sinks)
            if (/^[[:space:]]*├─ Sinks:/) { in_sinks=1; next }
            # Match lines in Filters section (can also be audio sinks)
            if (/^[[:space:]]*├─ Filters:/) { in_filters=1; next }
            # Exit sections on next category
            if (/^[[:space:]]*├─ (Sources|Streams):/ || /^[[:space:]]*└─/) { in_sinks=0; in_filters=0 }

            # Extract sink names from Sinks section (matches lines with tree chars)
            if (in_sinks && /[0-9*]+\..*alsa_/) {
                match($0, /[0-9*]+\.[[:space:]]+([a-zA-Z0-9_.\-]+)/, arr)
                if (arr[1]) print arr[1]
            }

            # Extract sink names from Filters section (only Audio/Sink types)
            if (in_filters && /\[Audio\/Sink\]/) {
                match($0, /[[:space:]]*\*?[[:space:]]*[0-9]+\.[[:space:]]+([a-zA-Z0-9_.\-]+)/, arr)
                if (arr[1]) print arr[1]
            }
        }
    '
}

# Get the current default audio sink
get_current_default() {
    wpctl status --name | awk '/Default Configured Devices:/,/^[[:space:]]*$/ {
        if (/Audio\/Sink/) {
            print $3
        }
    }'
}

# Get all available sinks
mapfile -t sinks < <(get_all_sinks)

# Check if we have any sinks
if [ ${#sinks[@]} -eq 0 ]; then
    echo "Error: No audio sinks found"
    exit 1
fi

# Get current default
current_default=$(get_current_default)

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

# Get the sink ID for the next sink
next_sink_id=$(pw-cli info "$next_sink" 2>/dev/null | head -n 1 | awk '{print $2}')

if [ -z "$next_sink_id" ]; then
    echo "Error: Could not get ID for sink: $next_sink"
    exit 1
fi

# Set the new default
wpctl set-default "$next_sink_id"

# Get a human-readable name for the sink from pw-cli
sink_description=$(pw-cli info "$next_sink_id" | grep -E "node.description" | sed -E 's/.*node.description = "(.*)"/\1/')

# Fallback to sink name if description not found
if [ -z "$sink_description" ]; then
    sink_description="$next_sink"
fi

# Print confirmation
echo "Switched to: $sink_description"
echo "Sink name: $next_sink"
echo "Sink ID: $next_sink_id"

# Optional: Show desktop notification (requires notify-send)
if command -v notify-send &>/dev/null; then
    notify-send "Audio Output" "Switched to: $sink_description" -t 2000
fi
