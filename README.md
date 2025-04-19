# Amendment and pH Adjustment Calculation Toolkit

**Author:** Kristal Casey

## Abstract

This project provides R scripts to calculate soil amendment application rates and estimate the required amounts of elemental sulfur or lime for pH adjustment in peat-based growing media. The calculations are designed to support experimental setups, particularly those involving the incorporation of hemp waste, by providing standardized methods for determining amendment quantities based on label instructions or target pH shifts derived from experimental data.

## Methodology

The toolkit comprises functions for two primary tasks:

1.  **Application Rate Calculation (`calculate_application_rate`):**
    *   Determines the mass of a soil amendment needed for a target soil volume.
    *   Inputs: Amendment mass (lbs), area coverage (ft²), and incorporation depth (inches) as specified on a product label, and the target soil volume (L).
    *   Outputs: Required concentration (g/L) and total mass (g) for the target volume.
    *   Conversions: Utilizes standard conversion factors (lbs to grams, ft³ to Liters).

2.  **pH Adjustment Estimation (`estimate_sulfur_for_ph`, `estimate_lime_for_ph`):**
    *   Estimates the mass of elemental sulfur (to lower pH) or lime (to raise pH) required to reach a target pH.
    *   Inputs: Starting pH, target pH, and total soil volume (L).
    *   Outputs: Estimated mass (g) of sulfur or lime needed.
    *   Constants: Employs experimentally derived constants representing the grams of amendment per liter required to shift the pH by one unit in the specified peat/perlite mix.
        *   Sulfur: Based on 0.5 g/L per 1.0 pH unit reduction.
        *   Lime: Based on ~4.38 g/L per 1.0 pH unit increase (derived from experimental observations: 500g/76.16L per 1.5 pH units).

## File Structure

*   `calculate_application_rate.r`: Contains the core functions `calculate_application_rate`, `estimate_sulfur_for_ph`, and `estimate_lime_for_ph`.
*   `hemp_waste_example.r`: Demonstrates the usage of `calculate_application_rate` and `estimate_sulfur_for_ph` with example parameters.
*   `sulfur_treatment.r`: Applies `estimate_sulfur_for_ph` and `estimate_lime_for_ph` to specific experimental scenarios involving different hemp waste percentages and starting pH values.
*   `README.md`: This file.

## Usage

1.  Ensure R is installed.
2.  Set the working directory to the project folder in your R environment.
3.  Modify input parameters within the example scripts (`hemp_waste_example.r`, `sulfur_treatment.r`) or call the functions directly from `calculate_application_rate.r` after sourcing it (`source("calculate_application_rate.r")`).
4.  Execute the desired R script (e.g., `source("sulfur_treatment.r")`). Output will be printed to the console.

## Important Considerations

*   **Estimates Only:** The pH adjustment calculations (`estimate_sulfur_for_ph`, `estimate_lime_for_ph`) provide estimates. The actual buffering capacity of growing media, especially those containing organic amendments like hemp waste, can vary significantly.
*   **Verification Recommended:** It is strongly advised to validate these estimates through laboratory soil buffer tests or small-scale trials before applying amendments to the entire experimental volume. Incremental adjustments based on measured pH changes are recommended.
*   **Assumptions:** Calculations assume the use of standard elemental sulfur and agricultural lime. The effectiveness of amendments depends on factors like particle size and specific chemical composition.