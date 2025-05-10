#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR" || exit

# Function to prompt the user for yes/no response
prompt_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
}

# Check if Poetry is installed (should be installed globally)
if ! command -v poetry &> /dev/null; then
    echo "Poetry is not installed. Installing Poetry globally..."
    curl -sSL https://install.python-poetry.org | python3 - || { echo "Failed to install Poetry"; exit 1; }
    # Add Poetry to PATH for the current session
    export PATH="$HOME/.local/bin:$PATH"
fi

# Check if uv is installed (should be installed globally)
if ! command -v uv &> /dev/null; then
    echo "uv is not installed. Installing uv globally..."
    pip install --user uv || { echo "Failed to install uv"; exit 1; }
    # Add uv to PATH for the current session
    export PATH="$HOME/.local/bin:$PATH"
fi

# Check if venv exists
if [ -d ".venv" ]; then
    if prompt_yes_no "The virtual environment '.venv' already exists. Do you want to reinstall it?"; then
        echo "Removing existing virtual environment..."
        rm -rf .venv || { echo "Failed to remove existing venv"; exit 1; }
    else
        echo "Installation canceled."
        exit 0
    fi
fi

# Configure Poetry to use uv as installer
poetry config installer.modern-installation false

# Install dependencies using Poetry
echo "Installing dependencies using Poetry and uv..."
poetry install || { echo "Failed to install dependencies"; exit 1; }

# Prompt for agentops installation
if prompt_yes_no "Do you want to install agentops?"; then
    echo "Installing agentops..."
    poetry add agentops || { echo "Failed to install agentops"; }
fi
# Check if .env file exists, if not copy .env_example to .env
if [ ! -f "$SCRIPT_DIR/.env" ]; then
    echo ".env file does not exist. Copying .env_example to .env..."
    cp "$SCRIPT_DIR/.env_example" "$SCRIPT_DIR/.env"
fi

echo "Installation completed successfully. Do not forget to update the .env file with your credentials. Then run run_venv.sh to start the app."
