# dotbackup - A Fish Shell Backup Utility for Dotfiles'

## Overview

`dotbackup` is a fish shell function designed to help you manage backups of your dotfiles. It allows you to:

- **Backup** dotfiles with timestamped filenames.
- **Push** backups to a remote Git repository (e.g., GitHub).
- **Pull** backups from the remote Git repository.
- **List** available backups.
- **Restore** backups based on a stored CSV file of backup paths.
- **Clean** up old backups.

## Requirements

- Fish shell (of course!).
- Git (for push/pull operations).
- A GitHub repository for storing backups.

## Installation

### One Line Script Runner

```fish
curl -L https://raw.githubusercontent.com/linhtutkyawdev/.dotbackup/refs/heads/master/install.fish | fish
```

2. For push and pull functionalities, ensure that git is installed on your system, and don't forget to edit gitlab repo link in the script with your own one.

## Functionality

### 1. Backup (`dotbackup`)

This is the default behavior. When you run `dotbackup` without any flags, it will:

- Create a backup of the specified file.
- If the backup directory or CSV file doesn't exist, it will create them.
- Store a record of the backup in a CSV file for reference.

#### Example Usage:
```fish
dotbackup ~/.config/fish/config.fish
```

### 2. Push (`dotbackup push`)

This option pushes your backups to a remote Git repository, such as GitHub. You must configure the repository beforehand.

#### Example Usage:
```fish
dotbackup push
```

If the Git repository does not exist, it will be initialized and the backup pushed to the `master` branch.

### 3. Pull (`dotbackup pull`)

This option pulls the latest backups from the remote Git repository.

#### Example Usage:
```fish
dotbackup pull
```

### 4. List (`dotbackup list`)

This will list all available backups stored in the `og_comma_bak.csv` file. If no backups are found, it will notify the user.

#### Example Usage:
```fish
dotbackup list
```

### 5. Clean (`dotbackup clean`)

This option allows you to delete specific or all backups.

#### Example Usage:
- To delete a specific backup:
```fish
dotbackup clean config.fish
```

- To delete **all backups**:
```fish
dotbackup clean all
```

### 6. Restore (`dotbackup restore`)

This option restores a backup from the `og_comma_bak.csv` file. You can restore a specific line from the CSV by providing the line number or use `all` to restore all backups.

#### Example Usage:
- To restore a single backup:
```fish
dotbackup restore 3
```

- To restore all backups:
```fish
dotbackup restore all
```

## How It Works

- **Backup**: The function checks if the `.dotbackup` directory and the `og_comma_bak.csv` file exist. If they do not exist, they are created. A backup of the specified file is then copied with a timestamped name, and its original and backup paths are logged in the CSV file.
  
- **Push**: This initializes a Git repository in the `.dotbackup` folder (if not already initialized), commits all changes, and pushes to the remote repository.
  
- **Pull**: This pulls the latest changes from the remote Git repository into the `.dotbackup` folder.
  
- **Clean**: This removes either specific backups (by name) or all backups stored in the `.dotbackup` directory, updating the CSV file accordingly.
  
- **Restore**: This restores a backup by copying the file back to its original location based on the data in the CSV file.

## Notes

- The backup files are stored in the `.dotbackup` directory inside your home directory (`~/.dotbackup`).
- Backups are stored with a `.bak` extension and a timestamp in the filename to avoid overwriting.
- The `og_comma_bak.csv` file keeps track of all backups, with each line containing the original file path and the backup file path, separated by a comma.

## Customization

- You can change the GitHub repository URL in the `push` and `pull` sections to match your repository.
- You can modify the `og_comma_bak.csv` file or create your own file format if you prefer, but ensure the structure remains compatible with the function.

## Contributing

Feel free to fork this repository, make modifications, and submit pull requests. If you find any bugs or have feature suggestions, please open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

