# Utility functions for mass calculations

# Function to calculate the amount of mass needed based on label rate and target volume
calculate_application_rate <- function(label_mass_lbs, label_area_ft2, depth_in, target_volume_L) {
  # --- Constants ---
  LBS_TO_GRAMS <- 453.592000
  FT3_TO_LITERS <- 28.316800

  # --- Input Validation ---
  if (!is.numeric(label_mass_lbs) || label_mass_lbs <= 0) {
    stop("Label mass amount (lbs) must be a positive number.")
  }
  if (!is.numeric(label_area_ft2) || label_area_ft2 <= 0) {
    stop("Label area (ft²) must be a positive number.")
  }
  if (!is.numeric(depth_in) || depth_in <= 0) {
    stop("Label depth (in) must be a positive number.")
  }
  if (!is.numeric(target_volume_L) || target_volume_L <= 0) {
    stop("Target soil volume (L) must be a positive number.")
  }

  # --- Calculations ---

  # Convert depth from inches to feet
  depth_ft <- inches_to_feet(depth_in)

  # Step 1: Determine the Soil Volume for the Label Rate
  label_volume_ft3 <- label_area_ft2 * depth_ft

  # Step 2: Find the mass Concentration in lbs/ft³
  concentration_lbs_ft3 <- label_mass_lbs / label_volume_ft3

  # Step 3: Convert lbs/ft³ to grams per liter (g/L)
  concentration_g_ft3 <- concentration_lbs_ft3 * LBS_TO_GRAMS
  concentration_g_L <- concentration_g_ft3 / FT3_TO_LITERS

  # Step 4: Calculate the mass Required for the Target Volume
  total_mass_grams <- target_volume_L * concentration_g_L

  # --- Return Result ---
  # Returns a list containing the concentration and total grams needed
  return(list(
    concentration_g_L = concentration_g_L,
    total_mass_grams = total_mass_grams
  ))
}

# Helper function to convert inches to feet
inches_to_feet <- function(inches) {
    if (!is.numeric(inches) || inches < 0) {
        stop("Inches must be a non-negative number.")
    }
    return(inches / 12)
}

