@echo off
echo Checking if Poetry is installed...
where poetry >nul 2>&1
if %errorlevel% neq 0 (
    echo Poetry is not installed. Installing Poetry globally...
    powershell -Command "Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing | python -"
    if %errorlevel% neq 0 (
        echo Failed to install Poetry
        exit /b %errorlevel%
    )
    :: Add Poetry to PATH for the current session
    set PATH=%USERPROFILE%\AppData\Roaming\Python\Scripts;%PATH%
)

echo Checking if uv is installed...
where uv >nul 2>&1
if %errorlevel% neq 0 (
    echo uv is not installed. Installing uv globally...
    pip install --user uv
    if %errorlevel% neq 0 (
        echo Failed to install uv
        exit /b %errorlevel%
    )
    :: Add uv to PATH for the current session
    set PATH=%USERPROFILE%\AppData\Roaming\Python\Scripts;%PATH%
)

echo Configuring Poetry...
poetry --version

echo Installing dependencies using Poetry...
poetry install
if %errorlevel% neq 0 (
    echo Failed to install dependencies
    exit /b %errorlevel%
)

set /p install_agentops="Do you want to install agentops? (y/n): "
if /i "%install_agentops%"=="y" (
    echo Installing agentops...
    poetry add agentops
    if %errorlevel% neq 0 (
        echo Failed to install agentops
        exit /b %errorlevel%
    )
)
:: Check if .env file exists, if not copy .env_example to .env
if not exist "%SCRIPT_DIR%.env" (
    echo .env file does not exist. Copying .env_example to .env...
    copy "%SCRIPT_DIR%.env_example" "%SCRIPT_DIR%.env"
)


echo Installation completed successfully. Do not forget to update the .env file with your credentials. Then run run_venv.bat to start the app.

