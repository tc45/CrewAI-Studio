#!/bin/bash

# This script tests the dependency management setup

# Check if Poetry is installed
if ! command -v poetry &> /dev/null; then
    echo "Poetry is not installed. Installing Poetry globally..."
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="$HOME/.local/bin:$PATH"
fi

# Check Poetry version
echo "Poetry version:"
poetry --version

# Check if pyproject.toml exists
if [ ! -f "pyproject.toml" ]; then
    echo "pyproject.toml not found. Make sure you're in the correct directory."
    exit 1
fi

# List dependencies in pyproject.toml
echo "Dependencies in pyproject.toml:"
grep -A 20 "\[tool.poetry.dependencies\]" pyproject.toml

# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "requirements.txt exists. Contents:"
    cat requirements.txt
    
    # Compare dependencies
    echo "Checking if all dependencies from requirements.txt are in pyproject.toml..."
    missing=0
    while read -r dep; do
        if [ -z "$dep" ]; then
            continue
        fi
        # Extract package name (remove version specifiers)
        pkg=$(echo "$dep" | cut -d'=' -f1 | cut -d'>' -f1 | cut -d'<' -f1 | cut -d'~' -f1 | tr -d ' ')
        if ! grep -q "$pkg" pyproject.toml; then
            echo "Missing dependency in pyproject.toml: $pkg"
            missing=1
        fi
    done < requirements.txt
    
    if [ $missing -eq 0 ]; then
        echo "All dependencies from requirements.txt are in pyproject.toml."
    fi
else
    echo "requirements.txt not found. This is fine if migration is complete."
fi

# Check Docker configuration
if [ -f "Dockerfile" ]; then
    echo "Dockerfile exists. Checking for Poetry configuration..."
    if grep -q "poetry" Dockerfile; then
        echo "Dockerfile is using Poetry."
    else
        echo "Dockerfile is not using Poetry."
    fi
else
    echo "Dockerfile not found."
fi

# Check installation scripts
if [ -f "install_venv.sh" ]; then
    echo "install_venv.sh exists. Checking for Poetry configuration..."
    if grep -q "poetry" install_venv.sh; then
        echo "install_venv.sh is using Poetry."
    else
        echo "install_venv.sh is not using Poetry."
    fi
else
    echo "install_venv.sh not found."
fi

if [ -f "install_venv.bat" ]; then
    echo "install_venv.bat exists. Checking for Poetry configuration..."
    if grep -q "poetry" install_venv.bat; then
        echo "install_venv.bat is using Poetry."
    else
        echo "install_venv.bat is not using Poetry."
    fi
else
    echo "install_venv.bat not found."
fi

# Check run scripts
if [ -f "run_venv.sh" ]; then
    echo "run_venv.sh exists. Checking for Poetry configuration..."
    if grep -q "poetry" run_venv.sh; then
        echo "run_venv.sh is using Poetry."
    else
        echo "run_venv.sh is not using Poetry."
    fi
else
    echo "run_venv.sh not found."
fi

if [ -f "run_venv.bat" ]; then
    echo "run_venv.bat exists. Checking for Poetry configuration..."
    if grep -q "poetry" run_venv.bat; then
        echo "run_venv.bat is using Poetry."
    else
        echo "run_venv.bat is not using Poetry."
    fi
else
    echo "run_venv.bat not found."
fi

echo "Dependency management test completed."
