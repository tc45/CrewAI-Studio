# Contributing to CrewAI Studio

Thank you for your interest in contributing to CrewAI Studio! This document outlines our development workflow, branching strategy, commit message conventions, and other guidelines to ensure a smooth collaboration process.

## Development Workflow

We follow an iterative development approach with these key steps:

1. **Create a feature branch**
   - Branch from `main` for new features or bug fixes
   - Use the naming convention: `feature/[feature-name]` or `bugfix/[bug-name]`

2. **Implement small, testable changes**
   - Focus on small, incremental changes
   - Maintain backward compatibility
   - Add feature flags for new capabilities when appropriate

3. **Write/update tests**
   - Write tests before or alongside code changes (TDD approach)
   - Ensure all new code has appropriate test coverage
   - Update existing tests as needed

4. **Run tests locally**
   - Run the test suite locally before committing
   - Fix any failing tests or linting issues

5. **Commit when tests pass**
   - Follow the commit message conventions (see below)
   - Keep commits focused and atomic

6. **Create PR and request review**
   - Create a pull request to merge your changes into `main`
   - Fill out the PR template with all required information
   - Request review from at least one team member

7. **Merge after approval and CI checks pass**
   - Address any feedback from reviewers
   - Ensure all CI checks pass
   - Merge using the "Squash and merge" option

## Branching Strategy

We follow the GitHub Flow branching strategy:

- **main**: The main branch contains production-ready code
- **feature/[feature-name]**: Feature branches for new features or enhancements
- **bugfix/[bug-name]**: Bug fix branches for resolving issues
- **hotfix/[hotfix-name]**: Hotfix branches for critical production fixes

## Commit Message Conventions

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types:
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Changes that do not affect the meaning of the code (formatting, etc.)
- **refactor**: Code changes that neither fix a bug nor add a feature
- **perf**: Code changes that improve performance
- **test**: Adding or correcting tests
- **chore**: Changes to the build process or auxiliary tools

### Examples:
```
feat(agent): add support for custom agent parameters
fix(ui): resolve task display issue in sidebar
docs: update installation instructions
test(crew): add unit tests for crew execution
```

## Pull Request Process

1. Update the README.md or documentation with details of changes if appropriate
2. Update the tests to reflect your changes
3. The PR may be merged once you have the sign-off of at least one reviewer and all CI checks pass
4. Use "Squash and merge" when merging to keep the commit history clean

## Code Style Guidelines

- Follow PEP 8 style guide for Python code
- Use meaningful variable and function names
- Write docstrings for all functions, classes, and modules
- Keep functions small and focused on a single responsibility
- Use type hints where appropriate

## Testing Guidelines

- Write unit tests for all new functionality
- Aim for high test coverage (at least 80%)
- Include integration tests for complex features
- Mock external dependencies in unit tests
- Run tests automatically at the end of each implementation section
- Validate that all tests pass before proceeding to the next section
- Fix any failing tests before considering a section complete

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/CrewAI-Studio.git`
3. Set up the development environment:
   - Install Poetry: `pip install poetry`
   - Install uv: `pip install uv`
   - Install dependencies: `poetry install`
4. Create a new branch: `git checkout -b feature/your-feature-name`
5. Make your changes
6. Run tests: `poetry run pytest` (always use `poetry run` for commands in the virtual environment)
7. Commit your changes following the commit message conventions
8. Push to your fork: `git push origin feature/your-feature-name`
9. Create a Pull Request

## Questions?

If you have any questions or need help, please open an issue or reach out to the maintainers.

Thank you for contributing to CrewAI Studio!
