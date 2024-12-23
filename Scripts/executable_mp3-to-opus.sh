#!/usr/bin/env bash

# Exit immediately on error
set -e

########################################
# Default values for min-depth and max-depth
########################################
min_depth_val=""
max_depth_val=""
overwrite=0

########################################
# Parse command-line arguments
########################################
while [ "$#" -gt 0 ]; do
    case "$1" in
    --min-depth)
        shift
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            min_depth_val="$1"
        else
            echo "Error: --min-depth expects a numeric value."
            exit 1
        fi
        ;;
    --max-depth)
        shift
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            max_depth_val="$1"
        else
            echo "Error: --max-depth expects a numeric value."
            exit 1
        fi
        ;;
    --overwrite)
        overwrite=1
        ;;

    *)
        echo "Unknown parameter: $1"
        echo "Usage: $0 [--min-depth N] [--max-depth N] [--overwrite]"
        exit 1
        ;;
    esac
    shift
done

fd_cmd=(fd -t f -g '*.mp3')

if [ -n "$min_depth_val" ]; then
    fd_cmd+=("--min-depth" "$min_depth_val")
fi
if [ -n "$max_depth_val" ]; then
    fd_cmd+=("--max-depth" "$max_depth_val")
fi

# Always search from the current directory (.)
fd_cmd+=('.')
echo "${fd_cmd[@]}"

########################################
# Collect all .mp3 files
########################################
mapfile -t mp3_files < <("${fd_cmd[@]}")

############################################
# NEW: Print total files, first, and last
############################################
echo "Found ${#mp3_files[@]} .mp3 file(s) to process."
if [ ${#mp3_files[@]} -gt 0 ]; then
    echo "First file: ${mp3_files[0]}"
    # For the last element, use index = length - 1
    echo "Last file:  ${mp3_files[${#mp3_files[@]} - 1]}"
else
    exit 1
fi
echo "----------------------------------------"

########################################
# Determine ffmpeg overwrite flag
########################################
if [ "$overwrite" -eq 1 ]; then
    ffmpeg_overwrite_flag="-y"
    echo "Will overwrite target file if exists."
else
    ffmpeg_overwrite_flag="-n"
fi
echo

# Create the "converted" directory if it doesn't exist
mkdir -p converted

# Initialize variables for total input size and total output size (in bytes)
total_input_size=0
total_output_size=0

for file in "${mp3_files[@]}"; do

    # Remove leading "./" if present
    relative_path="${file#./}"

    # Construct the target directory path under "converted/"
    target_dir="converted/$(dirname "$relative_path")"

    # Make sure the target directory hierarchy exists
    mkdir -p "$target_dir"

    # Construct the output filename with .opus extension
    target_file="$target_dir/$(basename "$relative_path" .mp3).opus"

    # Get the input file size (in bytes) before conversion
    input_size=$(stat -c%s "$file")

    # --- Determine original MP3 bitrate ---
    # ffprobe outputs bitrate in bits/s, so we convert to kbps
    bitrate_bps=$(ffprobe -v quiet -select_streams a:0 -show_entries stream=bit_rate \
        -of default=noprint_wrappers=1:nokey=1 "$file" || echo 0)
    bitrate_kbps=$((bitrate_bps / 1000))

    # If for some reason ffprobe fails or returns 0, fallback to 256
    if [ "$bitrate_kbps" -le 0 ]; then
        bitrate_kbps=256
    fi

    # Decide on output bitrate
    if [ "$bitrate_kbps" -le 192 ]; then
        opus_bitrate="96k"
    else
        opus_bitrate="128k"
    fi

    # Convert the file to Opus (128kbps)

    ffmpeg "$ffmpeg_overwrite_flag" -i "$file" -c:a libopus -b:a "$opus_bitrate" -vbr on "$target_file" >/dev/null 2>&1

    # Get the output file size (in bytes) after conversion
    output_size=$(stat -c%s "$target_file")

    # Update totals
    total_input_size=$((total_input_size + input_size))
    total_output_size=$((total_output_size + output_size))

    ratio=$(awk -v a="$input_size" -v b="$output_size" 'BEGIN { printf "%.2f", a/b }')
    echo "$relative_path (${bitrate_kbps}k) -> $target_file ($opus_bitrate) [ratio $ratio : 1]"
done

# We'll use awk, which is typically installed on most systems by default.
if [ "$total_output_size" -gt 0 ]; then
    avg_ratio=$(awk -v a="$total_input_size" -v b="$total_output_size" \
        'BEGIN { printf "%.2f", a/b }')
    echo "----------------------------------------"
    echo
    echo "Average compression ratio: ${avg_ratio} : 1"
else
    echo "No output files generated or total_output_size is zero."
fi
