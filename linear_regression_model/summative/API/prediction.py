from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import numpy as np
import os
import cloudpickle

# Load the best model using cloudpickle
model_path = os.path.join(os.path.dirname(__file__), "best_model.pkl")
if not os.path.exists(model_path):
    raise FileNotFoundError(f"❌ Model file not found at {model_path}")

with open(model_path, "rb") as f:
    model = cloudpickle.load(f)

# Initialize FastAPI app
app = FastAPI(title="Toxic Waste Prediction API")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Input data schema using Pydantic
class InputData(BaseModel):
    Country: int = Field(..., ge=0, le=10)
    Latitude: float = Field(..., ge=-3, le=3)
    Longitude: float = Field(..., ge=-3, le=3)
    Dumping_Entity: int = Field(..., ge=0, le=10)
    Legal_Actions: int = Field(..., ge=0, le=5)
    Year: float = Field(..., ge=-3, le=3)
    Waste_Type: int = Field(..., ge=0, le=10)

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to the Toxic Waste Prediction API"}

# POST /predict
@app.post("/predict")
def predict(data: InputData):
    input_array = np.array([[data.Country, data.Latitude, data.Longitude,
                              data.Dumping_Entity, data.Legal_Actions,
                              data.Year, data.Waste_Type]])
    prediction = model.predict(input_array)
    return {"predicted_waste_volume_tons": round(float(prediction[0]), 2)}
