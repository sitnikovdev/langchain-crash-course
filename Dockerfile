# Use an official Python image as the base image
FROM python:3.11-slim

# Set environment variables for Poetry and locale settings
ENV POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

ENV PATH="$POETRY_HOME/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
#
# Add Poetry to PATH
ENV PATH="/root/.local/bin:${PATH}"
                    
# Set working directory
WORKDIR /app

# Copy dependency files first for caching purposes
COPY pyproject.toml  ./

# Install project dependencies
RUN poetry install --no-root

# Copy application code into the container
COPY . .

# Expose the port Jupyter Notebook will run on
EXPOSE 8888

# Command to run Jupyter Notebook
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
