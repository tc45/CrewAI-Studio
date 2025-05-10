# Dependency Management in CrewAI Studio

CrewAI Studio uses Poetry for dependency management and uv for faster installations. This document explains how to use these tools for managing dependencies in the project.

## Prerequisites

- Python 3.10 or higher (but less than 3.13 due to dependency constraints)
- Poetry (installation instructions below)
- uv (installation instructions below)

## Installing Poetry (Globally)

Poetry should be installed globally as it's used to create and manage virtual environments.

### On macOS/Linux:

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

After installation, add Poetry to your PATH:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

You may want to add this line to your shell profile (~/.bashrc, ~/.zshrc, etc.) to make it permanent.

### On Windows:

```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
```

After installation, Poetry should be available in your PATH. If not, you may need to add the following to your PATH:
```
%USERPROFILE%\AppData\Roaming\Python\Scripts
```

## Installing uv (Globally)

uv should also be installed globally:

```bash
# On macOS/Linux
pip install --user uv

# On Windows
pip install --user uv
```

## Setting Up the Development Environment

1. Clone the repository:

```bash
git clone https://github.com/your-username/CrewAI-Studio.git
cd CrewAI-Studio
```

2. Install dependencies using Poetry and uv:

```bash
# On Linux/macOS
./install_venv.sh

# On Windows
install_venv.bat
```

This script will:
- Check if Poetry and uv are installed
- Install them if they're not
- Configure Poetry to use uv as the installer
- Install all project dependencies

## Running the Application

After installing dependencies, you can run the application using:

```bash
# On Linux/macOS
./run_venv.sh

# On Windows
run_venv.bat
```

## Using Poetry for Commands

Always use Poetry to run commands in the virtual environment instead of activating the virtual environment directly. This ensures that the correct dependencies are used.

```bash
# Run a Python script
poetry run python script.py

# Run tests
poetry run pytest

# Run a specific command
poetry run streamlit run app/app.py
```

## Managing Dependencies

### Adding a New Dependency

To add a new dependency to the project:

```bash
poetry add package-name
```

For development dependencies:

```bash
poetry add --group dev package-name
```

### Removing a Dependency

To remove a dependency:

```bash
poetry remove package-name
```

### Updating Dependencies

To update all dependencies to their latest versions:

```bash
poetry update
```

To update a specific dependency:

```bash
poetry update package-name
```

### Viewing the Dependency Tree

To view the dependency tree:

```bash
poetry show --tree
```

## Docker Support

The project includes a Dockerfile and docker-compose.yaml that are configured to use Poetry and uv. To build and run the application using Docker:

```bash
docker-compose up --build
```

## Troubleshooting

### Poetry Installation Issues

If you encounter issues with Poetry installation, refer to the [official documentation](https://python-poetry.org/docs/#installation).

### uv Installation Issues

If you encounter issues with uv installation, try installing it with pip:

```bash
pip install uv
```

### Dependency Resolution Issues

If Poetry has trouble resolving dependencies, try:

```bash
poetry update --lock
```

Or for a clean slate:

```bash
rm poetry.lock
poetry install
```

## Additional Resources

- [Poetry Documentation](https://python-poetry.org/docs/)
- [uv Documentation](https://github.com/astral-sh/uv)
- [Python Packaging User Guide](https://packaging.python.org/)
