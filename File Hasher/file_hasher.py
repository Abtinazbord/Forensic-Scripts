import os
import hashlib
import csv


def write_to_file(path, content=""):
    with open(path, "w") as f:
        f.write(content)


def get_path(prompt):
    dir_path = input(prompt)
    if os.path.exists(dir_path):
        if dir_path.endswith("\\"):
            return dir_path
        else:
            return dir_path + "\\"
    else:
        print(f'This path: {dir_path}, does not exist')
        exit(0)


def get_hash(hash_folder, dest_folder):
    csv_path = dest_folder + "SHA-256.csv"

    with open(csv_path, "w", newline="") as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(["File Name", "File Path", "SHA-256"])  # header row

        for root, dirs, files in os.walk(hash_folder):  # recursively walks all subdirectories
            for filename in files:
                full_path = os.path.join(root, filename)
                try:
                    with open(full_path, "rb") as f:
                        digest = hashlib.sha256(f.read()).hexdigest()
                    writer.writerow([filename, full_path, digest])
                    print(f"Hashed: {full_path}")
                except (PermissionError, OSError) as e:
                    print(f"Skipped: {full_path} — {e}")


def main():
    hash_folder_path = get_path("Enter a path to your folder: \n")
    hash_dest_path = get_path("Enter a path for hash file to be saved to: \n")
    get_hash(hash_folder_path, hash_dest_path)


if __name__ == "__main__":
    main()
