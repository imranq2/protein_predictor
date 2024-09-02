# Use the official Python image with a specific version
FROM python:3.12-slim-bookworm

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create a working directory
WORKDIR /app

# Install dependencies
COPY Pipfile ./
RUN pip install pipenv
# RUN pipenv install --deploy --system

# Copy the app code
COPY ./app /app

# Expose the port
EXPOSE 8000

# Command to run the application
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
