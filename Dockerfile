# Baseimage
FROM python:3.12.10-slim-bookworm

# Update Packages
RUN apt update
RUN apt upgrade -y
RUN pip install --upgrade pip
# install git and build essentials
RUN apt-get install build-essential curl -y

# Install Poetry and uv
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"
RUN pip install uv

# Configure Poetry to use uv
RUN poetry config installer.modern-installation false

RUN mkdir /CrewAI-Studio
WORKDIR /CrewAI-Studio

# Copy pyproject.toml and poetry.lock (if exists)
COPY ./pyproject.toml ./poetry.lock* /CrewAI-Studio/

# Install dependencies
RUN poetry install --no-interaction --no-ansi --no-root

# Copy CrewAI-Studio
COPY ./ /CrewAI-Studio/

# Install the project
RUN poetry install --no-interaction --no-ansi

# Run app
CMD ["poetry", "run", "streamlit", "run", "./app/app.py", "--server.headless", "true"]
EXPOSE 8501
