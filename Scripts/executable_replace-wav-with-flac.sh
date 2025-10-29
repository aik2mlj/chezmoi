#!/usr/bin/env bash

# Find and loop through all .wav files using fd
while IFS= read -r wavfile; do

    # Create output file name by replacing .wav/.WAV with .flac
    flacfile="${wavfile:0:-4}.flac"

    echo "Converting: $wavfile -> $flacfile"

    ffmpeg -i "$wavfile" -y "$flacfile" >/dev/null 2>&1
    # Convert the file to FLAC

    # If conversion is successful, delete the original WAV file
    if [ $? -eq 0 ]; then
        rm "$wavfile"
        echo "Deleted original file: $wavfile"
    else
        echo "Conversion failed for: $wavfile"
    fi

done < <(fd -e wav)
