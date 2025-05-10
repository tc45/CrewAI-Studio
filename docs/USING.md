# Using CrewAI Studio

CrewAI Studio is a user-friendly, no-code interface for orchestrating AI agents, tasks, and tools using CrewAI. This guide explains how to configure and use the application, with a focus on frontend features and configuration options.

---

## Table of Contents
- [Installation](#installation)
- [Configuration](#configuration)
- [Frontend Features Overview](#frontend-features-overview)
  - [Crews](#crews)
  - [Agents](#agents)
  - [Tasks](#tasks)
  - [Tools](#tools)
  - [Knowledge Sources](#knowledge-sources)
  - [Kickoff! (Run Crews)](#kickoff-run-crews)
  - [Results](#results)
  - [Import/Export](#importexport)
- [Theme and UI Customization](#theme-and-ui-customization)
- [Troubleshooting](#troubleshooting)

---

## Installation

You can install and run CrewAI Studio using one of the following methods:

### 1. Virtual Environment (Linux/Mac/Windows)
- Run the provided install and run scripts for your OS:
  - Linux/Mac: `./install_venv.sh` then `./run_venv.sh`
  - Windows: `install_venv.bat` then `run_venv.bat`

### 2. Conda (Linux/Mac/Windows)
- Run the provided install and run scripts for your OS:
  - Linux/Mac: `./install_conda.sh` then `./run_conda.sh`
  - Windows: `install_conda.bat` then `run_conda.bat`

### 3. Docker Compose
- Copy `.env_example` to `.env` and edit as needed.
- Run: `docker-compose up --build`
- Access at: [http://localhost:8501](http://localhost:8501)

---

## Configuration

Before running, configure your `.env` file with the required API keys and options. Example options:

```
# OPENAI_API_KEY="FILL-IN-YOUR-OPENAI-API-KEY"
# OPENAI_API_BASE="OPTIONAL-FILL-IN-YOUR-OPENAI-CUSTOM-BASE/PROXY-URL"
# OPENAI_PROXY_MODELS="openai/gpt4o,openai/gpt4omini,openai/geminiflash,openai/geminipro,openai/claudesonnet35"
# GROQ_API_KEY="FILL-IN-YOUR-GROQ_API_KEY"
# LMSTUDIO_API_BASE="http://localhost:1234/v1"
# ANTHROPIC_API_KEY="FILL-IN-YOUR-ANTHROPIC_API_KEY"
# AGENTOPS_API_KEY="FILL-IN-YOUR-AGENTOPS_API_KEY"
# XAI_API_KEY="FILL-IN-YOUR-XAI_API_KEY"
# OLLAMA_HOST="http://localhost:11434"
# OLLAMA_MODELS="ollama/llama3.2,ollama/llama3.1,ollama/gemma2,ollama/phi3.5"
# SERPER_API_KEY="your-serper-api-key"
# DB_URL=postgresql://crewai_user:secret@db:5432/crewai
AGENTOPS_ENABLED="False"
```

- **API Keys**: Set keys for LLM providers (OpenAI, Groq, Anthropic, LM Studio, Ollama, etc.) as needed.
- **SERPER_API_KEY**: Required for web search tool.
- **AGENTOPS_ENABLED**: Set to `True` to enable AgentOps integration.
- **DB_URL**: (Optional) Set to use a custom Postgres database.

---

## Frontend Features Overview

CrewAI Studio is organized into several main tabs, accessible from the sidebar:

### Crews
- **Create, edit, and delete crews**.
- Configure crew properties:
  - Name, process type (sequential/hierarchical), verbosity, memory, cache, planning, max requests/minute.
  - Assign agents and tasks to crews.
  - (Hierarchical) Assign a manager LLM and/or manager agent.

### Agents
- **Create, edit, and delete agents**.
- Configure agent properties:
  - Role, backstory, goal, temperature, allow delegation, verbosity, cache, LLM provider/model, max iterations.
  - Assign tools and knowledge sources to agents.
- Agents can be assigned to one or more crews.

### Tasks
- **Create, edit, and delete tasks**.
- Configure task properties:
  - Description, expected output, assigned agent, async execution, context from other tasks.
- Tasks can be assigned to one or more crews.

### Tools
- **Enable and configure tools** for use by agents.
- Available tools include:
  - Web scraping, file reading, code/document search, API calls, code execution, CSV/JSON/MDX/PDF/DOCX search, GitHub search, and more.
- Configure tool parameters (API keys, URLs, file paths, etc.).
- Enabled tools can be assigned to agents.

### Knowledge Sources
- **Add and manage knowledge sources** (text, files, PDFs, CSVs, Excel, JSON, DocLing URLs, etc.).
- Configure chunk size, overlap, and metadata for each source.
- Assign knowledge sources to agents (and optionally to crews).
- Clear all cached knowledge stores if needed.

### Kickoff! (Run Crews)
- **Select a crew and run it** with the configured agents, tasks, and tools.
- Fill in any required placeholders before running.
- View live console output and stop a running crew if needed.
- Results are saved automatically.

### Results
- **View history of previous runs**.
- Filter results by crew or date.
- View inputs and outputs (rendered and raw).
- Delete results or open a printable view.

### Import/Export
- **Export crews as single-page Streamlit apps** (with all agents, tasks, and tools included).
- Export/import crews or the entire database as JSON.
- Download and upload JSON files for backup or sharing.

---

## Theme and UI Customization

- The UI uses a dark theme by default. You can customize colors in `.streamlit/config.toml`:

```
[theme]
primaryColor="#f05252"
backgroundColor="#111111"
secondaryBackgroundColor="#222222"
textColor="#dddddd"
base = "dark"
```

---

## Troubleshooting
- If you encounter issues:
  - Delete the `venv/miniconda` folder and reinstall.
  - Rename or delete `crewai.db` if database compatibility issues occur.
  - Raise an issue on GitHub for further help.

---

## Video Tutorial
- [YouTube: CrewAI Studio GUI EASY AI Agent Creation!](https://www.youtube.com/watch?v=3Uxdggt88pY)

---

For more details, see the main [README.md](../README.md). 