import pandas as pd
import argparse
import sys
import re

# Constants
REGIONS = [
    'Andean Latin America', 'Australasia', 'Caribbean', 'Central Asia', 'Central Europe',
    'Central Latin America', 'Central sub-Saharan Africa', 'East Asia', 'Eastern Europe',
    'Eastern sub-Saharan Africa', 'High-income Asia Pacific', 'North Africa and Middle East',
    'North America, High Income', 'Oceania', 'South Asia', 'Southeast Asia',
    'Southern Latin America', 'Southern sub-Saharan Africa', 'Tropical Latin America',
    'Western Europe', 'Western sub-Saharan Africa'
]

DISEASES = [
    'Ischemic Heart Disease', 'Ischemic Stroke', 'Breast Cancer', 'Cervical Cancer',
    'Colorectal Cancer', 'Lung Cancer', 'Diabetes', 'Asthma', 'COPD', 'Epilepsy',
    'Depression', 'Liver Cancer', 'Oral Cancer', 'Oesophageal Cancer', 'Pancreatic Cancer',
    'Larynx Cancer', 'Lower Respiratory Infections', 'Hemorrhagic Stroke', 'Tuberculosis',
    'Hypertension', 'Liver Cirrhosis', 'Conduction Disorders', 'Pancreatitis',
    'Injuries and Violence', 'Not Specified'
]

RISK_FACTORS = {
    'alcohol': 'Hazardous and harmful alcohol use',
    'inactivity': 'Physical Inactivity',
    'tobacco': 'Tobacco',
    'blood_pressure': 'Mean systolic blood pressure (mmHG)',
    'cholesterol': 'Mean total cholesterol (mmol/L)',
    'bmi': 'Mean BMI (kg/m2)',
    'sodium': 'Mean sodium intake (g/day)'
}

AGE_GROUPS = [
    '15 to 19', '20 to 24', '25 to 29', '30 to 39', '40 to 49',
    '50 to 59', '60 to 69', '70 to 79', '80 to 100'
]

def load_data(file_path, sheet_name):
    return pd.read_excel(file_path, sheet_name=sheet_name, header=None)

def process_data(df, risk_factor=None):
    results = []
    current_region = None
    current_disease = None
    current_risk_factor = None

    for _, row in df.iterrows():
        if pd.notna(row.iloc[0]) and row.iloc[0] in REGIONS:
            current_region = row.iloc[0]
        elif pd.notna(row.iloc[0]) and row.iloc[0] in DISEASES:
            current_disease = row.iloc[0]
        elif pd.notna(row.iloc[0]) and row.iloc[0] in RISK_FACTORS.values():
            current_risk_factor = row.iloc[0]
            if risk_factor and current_risk_factor != RISK_FACTORS[risk_factor]:
                continue
            male_values = row.iloc[1:10]
            female_values = row.iloc[12:21]  # Adjusted to skip the 'Female' label
            
            for sex, values in [('Male', male_values), ('Female', female_values)]:
                for age, value in zip(AGE_GROUPS, values):
                    if pd.notna(value) and not isinstance(value, str):
                        results.append({
                            'disease': current_disease,
                            'risk_factor': current_risk_factor,
                            'region': current_region,
                            'sex': sex,
                            'age': age,
                            'value': value
                        })
    
    return pd.DataFrame(results)

def list_risk_factors():
    print("Available risk factors:")
    for short_name, full_name in RISK_FACTORS.items():
        print(f"- {short_name}: {full_name}")

def main():
    parser = argparse.ArgumentParser(description='Extract relative risks from Excel file.')
    parser.add_argument('--risk-factor', help='Specific risk factor to extract')
    parser.add_argument('--list', action='store_true', help='List all available risk factors')
    args = parser.parse_args()

    if args.list:
        list_risk_factors()
        sys.exit(0)

    input_file = './data/RiskFactorData.xls'
    worksheet = 'RR'
    
    if args.risk_factor:
        if args.risk_factor not in RISK_FACTORS:
            print(f"Error: '{args.risk_factor}' is not a valid risk factor.")
            list_risk_factors()
            sys.exit(1)
        output_file = f'./tmp/relative_risks_{args.risk_factor}.csv'
    else:
        output_file = './tmp/relative_risks.csv'

    raw_data = load_data(input_file, worksheet)
    processed_data = process_data(raw_data, args.risk_factor)
    processed_data.to_csv(output_file, index=False)
    print(f"Conversion complete. Output saved to {output_file}")

if __name__ == "__main__":
    main()
