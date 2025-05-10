"""Unit tests for the utils module."""
import pytest
from app.utils import sanitize_filename


def test_sanitize_filename():
    """Test the sanitize_filename function."""
    # Test with a valid filename
    assert sanitize_filename("valid_filename") == "valid_filename"
    
    # Test with spaces
    assert sanitize_filename("file name with spaces") == "file_name_with_spaces"
    
    # Test with special characters
    assert sanitize_filename("file@#$%^&*()name") == "filename"
    
    # Test with leading/trailing spaces
    assert sanitize_filename(" filename ") == "filename"
    
    # Test with empty string
    assert sanitize_filename("") == ""
