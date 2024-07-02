#!/bin/bash

# -----------------------------------------------
# Extract Inactivity Data
# -----------------------------------------------
# This script runs a series of Python scripts to extract various
# types of data related to physical inactivity. It extracts:
# 1. Prevalence data (for all risk factors)
# 2. Relative risks for inactivity
# 3. Impact factors for inactivity
#
# Usage:
#   ./extract_inactivity_data.sh
#
# No arguments are required. This script is specifically
# designed to extract data for the 'inactivity' risk factor.
# -----------------------------------------------

# Set the risk factor to 'inactivity'
RISK_FACTOR="inactivity"

echo "Extracting data for risk factor: $RISK_FACTOR"

# Run the Python scripts
echo "Extracting prevalence data..."
python -m scripts.extract_prevalence

echo "Extracting relative risks for inactivity..."
python -m scripts.extract_relative_risks --risk-factor "$RISK_FACTOR"

echo "Extracting impact factors for inactivity..."
python -m scripts.extract_impact_factors --risk-factor "$RISK_FACTOR"

echo "Extraction complete."
