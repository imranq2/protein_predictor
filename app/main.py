from fastapi import FastAPI, Form, UploadFile, File
from fastapi.responses import FileResponse
from esm.sdk.api import ESM3InferenceClient, ESMProtein, GenerationConfig
import torch
import os

app = FastAPI()

# Set the device to MPS (for Mac M1/M2) or CPU
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")

# Load the ESM 3.0.4 model
model: ESM3InferenceClient = ESM3InferenceClient.from_pretrained("esm3_sm_open_v1").to(device)

@app.post("/predict")
async def predict_sequence(sequence: str = Form(...)):
    protein = ESMProtein(sequence=sequence)

    # Generate the sequence prediction
    protein = model.generate(protein, GenerationConfig(track="sequence", num_steps=8, temperature=0.7))
    predicted_sequence = protein.sequence

    # Generate the secondary structure prediction and save to a PDB file
    protein = model.generate(protein, GenerationConfig(track="structure", num_steps=8))
    pdb_filename = "./predicted_structure.pdb"
    protein.to_pdb(pdb_filename)

    return {"predicted_sequence": predicted_sequence, "pdb_file": pdb_filename}

@app.get("/download-pdb")
async def download_pdb():
    pdb_filename = "./predicted_structure.pdb"
    return FileResponse(pdb_filename, media_type="application/octet-stream", filename="predicted_structure.pdb")
