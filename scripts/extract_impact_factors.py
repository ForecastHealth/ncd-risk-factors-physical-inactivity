"""
extract_impact_factors.py

This script consolidates the process of extracting impact factors from various sources,
including RiskFactorData.xls, hardcoded data, and alcohol-specific worksheets.
It aims to faithfully replicate the whole process of extraction to ensure no steps are missed.
"""

import pandas as pd
import argparse
import sys

# Constants
RISK_FACTORS = {
    'tobacco': 'NC_RFSmoke',
    'alcohol': 'NC_RFAlcohol',
    'inactivity': 'NC_RFInactivity',
    'sodium': 'NC_RFSodiumIntake',
    'obesity': 'NC_RFOverweight'
}

INTERVENTION_LABEL_MAP = {
    # Tobacco
    "Monitor tobacco use/prevention policies": "NC_RFTobaccoPolicy",
    "Protect people from tobacco smoke": "NC_RFTobaccoProtect",
    "Offer to help quit tobacco use: Brief intervention": "NC_RFTobaccoQuitBrief",
    "Offer to help quit tobacco use: mCessation": "NC_RFTobaccoQuitmCessation",
    "Warn about danger: Warning Labels": "NC_RFTobaccoWarnLabel",
    "Warn about danger: Mass Media Campaign": "NC_RFTobaccoWarnMassMedia",
    "Enforce bans on tobacco advertising": "NC_RFTobaccoBan",
    "Enforce youth access restriction": "NC_RFTobaccoEnforceYouth",
    "Raise taxes on tobacco": "NC_RFTobaccoTax",
    "Plain packaging of tobacco products": "NC_RFTobaccoPackaging",
    # Alcohol
    "Enforce restrictions on availability of retailed alcohol": "NC_RFAlcoholRestrict",
    "Enforce restrictions on alcohol advertising": "NC_RFAlcoholBanAdvert",
    "Raise taxes on alcoholic beverages": "NC_RFAlcoholBanTax",
    "Enforce drink driving laws (sobriety checkpoints)": "NC_RFAlcoholDriveLaws",
    "Screening and brief intervention for hazardous and harmful alcohol use": "NC_RFAlcoholCounsel",
    # Physical Inactivity
    "Awareness campaigns to encourage increased physical activity": "NC_RFPhysicalActivityAwreness",
    "Brief advice as part of routine care": "NC_RFPhysicalActivityAdvice",
    # Sodium
    "Surveillance": "NC_RFSodiumSurveillance",
    "Harness industry for reformulation": "NC_RFSodiumReformulation",
    "Adopt Standards: Front of Pack Labelling": "NC_RFSodiumPackLabelling",
    "Adopt Standards: Strategies to combat misleading marketing": "NC_RFSodiumMisleadingMarket",
    "Knowledge: Education and Communication": "NC_RFSodiumKnowledge",
    "Environment: Salt reduction strategies in community based eating spaces": "NC_RFSodiumEnvSaltReduct",
    # Reducing Obesity
    "Complete elimination of industrial trans fats": "NC_RFObesityKillTransFats",
    "Replace saturated fats with unsaturated fats through reformulation, labelling and fiscal policy": "NC_RFObesityReplaceSatFats",
    "Reduce sugar consumption through taxation on sugar sweetened beverages": "NC_RFObesityReduceSugarTax",
}

AGE_GROUPS = [
    '15 to 19', '20 to 24', '25 to 29', '30 to 39', '40 to 49',
    '50 to 59', '60 to 69', '70 to 79', '80 to 100'
]

ALC_INTERVENTION_MAP = {
    "Alc_BriefIntvIdx": "Alc_BriefIntv",
    "Alc_AvailRestrIdx": "Alc_AvailRestr",
    "Alc_MarktRestrIdx": "Alc_MarktRestr",
    "Alc_DriveMortIdx": "AlcDrivingImpact"
}

def load_data(file_path, sheet_name):
    return pd.read_excel(file_path, sheet_name=sheet_name, header=None)

def process_riskfactor_data(df, risk_factor=None):
    results = []
    current_risk_factor = None
    current_level = None

    for _, row in df.iterrows():
        if pd.notna(row[0]) and 'Risk Factors, level' in str(row[0]):
            current_level = int(row[0].split('level')[1])
        elif pd.notna(row[0]) and any(rf in str(row[0]) for rf in RISK_FACTORS.values()):
            current_risk_factor = row[0]
            if 'Hazardous Alcohol Use,Enforce drink driving laws' in current_risk_factor:
                impact_type = 'Deaths' if 'Deaths' in current_risk_factor else 'YLD'
                levels = [int(s) for s in current_risk_factor if s.isdigit()]
            else:
                impact_type = 'NC_RiskBurden'
        elif pd.notna(row[0]) and current_risk_factor is not None:
            intervention = row[0]
            if not all(value == 0 for value in row[1:] if pd.notna(value)):
                for sex, start_col in [('male', 1), ('female', 11)]:
                    for age, value in zip(AGE_GROUPS, row[start_col:start_col+9]):
                        if pd.notna(value) and value != 0:
                            if impact_type in ['Deaths', 'YLD']:
                                if current_level in levels:
                                    results.append({
                                        'source': 'extracted',
                                        'risk_factor': RISK_FACTORS['alcohol'],
                                        'intervention': INTERVENTION_LABEL_MAP[intervention],
                                        'impact_type': impact_type,
                                        'level': current_level,
                                        'sex': sex,
                                        'age': age,
                                        'value': value
                                    })
                            else:
                                if risk_factor and RISK_FACTORS[risk_factor] != current_risk_factor:
                                    continue
                                results.append({
                                    'source': 'extracted',
                                    'risk_factor': current_risk_factor,
                                    'intervention': INTERVENTION_LABEL_MAP[intervention],
                                    'impact_type': impact_type,
                                    'level': current_level,
                                    'sex': sex,
                                    'age': age,
                                    'value': value
                                })

    return pd.DataFrame(results)

