import pandas as pd
import io
import sys

def transform_disease_data(input_csv: str) -> str:
    """
    Transform disease risk factor data from detailed CSV format to simplified schema.
    
    Args:
        input_csv (str): Input CSV data as string with schema: 
                        disease,risk_factor,region,sex,age,value
    
    Returns:
        str: Transformed data as CSV string with schema:
             disease,risk_factor,age,value
    """
    # Read input CSV
    df = pd.read_csv(io.StringIO(input_csv))
    
    # Create mapping for age ranges to individual years
    age_mapping = {
        '30 to 39': range(30, 40),
        '40 to 49': range(40, 50),
        '50 to 59': range(50, 60),
        '60 to 69': range(60, 70),
        '70 to 79': range(70, 80),
        '80 to 100': range(80, 101)
    }
    
    # Initialize list to store transformed records
    transformed_records = []
    
    # Get unique disease-risk_factor combinations
    unique_pairs = df[['disease', 'risk_factor']].drop_duplicates()
    
    for _, row in unique_pairs.iterrows():
        disease = row['disease']
        risk_factor = row['risk_factor']
        
        # Get reference values from first region/sex combination
        reference_data = df[
            (df['disease'] == disease) & 
            (df['risk_factor'] == risk_factor)
        ].drop_duplicates(subset=['age', 'value'])
        
        # Create records for all ages 0-100
        for age in range(101):
            value = 1.0  # Default value
            
            # Find matching age range and use its value if age is in defined ranges
            for age_range, value_range in age_mapping.items():
                if age in value_range:
                    matching_row = reference_data[reference_data['age'] == age_range]
                    if not matching_row.empty:
                        value = matching_row.iloc[0]['value']
                    break
            
            transformed_records.append({
                'disease': disease.replace('Ischemic Heart Disease', 'IHD'),
                'risk_factor': risk_factor,
                'age': age,
                'value': value
            })
    
    # Create DataFrame from transformed records
    result_df = pd.DataFrame(transformed_records)
    
    # Sort the DataFrame
    result_df = result_df.sort_values(['disease', 'risk_factor', 'age'])
    
    # Convert back to CSV string
    output_csv = result_df.to_csv(index=False)
    
    return output_csv

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py input_file.csv output_file.csv")
        sys.exit(1)
        
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    try:
        # Read input file
        with open(input_file, 'r') as f:
            input_csv = f.read()
            
        # Transform data
        output_csv = transform_disease_data(input_csv)
        
        # Write output file
        with open(output_file, 'w') as f:
            f.write(output_csv)
            
        print(f"Successfully transformed data from {input_file} to {output_file}")
        
    except FileNotFoundError:
        print(f"Error: Could not find input file {input_file}")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {str(e)}")
        sys.exit(1)