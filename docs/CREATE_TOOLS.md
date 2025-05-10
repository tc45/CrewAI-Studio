# Creating Custom Tools in CrewAI Studio

This guide explains how to implement new tools in CrewAI Studio, including both basic tools and more complex RAG-based tools.

## Table of Contents
- [Basic Tool Structure](#basic-tool-structure)
- [Tool Types](#tool-types)
- [Implementation Steps](#implementation-steps)
- [Advanced Tool Features](#advanced-tool-features)
- [Integration with CrewAI Studio](#integration-with-crewai-studio)
- [Examples](#examples)

## Basic Tool Structure

Every tool in CrewAI Studio needs to implement these basic components:

```python
class MyTool:
    def __init__(self, tool_id, name, description, parameters, **kwargs):
        self.tool_id = tool_id
        self.name = name
        self.description = description
        self.parameters = kwargs
        self.parameters_metadata = parameters

    def create_tool(self):
        pass  # Implement tool creation logic

    def get_parameters(self):
        return self.parameters

    def set_parameters(self, **kwargs):
        self.parameters.update(kwargs)
```

## Tool Types

CrewAI Studio supports several types of tools:

1. **Basic Tools**: Simple tools that perform specific actions
2. **RAG Tools**: Tools that use Retrieval-Augmented Generation
3. **API Tools**: Tools that interact with external APIs
4. **Custom Tools**: Tools with specialized functionality

## Implementation Steps

### 1. Define Tool Schema

For tools that require input validation, define a Pydantic schema:

```python
from pydantic.v1 import BaseModel, Field

class MyToolSchema(BaseModel):
    parameter1: str = Field(..., description="Description of parameter 1")
    parameter2: int = Field(..., description="Description of parameter 2")
```

### 2. Create Tool Class

Create your tool class inheriting from the appropriate base class:

```python
from crewai_tools import BaseTool  # or RagTool, etc.

class MyCustomTool(BaseTool):
    name: str = "My Custom Tool"
    description: str = "Description of what the tool does"
    args_schema: Type[BaseModel] = MyToolSchema

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Initialize tool-specific attributes

    def _run(self, **kwargs):
        # Implement tool logic here
        pass
```

### 3. Register Tool with CrewAI Studio

Add your tool to the `TOOL_CLASSES` dictionary in `app/my_tools.py`:

```python
class MyCustomToolWrapper(MyTool):
    def __init__(self, tool_id=None, param1=None, param2=None):
        parameters = {
            'param1': {'mandatory': True},
            'param2': {'mandatory': False}
        }
        super().__init__(tool_id, 'MyCustomTool', 
                        "Tool description", parameters,
                        param1=param1, param2=param2)

    def create_tool(self):
        return MyCustomTool(**self.parameters)

# Add to TOOL_CLASSES
TOOL_CLASSES = {
    'MyCustomTool': MyCustomToolWrapper,
    # ... other tools ...
}
```

## Advanced Tool Features

### RAG-based Tools

For tools that need RAG capabilities (like your SEC tools example):

```python
from crewai_tools import RagTool

class MyRagTool(RagTool):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Initialize RAG-specific features
        
    def add(self, *args: Any, **kwargs: Any):
        kwargs["data_type"] = DataType.TEXT  # or other data type
        super().add(*args, **kwargs)

    def _run(self, query: str, **kwargs):
        return super()._run(query=query, **kwargs)
```

### Dynamic Parameters

For tools that need dynamic parameter handling:

```python
class DynamicToolSchema(BaseModel):
    """Schema that changes based on initialization"""
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Modify schema based on initialization parameters
```

## Integration with CrewAI Studio

### UI Integration

To add a form for dynamic tool creation:

1. Create a new page component in `app/pages/`
2. Add form fields for tool parameters
3. Implement tool registration logic

Example structure:
```python
class ToolCreationPage:
    def draw(self):
        st.title("Create New Tool")
        
        tool_type = st.selectbox("Tool Type", 
                               ["Basic", "RAG", "API"])
        
        name = st.text_input("Tool Name")
        description = st.text_area("Description")
        
        # Dynamic parameter fields based on tool type
        params = self.draw_parameter_fields(tool_type)
        
        if st.button("Create Tool"):
            self.create_tool(tool_type, name, description, params)
```

### Database Integration

Tools need to be persisted in the database:

```python
def save_tool(tool):
    data = {
        'name': tool.name,
        'description': tool.description,
        'parameters': tool.parameters,
        'type': tool.__class__.__name__
    }
    save_entity('tool', tool.tool_id, data)
```

## Examples

### SEC 10K/10Q Tool Implementation

Here's how to implement SEC filing tools (simplified version):

```python
class SEC10KTool(RagTool):
    name: str = "SEC 10-K Search Tool"
    description: str = "Search 10-K SEC filings"
    args_schema: Type[BaseModel] = SEC10KToolSchema

    def __init__(self, stock_name: Optional[str] = None, **kwargs):
        super().__init__(**kwargs)
        if stock_name:
            content = self.get_10k_content(stock_name)
            if content:
                self.add(content)
                self._update_description(stock_name)

    def _run(self, search_query: str, **kwargs):
        return super()._run(query=search_query, **kwargs)
```

### Integration Example

```python
# In my_tools.py
class MySEC10KTool(MyTool):
    def __init__(self, tool_id=None, stock_name=None):
        parameters = {
            'stock_name': {'mandatory': True}
        }
        super().__init__(tool_id, 'SEC10KTool',
                        "Search 10-K SEC filings",
                        parameters, stock_name=stock_name)

    def create_tool(self):
        return SEC10KTool(stock_name=self.parameters.get('stock_name'))

TOOL_CLASSES['SEC10KTool'] = MySEC10KTool
```

## Best Practices

1. **Error Handling**: Implement robust error handling in your tools
2. **Documentation**: Provide clear descriptions and parameter documentation
3. **Validation**: Use Pydantic schemas for input validation
4. **Testing**: Create unit tests for your tools
5. **Resource Management**: Properly manage API keys and external resources

## Next Steps

To implement the dynamic tool creation form:

1. Create a new page for tool creation
2. Implement the tool registration system
3. Add database support for custom tools
4. Create a tool management interface