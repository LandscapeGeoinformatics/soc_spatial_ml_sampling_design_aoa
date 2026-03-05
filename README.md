# soc_spatial_ml_sampling_design_aoa
Code supplement for the paper Optimisation of sampling design for spatial soil mapping with machine learning.

This repository contains the main scripts used to (1) compute the Area of Applicability (AOA), (2) generate candidate sampling locations using k-means clustering, (3) produce SOC predictions (baseline vs updated RF models), and (4) compare RF model performance via cross-validation.

## Table of contents

- [Repository structure](#repository-structure)
- [1. AOA computation](#1-area-of-applicability-aoa-computation)
- [2. K-means clustering](#2-k-means-clustering-candidate-sampling-strata)
- [3. SOC prediction](#3-soc-prediction-rf-models)
- [4. RF model performance](#4-cross-validation-rf-model-performance)
---

## Repository Structure

```text
├── data/           # .pkl, and .onnx model files
├── scripts/        # .ipynb notebooks for computation
├── remoteml_env.yml # Environment for remote workstation tasks
└── soilml_env.yml   # Environment for local clustering tasks
```
---

## 1) Area of Applicability (AOA) computation

AOA requires substantial compute and was run on a remote workstation using the conda environment:

- **Environment**: `remoteml_env.yml`

**Files and scripts**
- **Script:** `aoa_computation.ipynb`
Computes the AOA across Estonia to identify locations where SOC predictions rely on environmental conditions that are insufficiently represented in the training data (i.e., potential extrapolation).
- **SHAP weight inputs (used for feature weighting in AOA):**
  - `baseline_aoa_shap.pkl` (baseline AOA)
  - `updated_aoa_shap.pkl` (updated AOA)

---

## 2) K-means clustering (candidate sampling strata)

K-means clustering was run locally using:

- **Environment:** `soilml_env.yml`

**Files and scripts**
- **Script:** `kmeans_clustering.ipynb`  
Cluster the candidate sampling area (classified as beyond AOA) into **K = 200** groups to support sampling site selection. 
- **Feature weighting:** `baseline_aoa_shap.pkl`  
  Used to weight covariates (SHAP-weighted feature space) prior to clustering.

---

## 3) SOC prediction (RF models)

SOC prediction was run on the remote workstation using:

- **Environment:** `remoteml_env.yml`

**Files and scripts** `rf_soc_prediction.ipynb`
- **Models (ONNX):**
  - `baseline_RF_soc.onnx` (baseline SOC prediction)
  - `updated_RF_soc.onnx` (updated SOC prediction)

---

## 4) Cross-validation (RF model performance)

**Files and scripts**
- **Script:** `rf_cross_validation.ipynb`  
  Computes cross-validation metrics for baseline vs updated RF models.
- **Inputs:**
  - `original_training_data.gpkg` (baseline model)
  - `updated_training_data.gpkg` (updated model)

---