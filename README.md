# Toxic Waste Risk Predictor

## Mission
Our mission is to use data and machine learning to address environmental and public health challenges in Africa. This app helps **predict the estimated toxic waste volume (in tons)** for reported incidents, enabling **quicker environmental risk assessments** and **informed decision-making** by agencies and local authorities.

---

## Use Case: Predicting Toxic Waste Volume
Unlike generic regression examples (e.g., house price prediction), this project addresses a **critical and real-world problem**: **estimating environmental damage** from waste-dumping activities across African countries.

---

## Dataset

- **Filename**: `toxic_waste_dataset_cleaned.csv`
- **Source**: [GitHub CSV from Kaggle-cleaned dataset](https://raw.githubusercontent.com/rodwol/new_LR/main/linear_regression_model/summative/linear_regression/toxic_waste_dataset_cleaned.csv)
- **Size**: 300+ rows (approx.), 10+ features
- **Features include**:
  - Country (coded)
  - Latitude & Longitude
  - Dumping Entity (e.g., Government, Individual)
  - Legal Actions (None, Investigation, Prosecuted)
  - Waste Type (Chemical, Radioactive, Industrial)
  - Year
  - **Target**: Estimated Waste Volume (in tons)

---

## Exploratory Data Analysis

We applied **visualizations to guide model learning**:

### 1. Correlation Heatmap
Helps detect relationships between features and avoid multicollinearity issues.

### 2. Distribution Plot (Histogram)
Visualizes the skew and distribution of the target variable (Estimated Waste Volume).

---

## Models & Training

We trained and compared 3 regression models using **scikit-learn**:

| Model                  | Evaluation Metric | Loss (MSE) |
|------------------------|-------------------|------------|
| Linear Regression (SGD) | Mean Squared Error (MSE) | ✔️ Calculated |
| Decision Tree Regressor | MSE | ✔️ Calculated |
| Random Forest Regressor | MSE | ✔️ Calculated |

The model with the **lowest loss** was saved using `joblib`.

---

## Loss Curve

Train vs Test MSE over iterations to visualize learning and prevent overfitting.

---

## Final Regression Line (Scatter Plot)

We plotted predicted vs actual waste volumes to assess how well the linear model fits the data.

---

## Model Deployment Flow

```
Model → FastAPI (with Pydantic + CORS) → Flutter App
```

---

## Folder Structure

```
linear_regression_model/
│
├── summative/
│   ├── linear_regression/
│   │   ├── multivariate.ipynb
│   │   ├── toxic_waste_dataset_cleaned.csv
│
│   ├── API/
│   │   ├── prediction.py
│   │   ├── requirements.txt
│   │   ├── best_model.pkl
│
│   ├── FlutterApp/
│   │   ├── lib/
│   │   │   ├── main.dart
│   │   │   ├── intro_page.dart
│   │   │   ├── input_page.dart
│   │   │   ├── result_page.dart
│   │   ├── pubspec.yaml
│
├── README.md ✅
```

---

## API Endpoint (FastAPI)

- **Base URL**:
- **Method**: `POST /predict`
- **Input**:
```json
{
  "Country": 5,
  "Latitude": 0.34,
  "Longitude": -0.23,
  "Dumping_Entity": 2,
  "Legal_Actions": 1,
  "Year": 0.25,
  "Waste_Type": 3
}
```
- **Output**:
```json
{
  "predicted_volume": 52.1
}
```

---

## Flutter App Preview

- Accepts 7 input fields (dropdowns + coordinates + year)
- "Predict" button calls the FastAPI backend
- Displays prediction or error message
- Supports input validation and range-checks

---

## Demo Video

[Demo (5 mins)](https://www.canva.com/design/DAGuhRQChfY/3ShJka-8cluUOac2GdTtpQ/edit?utm_content=DAGuhRQChfY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

---

## Future Improvements

- Time Series Forecasting – Predict trends by year or region
- Geospatial Modeling – Use GIS and clustering for risk zones
- Severity Classification – Add a classifier for incident severity
- Explainable AI – Use SHAP/LIME for interpretability
- Real-time Data – Pull from environmental monitoring stations
- Crowdsourced Reporting – Allow public to report incidents
- Multilingual Support – Local African languages

---

## Setup Instructions

### Run the API (Locally)
```bash
cd linear_regression_model/summative/API
pip install -r requirements.txt
uvicorn prediction:app --reload
```

### Deploy API on Render
1. Create a `render.yaml`
2. Push to GitHub
3. Connect Render → New Web Service → Use GitHub repo

### Run Flutter App
```bash
cd /linear_regression_model/summative/FlutterApp
flutter pub get
flutter run
```

---

