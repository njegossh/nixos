#!/usr/bin/env bash

# Strip trailing slashes
DIR1="${1%/}"
DIR2="${2%/}"

if [[ -z "$DIR1" || -z "$DIR2" ]]; then
    echo "Usage: $0 <directory1> <directory2>"
    exit 1
fi

if [[ ! -d "$DIR1" ]]; then echo "Error: $DIR1 is not a directory"; exit 1; fi
if [[ ! -d "$DIR2" ]]; then echo "Error: $DIR2 is not a directory"; exit 1; fi

PLAIN_EXT_REGEX='\.(txt|md|json|sh|xml|html|cfg)$'

declare -A skipped_dirs

# We use < <(...) to stream the list. This avoids the "ignored null byte" error.
while IFS= read -r -d '' path; do
    [ -z "$path" ] && continue

    # Check if this file is inside a directory we already flagged as missing
    for skip in "${!skipped_dirs[@]}"; do
        if [[ "$path" == "$skip/"* ]]; then
            continue 2
        fi
    done

    file1="$DIR1/$path"
    file2="$DIR2/$path"

    # Case 1: Path missing in B
    if [ ! -e "$file2" ]; then
        if [ -d "$file1" ]; then
            echo "-> No directory : $path/"
            skipped_dirs["$path"]=1
        else
            echo "-> No file      : $path"
        fi
    # Case 2: Path missing in A
    elif [ ! -e "$file1" ]; then
        if [ -d "$file2" ]; then
            echo "<- No directory : $path/"
            skipped_dirs["$path"]=1
        else
            echo "<- No file      : $path"
        fi
    # Case 3: Both exist
    else
        [ -d "$file1" ] && [ -d "$file2" ] && continue

        # Note: Some MTP mounts (phones) don't provide accurate 'stat' times.
        # We use || echo "N/A" to prevent script crashes if stat fails.
        time1=$(stat -c %y "$file1" 2>/dev/null | cut -d. -f1 || echo "N/A")
        time2=$(stat -c %y "$file2" 2>/dev/null | cut -d. -f1 || echo "N/A")

        if [[ "$path" =~ $PLAIN_EXT_REGEX ]]; then
            if ! diff -q "$file1" "$file2" > /dev/null 2>&1; then
                echo "-- Content diff : $path: $time1 <--> $time2"
            fi
        else
            size1=$(stat -c %s "$file1" 2>/dev/null || echo "0")
            size2=$(stat -c %s "$file2" 2>/dev/null || echo "0")
            if [ "$size1" != "$size2" ]; then
                echo "-- Size diff    : $path: $time1 (${size1}b) -- $time2 (${size2}b)"
            fi
        fi
    fi

# This logic generates the unique list of paths using null separators (\0)
done < <(
    { 
        (cd "$DIR1" && find . -not -path '.' -print0)
        (cd "$DIR2" && find . -not -path '.' -print0)
    } | sort -uz | sed -z 's|^\./||'
)
