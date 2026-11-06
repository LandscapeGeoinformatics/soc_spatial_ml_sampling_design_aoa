# k-fold Nearest Neighbour Distance Matching (kNNDM) cross-validation folds
# Method: Linnenbrink et al., 2024, https://doi.org/10.5194/gmd-17-5897-2024
# Software: CAST 1.1.1 (Meyer et al., 2026, https://doi.org/10.32614/CRAN.package.CAST)
# Input: updated_training_data.gpkg (1,004 soil organic carbon (SOC) samples, EPSG:3301)
#        baseline_aoa.tif (non-NA cells = mapped area used as prediction domain)
# Output: knndm_5folds.csv (one row per sample, in the same row order as updated_training_data.gpkg)

library(sf) # 1.1.0
library(terra) # 1.9.11
library(CAST) # 1.1.1

# Load data
df <- st_read("updated_training_data.gpkg")
area <- rast("baseline_aoa.tif") # used to define the prediction area

# Make kNNDM folds
# CAST samples 1,000 regular prediction points from the mapped area and selects the fold split whose test-to-training distances best match the prediction-to-training distances
set.seed(25)
kn5 <- knndm(df, modeldomain = area, k = 5)
kn5                             

# Save the folds with coordinates for the Python cross-validation work
# Fold is 0-4 (R uses 1-5); x/y are used in Python to check the row order
xy <- st_coordinates(df)
write.csv(data.frame(row = 0:(nrow(df) - 1), x = xy[, 1], y = xy[, 2], fold = kn5$clusters - 1), "knndm_5folds.csv", row.names = FALSE)
