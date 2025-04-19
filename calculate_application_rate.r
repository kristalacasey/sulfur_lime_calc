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


#' Estimate Sulfur Needed for pH Adjustment in Peat/Perlite Mix
#'
#' Estimates the amount of elemental sulfur needed to lower the pH of an
#' 80% peat / 20% perlite mix.
#'
#' @param starting_ph Numeric. The initial pH of the soil mix.
#' @param target_ph Numeric. The desired target pH (must be lower than starting_ph).
#' @param volume_L Numeric. The total volume of the soil mix in liters.
#'
#' @return A list containing the estimated grams of elemental sulfur needed
#'         and important notes regarding the estimation.
#' @export
#'
#' @examples
#' estimate_sulfur_for_ph(starting_ph = 7.0, target_ph = 6.2, volume_L = 76.16)
#'
#' @warning This function provides an ESTIMATE only. The actual buffering
#'   capacity of peat moss varies significantly. It is highly recommended to
#'   base applications on soil buffer tests or perform small-scale trials
#'   and incremental adjustments. Assumes elemental sulfur.
#'
estimate_sulfur_for_ph <- function(starting_ph, target_ph, volume_L) {

  # --- Estimated Constant for 80/20 Peat/Perlite ---
  # Grams of elemental sulfur per liter of mix estimated to lower pH by 1 unit.
  # Based on 5 grams per 10 liters per 1.0 pH unit change.
  SULFUR_GRAMS_PER_LITER_PER_PH_UNIT <- 0.5 # 5g / 10L = 0.5 g/L

  # --- Input Validation ---
  if (!is.numeric(starting_ph) || starting_ph <= 1 || starting_ph > 10) {
    stop("Starting pH must be a valid number, typically between 1 and 10.")
  }
  if (!is.numeric(target_ph) || target_ph <= 1 || target_ph > 10) {
    stop("Target pH must be a valid number, typically between 1 and 10.")
  }
   if (target_ph >= starting_ph) {
    stop("Target pH must be lower than starting pH to add sulfur.")
  }
  if (!is.numeric(volume_L) || volume_L <= 0) {
    stop("Volume (L) must be a positive number.")
  }

  # --- Calculations ---
  ph_change_needed <- starting_ph - target_ph

  estimated_sulfur_grams <- ph_change_needed * SULFUR_GRAMS_PER_LITER_PER_PH_UNIT * volume_L

  # --- Return Result ---
  return(list(
    estimated_sulfur_grams = estimated_sulfur_grams
  ))
}