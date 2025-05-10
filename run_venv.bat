@echo off
REM Get the directory where the script is located
SET SCRIPT_DIR=%~dp0

echo Running Streamlit app...
cd %SCRIPT_DIR%

REM Optionally remove existing 'db' directory
IF EXIST "%SCRIPT_DIR%db" (
    rmdir /s /q "%SCRIPT_DIR%db"
)

REM Run the application using Poetry
poetry run streamlit run app/app.py --server.headless True
