# filename: hemp_waste.r
# Title: Hemp Waste Management - Soil Amendment and pH Adjustment Calculations
# Description: This script calculates the application rate
# of a soil amendment based on label rate and estimates the elemental sulfur
# needed for pH adjustment in a peat/perlite mix.
# Author: Kristal Casey
# Date: 2025-04-19

# Load the necessary functions
source("calculate_application_rate.r")

# --- Input Parameters for Application Rate ---
# The parameters for the calculation based on a product label.
label_mass_lbs <- 2.5         # lbs of amendment per label area
label_area_ft2 <- 500.0       # Area covered by label mass
depth_in <- 6.0               # Depth incorporated
target_volume_L_rate <- 76.16 # Target volume for rate calculation

# --- Input Parameters for pH Adjustment ---
starting_ph <- 7.6
target_ph <- 6.2
volume_L_ph <- 76.16

# --- Perform Application Rate Calculation ---
rate_calculation_result <- calculate_application_rate(
  label_mass_lbs = label_mass_lbs,
  label_area_ft2 = label_area_ft2,
  depth_in = depth_in,
  target_volume_L = target_volume_L_rate
)

# --- Perform pH Adjustment Calculation ---
ph_calculation_result <- estimate_sulfur_for_ph(
  starting_ph = starting_ph,
  target_ph = target_ph,
  volume_L = volume_L_ph
)

# --- Display Results ---
# Print the inputs and outputs in a nicely formatted way.

cat("--- Soil Amendment Application Rate Calculation (Based on Label Rate) ---\n\n")

cat("Input Parameters (Rate):\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.2f lbs\n", "Label Mass Amount", label_mass_lbs))
cat(sprintf("%-25s: %.2f ft²\n", "Label Area", label_area_ft2))
cat(sprintf("%-25s: %.2f inches\n", "Label Depth", depth_in))
cat(sprintf("%-25s: %.2f Liters\n", "Target Soil Volume", target_volume_L_rate))
cat("--------------------------------------------------\n\n")

cat("Calculated Results (Rate):\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.4f g/L\n", "Required Concentration", rate_calculation_result$concentration_g_L))
cat(sprintf("%-25s: %.2f grams\n", "Total Mass Needed", rate_calculation_result$total_mass_grams))
cat("--------------------------------------------------\n\n")

cat("--- Estimated Sulfur for pH Adjustment (80/20 Peat/Perlite Mix) ---\n\n")

cat("Input Parameters (pH):\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.2f\n", "Starting pH", starting_ph))
cat(sprintf("%-25s: %.2f\n", "Target pH", target_ph))
cat(sprintf("%-25s: %.2f Liters\n", "Volume for Adjustment", volume_L_ph))
cat("--------------------------------------------------\n\n")

cat("Calculated Results (pH):\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.2f grams\n", "Estimated Sulfur Needed", ph_calculation_result$estimated_sulfur_grams))
# Calculate and print sulfur per liter
sulfur_per_liter <- ph_calculation_result$estimated_sulfur_grams / volume_L_ph
cat(sprintf("%-25s: %.4f g/L\n", "Sulfur per Liter", sulfur_per_liter))
cat("--------------------------------------------------\n")