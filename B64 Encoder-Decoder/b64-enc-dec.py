import base64
import os


def write_to_file(path, content):
    with open(path, "w") as f:
        f.write(content)


def reading_from_file(path):
    with open(path, "r") as f:
        return f.read()


def get_path(prompt):
    file_path = input(prompt)
    if os.path.exists(file_path):
        return file_path
    else:
        print(f"This path: {file_path}, does not exist")
        exit(0)


def decode_base64(file_path):
    file = reading_from_file(file_path)
    print(f"\nB64 Encoded:\n {file}\n")
    decoded = base64.b64decode(file.encode()).decode()
    return decoded


def encode_base64(file_path):
    file = reading_from_file(file_path)
    print(f"\nPlain text:\n {file}\n")
    encoded = base64.b64encode(file.encode()).decode()
    return encoded


def save_prompt(result):
    save = input("Would you like to save the result to a file? (y/n): ")
    if save.lower() == "y":
        output_path = input("Enter the output file name with extension: ")
        write_to_file(output_path, result)
        print(f"Saved to {output_path}\n")


def main():
    while True:
        user_input = input("Please choose an option:\n 1. Encode to base64\n 2. Decode from base64\n 3. Exit\n")

        if user_input == "1":
            file_path = get_path("Please enter the file path with extension:\n ")
            try:
                result = encode_base64(file_path)
                print(f"Encoded:\n {result}\n")
                save_prompt(result)
            except (FileNotFoundError, ValueError):
                print("File not found or invalid content. Try again.\n")

        elif user_input == "2":
            file_path = get_path("Please enter the file path with extension:\n ")
            try:
                result = decode_base64(file_path)
                print(f"Decoded:\n {result}\n")
                save_prompt(result)
            except (FileNotFoundError, ValueError):
                print("File not found or invalid base64 content. Try again.\n")

        elif user_input == "3":
            return

        else:
            print("Invalid input! Try again.\n")


if __name__ == '__main__':
    main()
