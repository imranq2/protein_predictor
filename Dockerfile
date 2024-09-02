# Use the official Python image with a specific version
FROM python:3.12-slim-bookworm
# Define an argument to control whether to run pipenv lock
ARG RUN_PIPENV_LOCK=false

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# for compiling biotite
# Install necessary packages for building wheels
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    wget \
    git

# Install Cython if needed for biotite
RUN pip install --upgrade pip setuptools wheel cython

RUN pip install pipenv

# Create a working directory
WORKDIR /app

# Install dependencies
COPY Pipfile* ./

# Conditionally run pipenv lock based on the argument
RUN if [ "$RUN_PIPENV_LOCK" = "true" ]; then pipenv lock --dev --clear; fi

# Install all dependencies using the wheels
RUN pipenv sync --dev --system

# Copy the app code
COPY ./app /app

# Expose the port
EXPOSE 8000

# Command to run the application
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
