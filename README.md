# Code supplement for the paper Area of applicability-guided targeted sampling for spatial soil mapping with machine learning.

[![DOI](https://zenodo.org/badge/1172630142.svg)](https://doi.org/10.5281/zenodo.18889938)

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
├── models/          # .pkl and .onnx model files
├── scripts/         # .ipynb notebooks, R script (kNNDM folds) and fold file
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
- **Script:** `knndm_folds.R`
  Creates the k-fold nearest neighbour distance matching (kNNDM) cross-validation folds with the CAST R package (R 4.5.3, CAST 1.1.1).
- **Inputs:**
  - `updated_training_data.gpkg`
  - `baseline_aoa.tif` (non-NA cells = mapped area used as the prediction domain)
- **Output:**
  - `knndm_5folds.csv` (included in this repository)

- **Script:** `rf_cross_validation.ipynb`
  Computes random and kNNDM cross-validation metrics for baseline vs updated RF models.
- **Inputs:**
  - `updated_training_data.gpkg`
  - `knndm_5folds.csv`

Note: `knndm_5folds.csv` is provided, so `rf_cross_validation.ipynb` can be run without R. Run `knndm_folds.R` only to recreate the folds. Input data (`updated_training_data.gpkg`, `baseline_aoa.tif`) are available on Zenodo: https://doi.org/10.5281/zenodo.18861968.

---
