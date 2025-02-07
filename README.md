# My Dotfiles

This repository contains my personal dotfiles and configuration files, with a special Docker setup for testing configurations in an isolated environment.

## Project Structure

| Path                      | Description                                    |
| ------------------------- | ---------------------------------------------- |
| `.config/`                | Configuration files for various applications   |
| `.bashrc`                 | Bash shell configuration file                 |
| `.bash_aliases`           | Custom bash aliases and functions             |
| `install-requirements.sh` | Script to install necessary dependencies       |
| `create-symlinks.sh`      | Script to create symlinks and handle conflicts |
| `Dockerfile` and `docker-compose.yml` | Docker configuration for testing (found in the [`docker-testing`](https://github.com/SrFrancia/dotfiles/tree/docker-testing) branch) |

## Quick Start

**Important**: This repository must be cloned directly into your home directory for GNU Stow to work correctly. Stow will create symlinks from your home directory to the files in this repository.

1. Clone this repository into your home directory:
```bash
cd ~
git clone https://github.com/SrFrancia/dotfiles.git
cd dotfiles
```

2. Install requirements (requires root):
```bash
sudo ./install-requirements.sh
```

3. Create symlinks:
```bash
./create-symlinks.sh
```

The `create-symlinks.sh` script uses GNU Stow to create symbolic links from your home directory to the configuration files in this repository. This allows you to keep all your dotfiles organized in one directory while maintaining the correct file structure in your home directory.

## Docker Testing

The [`docker-testing`](https://github.com/SrFrancia/dotfiles/tree/docker-testing) branch includes a Docker setup for safely testing configurations:

1. Switch to the docker-testing branch:
```bash
git fetch origin docker-testing
git checkout docker-testing
```

2. Build and run the container:
```bash
docker compose up -d
```

3. Enter the container:
```bash
docker attach testing-neovim
```

3. Inside the container, you can:
   - Test Neovim configurations
   - Experiment with dotfiles
   - Try new settings without affecting your host system

The container includes:
- Latest Neovim from Debian experimental
- All necessary dependencies
- Volume mounts for real-time configuration testing

To exit the container, simply type `exit` or press Ctrl+D.
