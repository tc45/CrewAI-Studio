"""Pytest configuration file."""
import pytest
import os
import sys

# Add the app directory to the Python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

@pytest.fixture
def sample_agent_config():
    """Return a sample agent configuration for testing."""
    return {
        "name": "Test Agent",
        "role": "Test Role",
        "goal": "Test Goal",
        "backstory": "Test Backstory",
        "verbose": True,
        "allow_delegation": False,
        "llm": {
            "provider": "openai",
            "model": "gpt-3.5-turbo",
            "temperature": 0.7,
        }
    }

@pytest.fixture
def sample_task_config():
    """Return a sample task configuration for testing."""
    return {
        "description": "Test Task",
        "expected_output": "Test Output",
        "agent_id": 1,
        "async_execution": False,
        "context": "Test Context",
    }

@pytest.fixture
def sample_crew_config():
    """Return a sample crew configuration for testing."""
    return {
        "name": "Test Crew",
        "description": "Test Description",
        "tasks": [1, 2],
        "agents": [1, 2],
        "verbose": True,
        "memory": False,
        "process": "sequential",
    }
