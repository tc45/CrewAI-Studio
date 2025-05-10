# Augment Guidelines for CrewAI Studio

This document outlines the guidelines that Augment (Auggie) will follow when assisting with the CrewAI Studio project. These guidelines are adapted from the existing Cursor rules and enhanced for Augment's capabilities.

## Project Structure Guidelines

- Maintain the modular structure with clear separation of concerns
- Keep main application code in the `app` directory
- Store documentation in the `docs` directory
- Organize tests in the `tests` directory mirroring the app structure
- Respect the existing file organization patterns

## Dependency Management with Poetry

### Using Poetry for All Commands

Always use Poetry to run commands in the virtual environment instead of activating the virtual environment directly or using venv. This ensures that the correct dependencies are used and that the environment is consistent across all developers.

```bash
# CORRECT: Use Poetry to run commands
poetry run python script.py
poetry run pytest
poetry run streamlit run app/app.py

# INCORRECT: Don't use venv directly
source venv/bin/activate
python script.py  # Don't do this
```

### Adding Dependencies

When adding new dependencies, always use Poetry:

```bash
# Add a regular dependency
poetry add package-name

# Add a development dependency
poetry add --group dev package-name
```

### Python Version Constraints

Due to dependency constraints, CrewAI Studio requires Python 3.10 or higher, but less than 3.13. This is specified in the `pyproject.toml` file.

### Code Style and Formatting with Poetry

Run these tools using Poetry:

```bash
poetry run black app
poetry run isort app
poetry run flake8 app
poetry run mypy app
```

### Testing with Poetry

- Write tests for all new functionality
- Run tests using Poetry:

```bash
poetry run pytest
```

- For test coverage:

```bash
poetry run pytest --cov=app
```

## Code Style Guidelines

- Follow PEP 8 style guide for Python code
- Use type hints for all function parameters and return values
- Keep maximum line length to 100 characters
- Use descriptive variable and function names
- Document all public functions and classes with docstrings
- Maintain consistent indentation and formatting

## Code Change Policy

- **Preserve Existing Functionality**: Do not remove or replace existing code unless explicitly instructed
- **Additive Changes**: Add new features or logic in a way that preserves all working code
- **Iterative Development**: Make small, testable changes that can be verified before proceeding
- **Test-Driven Approach**: Write or update tests before or alongside code changes
- **Backward Compatibility**: Ensure changes don't break existing functionality

## Documentation Guidelines

- Update documentation with each code change
- Document all major features in `docs/`
- Include examples and use cases
- Keep README and other user-facing documentation up to date
- Document any configuration changes or new environment variables

## Testing Guidelines

- Write tests for all new functionality
- Update existing tests when modifying code
- Follow test file naming convention: `test_*.py`
- Organize tests to mirror the application structure
- Use pytest as the testing framework
- Aim for high test coverage, especially for critical components
- Tests should be automatically run and validated at the end of each implementation section

## Logging Guidelines

- Use Loguru for all logging
- Follow structured logging practices
- Use appropriate log levels:
  - TRACE: Very detailed debugging information
  - DEBUG: Debugging information
  - INFO: General operational events
  - SUCCESS: Successful operations
  - WARNING: Potential issues
  - ERROR: Error events
  - CRITICAL: System-critical issues
- Include relevant context in log messages
- Sanitize sensitive information in logs

## CrewAI-Specific Guidelines

- Maintain clear separation between crews, agents, tasks, and tools
- Follow established patterns for implementing new components
- Document crew purpose, agent roles, and task requirements
- Ensure proper error handling in tools and tasks
- Validate inputs and sanitize outputs

## Frontend (Streamlit) Guidelines

- Maintain consistent UI patterns
- Use appropriate Streamlit components
- Handle state management properly
- Implement proper error handling and user feedback
- Follow responsive design principles

## Workflow for Code Changes

1. **Understand Requirements**: Fully understand what needs to be changed before making modifications
2. **Plan Changes**: Create a detailed plan for implementation
3. **Write Tests**: Create or update tests for the new functionality
4. **Implement Changes**: Make small, incremental changes
5. **Test Changes**: Verify that tests pass and functionality works as expected
6. **Document Changes**: Update documentation to reflect changes
7. **Suggest Commit**: Provide a meaningful commit message following conventional commits format

## Communication Guidelines

- Provide clear explanations of proposed changes
- Ask for clarification when requirements are ambiguous
- Suggest alternatives when appropriate
- Highlight potential issues or concerns
- Provide context and reasoning for technical decisions

## Model Context Protocol Integration Guidelines

When implementing Model Context Protocol:

- Maintain compatibility with existing LLM providers
- Implement adapters for each supported provider
- Ensure proper context window management
- Document MCP-specific configuration options
- Provide clear examples of MCP usage

## Changelog Management

- For medium to significant changes, update to `logs/CHANGELOG.md`
- Include date/timestamp with each entry
- Briefly describe what was changed and why
- Categorize changes (feature, bugfix, enhancement, etc.)

## Docker and CI/CD

When using Docker, the Dockerfile is configured to use Poetry for dependency management. The Docker container uses Python 3.10 to ensure compatibility with all dependencies.

The CI/CD pipeline is configured to use Poetry for all commands. This ensures that the same environment is used in CI/CD as in local development.

By following these guidelines, Augment will help implement the enhancement plan while maintaining code quality and project stability.
