# soc_spatial_ml_sampling_design_aoa
Code supplement for the paper Optimisation of sampling design for spatial soil mapping with machine learning.

This repository contains the main scripts used to (1) compute the Area of Applicability (AOA), (2) generate candidate sampling locations using k-means clustering, (3) produce SOC predictions (baseline vs updated RF models), and (4) compare RF model performance via cross-validation.

---

## 1) Area of Applicability (AOA) computation

AOA requires substantial compute and was run on a remote workstation using the conda environment:

- **Environment:** `remoteml_env.yml`

**Files and scripts**
- **Script:** `aoa_computation.py`
- **Training data inputs:**
  - `original_training_data.gpkg` (baseline AOA)
  - `updated_training_data.gpkg` (updated AOA)
- **SHAP weight inputs (used for feature weighting in AOA):**
  - `baseline_aoa_shap.pkl` (baseline AOA)
  - `updated_aoa_shap.pkl` (updated AOA)

---

## 2) K-means clustering (candidate sampling strata)

K-means clustering was run locally using:

- **Environment:** `soilml_env.yml`

**Files and scripts**
- **Script:** `kmeans_clustering.py`  
Cluster the candidate sampling area (classified as beyond AOA) into **K = 200** groups to support sampling site selection. 
- **Feature weighting:** `baseline_aoa_shap.pkl`  
  Used to weight covariates (SHAP-weighted feature space) prior to clustering.

---

## 3) SOC prediction (RF models)

SOC prediction was run on the remote workstation using:

- **Environment:** `remoteml_env.yml`

**Files and scripts**
- **Models (ONNX):**
  - `baseline_RF_soc.onnx` (baseline SOC prediction)
  - `updated_RF_soc.onnx` (updated SOC prediction)

---

## 4) Cross-validation (RF model performance)

**Files and scripts**
- **Script:** `rf_cross_validation.py`  
  Computes cross-validation metrics for baseline vs updated RF models.
- **Inputs:**
  - `original_training_data.gpkg` (baseline model)
  - `updated_training_data.gpkg` (updated model)

---
