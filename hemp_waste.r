# filename: hemp_waste.r
# Title: Hemp Waste Management and Soil Amendment Application Rate Calculation
# Description: This script calculates the application rate of a soil amendment based on user-defined parameters such as label mass, area, depth, and target volume. 
#  It includes input validation and conversion functions to ensure accurate calculations.
# Author: Kristal Casey
# Date: 2025-04-19

source("calculate_application_rate.r")

# --- Input Parameters ---
# Define the parameters for the calculation based on our study.
label_mass_lbs <- 2.5
label_area_ft2 <- 500.0
depth_in <- 6.0
target_volume_L <- 76.16

# --- Perform Calculation ---
# Call the function with the defined parameters.
calculation_result <- calculate_application_rate(
  label_mass_lbs = label_mass_lbs,
  label_area_ft2 = label_area_ft2,
  depth_in = depth_in,
  target_volume_L = target_volume_L
)

# --- Display Results ---
# Print the inputs and outputs in a nicely formatted table for clarity.

cat("--- Soil Amendment Application Rate Calculation ---\n\n")

cat("Input Parameters:\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.2f lbs\n", "Label Mass Amount", label_mass_lbs))
cat(sprintf("%-25s: %.2f ft²\n", "Label Area", label_area_ft2))
cat(sprintf("%-25s: %.2f inches\n", "Label Depth", depth_in))
cat(sprintf("%-25s: %.2f Liters\n", "Target Soil Volume", target_volume_L))
cat("--------------------------------------------------\n\n")

cat("Calculated Results:\n")
cat("--------------------------------------------------\n")
cat(sprintf("%-25s: %.4f g/L\n", "Required Concentration", calculation_result$concentration_g_L))
cat(sprintf("%-25s: %.2f grams\n", "Total Mass Needed", calculation_result$total_mass_grams))
cat("--------------------------------------------------\n")
