# filename: sulfur_treatment.r
# Title: Sulfur and Lime Treatment Calculations for Hemp Waste pH Adjustment
# Description: This script calculates the elemental sulfur or lime required
# to adjust the pH of different Hemp waste mixes based on starting pH values. 
# The target pH and volume are consistent across calculations.
# Author: Kristal Casey
# Date: 2025-04-19

# Load the necessary functions for pH adjustment calculations
source("calculate_application_rate.r")

# --- Common Parameters ---
target_ph <- 6.2
volume_L <- 76.16

# --- Scenario Definitions for Sulfur (pH Lowering) ---
sulfur_scenarios <- list(
  "Sulfur_Med_80_Percent" = list(starting_ph = 6.88, description = "Medium Mix, 80% Hemp waste (Sulfur)"),
  "Sulfur_Med_100_Percent" = list(starting_ph = 7.62, description = "Medium Mix, 100% Hemp waste (Sulfur)"),
  "Sulfur_Small_80_Percent" = list(starting_ph = 6.74, description = "Small Mix, 80% Hemp waste (Sulfur)"),
  "Sulfur_Small_100_Percent" = list(starting_ph = 7.18, description = "Small Mix, 100% Hemp waste (Sulfur)")
)

# --- Scenario Definitions for Lime (pH Raising) ---
lime_scenarios <- list(
  "Control_0_Percent" = list(starting_ph = 5.36, description = "Control Mix, 0% Hemp waste (Lime)"),
  "Lime_Med_20_Percent" = list(starting_ph = 5.08, description = "Medium Mix, 20% Hemp waste (Lime)"),
  "Lime_Med_40_Percent" = list(starting_ph = 5.08, description = "Medium Mix, 40% Hemp waste (Lime)"),
  "Lime_Med_60_Percent" = list(starting_ph = 5.58, description = "Medium Mix, 60% Hemp waste (Lime)"),
  "Lime_Small_20_Percent" = list(starting_ph = 4.86, description = "Small Mix, 20% Hemp waste (Lime)"),
  "Lime_Small_40_Percent" = list(starting_ph = 5.24, description = "Small Mix, 40% Hemp waste (Lime)"),
  "Lime_Small_60_Percent" = list(starting_ph = 6.00, description = "Small Mix, 60% Hemp waste (Lime)")
)


# --- Perform Sulfur Calculations and Display Results ---
cat("--- Sulfur Requirement Calculations for pH Adjustment (Lowering pH) ---\n\n")
cat(sprintf("Target pH for all scenarios: %.2f\n", target_ph))
cat(sprintf("Volume for all scenarios: %.2f Liters\n\n", volume_L))

# Loop through each sulfur scenario, calculate, and print results
for (name in names(sulfur_scenarios)) {
  scenario <- sulfur_scenarios[[name]]
  starting_ph <- scenario$starting_ph
  description <- scenario$description

  # Check if sulfur is needed (starting pH > target pH)
  if (starting_ph > target_ph) {
    # Perform pH Adjustment Calculation (Sulfur)
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
  } else {
    cat(paste("--- Scenario:", description, "---\n"))
    cat(sprintf("Starting pH (%.2f) is not above target pH (%.2f). Sulfur not needed.\n", starting_ph, target_ph))
    cat("--------------------------------------------------\n\n")
  }
}

# --- Perform Lime Calculations and Display Results ---
cat("\n\n--- Lime Requirement Calculations for pH Adjustment (Raising pH) ---\n\n")
cat(sprintf("Target pH for all scenarios: %.2f\n", target_ph))
cat(sprintf("Volume for all scenarios: %.2f Liters\n\n", volume_L))

# Loop through each lime scenario, calculate, and print results
for (name in names(lime_scenarios)) {
  scenario <- lime_scenarios[[name]]
  starting_ph <- scenario$starting_ph
  description <- scenario$description

  # Check if lime is needed (starting pH < target pH)
  if (starting_ph < target_ph) {
    # Perform pH Adjustment Calculation (Lime)
    ph_calculation_result <- estimate_lime_for_ph(
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
    cat(sprintf("  %-25s: %.2f grams\n", "Estimated Lime Needed", ph_calculation_result$estimated_lime_grams))
    lime_per_liter <- ph_calculation_result$estimated_lime_grams / volume_L
    cat(sprintf("  %-25s: %.4f g/L\n", "Lime per Liter", lime_per_liter))
    cat("--------------------------------------------------\n\n")
  } else {
     cat(paste("--- Scenario:", description, "---\n"))
     cat(sprintf("Starting pH (%.2f) is not below target pH (%.2f). Lime not needed.\n", starting_ph, target_ph))
     cat("--------------------------------------------------\n\n")
  }
}

cat("--- End of Calculations ---\n")