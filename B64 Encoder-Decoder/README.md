# Base64 Encoder/Decoder

A command-line tool that encodes and decodes files using Base64. It reads from an input file, displays the result in the terminal, and optionally saves the output to a new file.

## Requirements

- Python 3.x

**Options:**
1. **Encode** — reads a plain text file and outputs its Base64-encoded content
2. **Decode** — reads a Base64-encoded file and outputs the decoded plain text
3. **Exit** — quits the program

When prompted, enter the full file path including the extension (e.g. `message.txt`). After each operation, you will be asked if you want to save the result to a file.

## Error Handling
- Invalid or missing file paths are caught and reported
- Invalid Base64 content is caught and reported
