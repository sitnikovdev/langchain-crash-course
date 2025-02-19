ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

# Use an official Python image as the base image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install Poetry
RUN pip install poetry python-dotenv

# Copy the project files into the container
COPY . .

# Install dependencies using Poetry without creating a virtual environment
RUN poetry install --no-dev -vvv

# Command to run the application, loading environment variables from .env file
CMD ["python", "app.py"]

