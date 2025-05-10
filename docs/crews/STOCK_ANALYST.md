# Stock Analysis Crew Configuration Guide

This guide explains how to configure a Stock Analysis Crew in CrewAI Studio's UI for analyzing stocks using multiple specialized agents.

## Overview

The Stock Analysis Crew consists of three specialized agents:
- Research Analyst
- Financial Analyst
- Investment Advisor

The crew performs tasks sequentially to analyze a stock and provide investment recommendations.

## Agent Configuration

### 1. Research Analyst
Configure in the Agents tab:
```yaml
Name: Research Analyst
Role: Stock Market Research Analyst
Goal: Conduct thorough research on the company, its market position, and industry trends
Backstory: Experienced research analyst with expertise in market research and competitive analysis
Tools:
  - ScrapeWebsiteTool
  - SEC10QTool
  - SEC10KTool
Settings:
  - Allow Delegation: false
  - Temperature: 0.7
  - Verbose: true
  - LLM: ollama/llama2
```

### 2. Financial Analyst
Configure in the Agents tab:
```yaml
Name: Financial Analyst
Role: Financial Analysis Expert
Goal: Analyze financial statements, ratios, and metrics to evaluate the company's financial health
Backstory: Senior financial analyst with deep expertise in financial statement analysis and valuation
Tools:
  - ScrapeWebsiteTool
  - WebsiteSearchTool
  - CalculatorTool
  - SEC10QTool
  - SEC10KTool
Settings:
  - Allow Delegation: false
  - Temperature: 0.4
  - Verbose: true
  - LLM: ollama/llama2
```

### 3. Investment Advisor
Configure in the Agents tab:
```yaml
Name: Investment Advisor
Role: Investment Recommendation Specialist
Goal: Synthesize research and analysis to provide actionable investment recommendations
Backstory: Seasoned investment advisor with experience in portfolio management and risk assessment
Tools:
  - ScrapeWebsiteTool
  - WebsiteSearchTool
  - CalculatorTool
Settings:
  - Allow Delegation: false
  - Temperature: 0.5
  - Verbose: true
  - LLM: ollama/llama2
```

## Task Configuration

Configure the following tasks in the Tasks tab:

### 1. Research Task
```yaml
Name: Research
Description: Research the company's market position, competitive landscape, and industry trends
Expected Output: Comprehensive market analysis report including competitive position and industry trends
Agent: Research Analyst
Context Required: false
```

### 2. Financial Analysis Task
```yaml
Name: Financial Analysis
Description: Analyze the company's financial statements, key metrics, and performance indicators
Expected Output: Detailed financial analysis report with key metrics and performance evaluation
Agent: Financial Analyst
Context Required: true
Dependencies: [Research]
```

### 3. Filings Analysis Task
```yaml
Name: Filings Analysis
Description: Analyze SEC filings (10-K and 10-Q) for important disclosures and financial data
Expected Output: Analysis of key findings from SEC filings including risks and financial trends
Agent: Financial Analyst
Context Required: true
Dependencies: [Financial Analysis]
```

### 4. Recommendation Task
```yaml
Name: Recommend
Description: Synthesize all analyses to provide an investment recommendation
Expected Output: Detailed investment recommendation with supporting rationale and risk factors
Agent: Investment Advisor
Context Required: true
Dependencies: [Research, Financial Analysis, Filings Analysis]
```

## Crew Configuration

In the Crews tab:

```yaml
Name: Stock Analysis Crew
Process: Sequential
Memory: Enabled
Verbose: true
Agents:
  - Research Analyst
  - Financial Analyst
  - Investment Advisor
Tasks (in order):
  1. Research
  2. Financial Analysis
  3. Filings Analysis
  4. Recommend
```

## Tool Configuration

### Required Tools Setup

1. **ScrapeWebsiteTool**
   - No specific configuration needed

2. **WebsiteSearchTool**
   - No specific configuration needed

3. **CalculatorTool**
   - No specific configuration needed

4. **SEC10KTool**
   - Configure in Tools tab:
     ```yaml
     Name: SEC10KTool
     Parameters:
       - SEC_API_API_KEY: Your SEC API key
     ```

5. **SEC10QTool**
   - Configure in Tools tab:
     ```yaml
     Name: SEC10QTool
     Parameters:
       - SEC_API_API_KEY: Your SEC API key
     ```

## Usage

1. Set up all agents, tools, and tasks as described above
2. In the Crews tab, create a new crew and add the configured agents and tasks
3. Set the process to "Sequential"
4. Enable verbose mode for detailed execution logs
5. When running the crew, you'll need to provide:
   - Stock symbol (e.g., "AMZN")
   - Any specific analysis parameters or focus areas

## Environment Setup

Ensure these environment variables are set in your `.env` file:
```
SEC_API_API_KEY=your_sec_api_key
OLLAMA_BASE_URL=your_ollama_url
```

## Expected Outputs

The crew will generate:
1. Market research report
2. Financial analysis
3. SEC filings analysis
4. Final investment recommendation

Each output will be available in the Results tab after the crew completes its execution. 