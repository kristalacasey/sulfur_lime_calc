# filename: sulfur_treatment.r
# Title: Sulfur Treatment Calculations for Hemp waste pH Adjustment
# Description: This script calculates the estimated elemental sulfur required
#              to adjust the pH of different Hemp waste based on
#              starting pH values. 
# Author: Kristal Casey
# Date: 2025-04-19

source("calculate_application_rate.r")

# --- Common Parameters ---
target_ph <- 6.2
volume_L <- 76.16

# --- Scenario Definitions ---
# Define the starting pH values for each experimental condition
scenarios <- list(
  "Medium_Mix_80_Percent" = list(starting_ph = 6.88, description = "Medium Mix, 80% Hemp waste"),
  "Medium_Mix_100_Percent" = list(starting_ph = 7.62, description = "Medium Mix, 100% Hemp waste"),
  "Small_Mix_80_Percent" = list(starting_ph = 6.74, description = "Small Mix, 80% Hemp waste"),
  "Small_Mix_100_Percent" = list(starting_ph = 7.18, description = "Small Mix, 100% Hemp waste")
)

# --- Perform Calculations and Display Results ---
cat("--- Sulfur Requirement Calculations for pH Adjustment ---\n\n")
cat(sprintf("Target pH for all scenarios: %.2f\n", target_ph))
cat(sprintf("Volume for all scenarios: %.2f Liters\n\n", volume_L))

# Loop through each scenario, calculate, and print results
for (name in names(scenarios)) {
  scenario <- scenarios[[name]]
  starting_ph <- scenario$starting_ph
  description <- scenario$description

  # Perform pH Adjustment Calculation
  ph_calculation_result <- estimate_sulfur_for_ph(
    starting_ph = starting_ph,
    target_ph = target_ph,
    volume_L = volume_L
  )

  # Display Results for the current scenario
  cat(paste("--- Scenario:", description, "---\n"))
  cat("Input Parameters:\n")
  cat(sprintf("  %-25s: %.2f\n", "Starting pH", starting_ph))
  cat(sprintf("  %-25s: %.2f\n", "Target pH", target_ph))
  cat(sprintf("  %-25s: %.2f Liters\n", "Volume for Adjustment", volume_L))
  cat("Calculated Results:\n")
  cat(sprintf("  %-25s: %.2f grams\n", "Estimated Sulfur Needed", ph_calculation_result$estimated_sulfur_grams))
  sulfur_per_liter <- ph_calculation_result$estimated_sulfur_grams / volume_L
  cat(sprintf("  %-25s: %.4f g/L\n", "Sulfur per Liter", sulfur_per_liter))
  cat("--------------------------------------------------\n\n")
}

cat("--- End of Calculations ---\n")