# pr# ESM3 Predictor

This is a FastAPI application that allows users to input a protein sequence and receive a predicted sequence along with a downloadable `.pdb` file.

## Setup

1. Install the dependencies using Pipenv:
    ```bash
    pipenv install
    ```

2. Run the FastAPI application:
    ```bash
    uvicorn app.main:app --reload
    ```

## Docker

To build and run the Docker container:

```bash
docker build -t esm3_predictor .
docker run -d -p 8000:8000 esm3_predictor
otein_predictor
