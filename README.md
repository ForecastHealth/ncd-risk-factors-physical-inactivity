# NCD Risk Factor: Physical Inactivity

## Overview

This repository provides a translation of the risk factor `NC_RFInactivity` from Spectrum. It serves as a foundation for future modifications of the risk factor and its associated interventions as new model releases become available.

## Data Components

Risk Factors analysis requires three types of data:

1. Prevalence
2. Relative Risks
3. Intervention Impacts (Impact Factors)

### Data Sources

| Data Type | File Path | Worksheet Name |
|-----------|-----------|----------------|
| Prevalence | `./data/GBD_Country_Data.xlsx` | PIA_Guthold_2018 |
| Relative Risks | `./data/RiskFactorData.xls` | RR |
| Impact Factors | `./data/RiskFactorData.xls` | ImpactFactors |

### Accessing the Data

The Spectrum data is available in the `data/` directory of this repository.

For a computer-friendly version of this data:

1. Clone this repository
2. Run the `./extract_data.sh` script

**Prerequisites:**
- Bash shell
- Python (accessible via `python` command)

## Interventions

### P1: Primary Care Integration

**Intervention:** Provide physical activity assessment, counselling, and behaviour change support as part of routine primary health care services through the use of a brief intervention.

**Implementation:**
- Brief advice as part of routine care (95% coverage)

### P2: Population-wide Communication Campaigns

**Intervention:** Implement sustained, population-wide, best practice communication campaigns to promote physical activity, with links to community-based programmes and environmental improvements to enable and support behaviour change.

**Implementation:**
- Awareness campaigns to encourage increased physical activity (95% coverage)

## Contributing

[Notes on how to contribute]

## License

[Insert appropriate license information here]

## Contact

For questions or further information, please contact [insert contact information].
