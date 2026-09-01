#!/usr/bin/env bash

OUTPUT_FILE="combined.txt"

# Clear output file if it exists
> "$OUTPUT_FILE"

# Find all regular files and process them
find . -type f | sort | while read -r file; do
    # Skip the output file itself
    if [[ "$file" == "./$OUTPUT_FILE" ]]; then
        continue
    fi

    echo "========================================" >> "$OUTPUT_FILE"
    echo "FILE: ${file#./}" >> "$OUTPUT_FILE"
    echo "========================================" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"

    cat "$file" >> "$OUTPUT_FILE"

    echo -e "\n\n" >> "$OUTPUT_FILE"
done

echo "All files combined into $OUTPUT_FILE"
