# Changelog

All notable changes to the CrewAI Studio project will be documented in this file.

## [Unreleased]

### 2023-10-30 - Dependency Management Modernization (Updated)

#### Added
- Created `docs/DEPENDENCY_MANAGEMENT.md` with comprehensive documentation on using Poetry and uv
- Added a section in `docs/GUIDELINES.md` about using Poetry for all commands
- Added Python version constraints in pyproject.toml to resolve dependency conflicts

#### Changed
- Updated pyproject.toml with specific version constraints:
  - Set Python version to ">=3.10,<3.13" to address compatibility issues
  - Set crewai version to ">=0.119.0"
  - Added Python version constraint for langchain-ollama
- Updated Dockerfile to use Python 3.10 instead of 3.12.10
- Modified Poetry configuration in Dockerfile and installation scripts
- Updated CI/CD workflow in .github/workflows/ci.yml to use correct Poetry configuration
- Enhanced documentation in CONTRIBUTING.md to emphasize using Poetry for commands

#### Fixed
- Addressed dependency conflicts between crewai, langchain-community, and langchain-ollama
- Removed outdated Poetry configuration option `installer.modern-installation`

#### Issues Encountered
- Dependency conflicts between langchain-community and langchain-ollama
- Poetry configuration option `installer.modern-installation` no longer exists in newer Poetry versions
- Python 3.12+ compatibility issues with some dependencies

### 2023-10-30 - Documentation and Logging Improvements

#### Added
- Created logs directory for storing logs and changelog
- Created initial CHANGELOG.md to track all changes
- Added detailed guidelines for changelog management in AUGMENT_GUIDELINES.md
- Added terminal output logging guidelines in AUGMENT_GUIDELINES.md

#### Changed
- Updated AUGMENT_GUIDELINES.md with more comprehensive documentation requirements
- Enhanced logging practices to ensure all terminal output is captured

### 2023-10-30 - Dependency Management Fixes

#### Added
- Added specific version constraints for langchain and langchain-core in pyproject.toml
- Added Python version markers to crewai and crewai-tools dependencies

#### Changed
- Updated pyproject.toml with more precise dependency specifications:
  - Added langchain-core as an explicit dependency with version ">=0.1.9"
  - Set langchain version to ">=0.0.267"
  - Set langchain-community version to ">=0.0.14"
- Removed problematic Poetry configuration options from all scripts:
  - Replaced `poetry config installer.modern-installation false` with `poetry --version`
  - Updated Dockerfile, install_venv.sh, install_venv.bat, and CI/CD workflow

#### Fixed
- Addressed circular dependency issues between langchain-community, langchain-core, and langchain-ollama
- Fixed Python version constraints to ensure compatibility across all dependencies

#### Progress
- Dependency resolution was successful with the updated configurations
- Installation process started but was terminated due to memory constraints
- The changes to pyproject.toml have resolved the circular dependency issues

### 2023-10-30 - Dependency Version Alignment

#### Changed
- Updated pyproject.toml with exact versions from a working installation:
  - crewai = "0.119.0"
  - crewai-tools = "0.44.0"
  - langchain = "0.3.25"
  - langchain-community = "0.3.23"
  - langchain-core = "0.3.59"
  - langchain-openai = "0.2.14"
  - langchain-groq = "0.3.2"
  - langchain-anthropic = "0.3.13"
  - langchain-ollama = "0.3.2"
  - streamlit = "1.45.0"
  - python-dotenv = "1.1.0"
  - pdfminer-six = "20250327"
  - sqlalchemy = "2.0.40"
  - psycopg2-binary = "2.9.10"
  - snowflake-connector-python = "3.15.0"
  - markdown = "3.8"
  - docling = "2.31.0"

#### Next Steps
- Test installation with the exact versions from a working installation
- Verify Docker builds successfully with the new configuration
- Run the application to ensure all components work correctly