def create_hardcoded_impact_data(risk_factor=None):
    data = []
    hardcoded_data = [
        ("NC_RFInactivity", "NC_RFPhysicalActivityAdvice", 15.0),
        ("NC_RFInactivity", "NC_RFPhysicalActivityAwreness", 5.0),
        ("NC_RFSodiumIntake", "NC_RFSodiumEnvSaltReduct", 17.0),
        ("NC_RFSodiumIntake", "NC_RFSodiumReformulation", 57.0),
        ("NC_RFSodiumIntake", "NC_RFSodiumPackLabelling", 6.4),
        ("NC_RFSodiumIntake", "NC_RFSodiumKnowledge", 48.6),
        ("NC_RFOverweight", "NC_RFTransFatPublicProcurement", 93.0),
        ("NC_RFOverweight", "NC_RFTransFatFrontPackLabelling", 2.95),
        ("NC_RFOverweight", "NC_RFSSBPublicProcurement", 18.0),
        ("NC_RFOverweight", "NC_RFSSBTax", 15.0),
        ("NC_RFOverweight", "NC_RFFiberFrontPackLabelling", 80.0),
        ("NC_RFOverweight", "NC_RFFruitPublicProcurement", 76.0),
        ("NC_RFOverweight", "NC_RFFruitMassMedia", 25.0),
        ("NC_RFOverweight", "NC_RFLegumePublicProcurement", 28.0),
        ("NC_RFOverweight", "NC_RFLegumeMassMedia", 25.0),
    ]

    for rf, intervention, value in hardcoded_data:
        if risk_factor and RISK_FACTORS[risk_factor] != rf:
            continue
        for level in [1, 2, 3, 4]:
            for sex in ['male', 'female']:
                for age in AGE_GROUPS:
                    data.append({
                        'source': 'hard_coded',
                        'risk_factor': rf,
                        'intervention': intervention,
                        'impact_type': 'NC_RiskBurden',
                        'level': level,
                        'sex': sex,
                        'age': age,
                        'value': value
                    })

    return pd.DataFrame(data)

def process_alcohol_data(excel_file, risk_factor=None):
    # Placeholder for alcohol data processing
    # This function should be implemented to process alcohol-specific worksheets
    return pd.DataFrame()

def create_data(risk_factor=None):
    # 1. Extract data from RiskFactorData.xls -> ImpactFactors
    input_file = './data/RiskFactorData.xls'
    worksheet = 'ImpactFactors'
    raw_data = load_data(input_file, worksheet)
    extracted_data = process_riskfactor_data(raw_data, risk_factor)
    
    # 2. Generate data from hardcoded method
    hardcoded_data = create_hardcoded_impact_data(risk_factor)

    # 3. Process the Alcohol Worksheets (placeholder)
    alcohol_data = process_alcohol_data(input_file, risk_factor)
    
    # 4. Merge the datasets, with hardcoded data taking precedence
    merged_data = pd.concat([extracted_data, hardcoded_data, alcohol_data]).drop_duplicates(
        subset=['risk_factor', 'intervention', 'impact_type', 'level', 'sex', 'age'],
        keep='last'
    )
    
    # Apply any necessary transformations
    merged_data['value'] = pd.to_numeric(merged_data['value'], errors='coerce')
    
    # Sort the data
    merged_data = merged_data.sort_values([
        'risk_factor', 'intervention', 'impact_type', 'level', 'sex', 'age'
    ])
    
    # Select only the required columns in the specified order
    merged_data = merged_data[[
        'source', 'risk_factor', 'intervention', 'impact_type', 'level', 'sex', 'age', 'value'
    ]]
    
    return merged_data

def list_risk_factors():
    print("Available risk factors:")
    for short_name, full_name in RISK_FACTORS.items():
        print(f"- {short_name}: {full_name}")

def main():
    parser = argparse.ArgumentParser(description='Extract impact factors from Excel file.')
    parser.add_argument('--risk-factor', help='Specific risk factor to extract')
    parser.add_argument('--list', action='store_true', help='List all available risk factors')
    args = parser.parse_args()

    if args.list:
        list_risk_factors()
        sys.exit(0)

    if args.risk_factor and args.risk_factor not in RISK_FACTORS:
        print(f"Error: '{args.risk_factor}' is not a valid risk factor.")
        list_risk_factors()
        sys.exit(1)

    data = create_data(args.risk_factor)
    
    if args.risk_factor:
        output_file = f"./tmp/impact_factors_{args.risk_factor}.csv"
    else:
        output_file = "./tmp/impact_factors.csv"
    
    data.to_csv(output_file, index=False)
    print(f"Conversion complete. Output saved to {output_file}")

if __name__ == "__main__":
    main()
