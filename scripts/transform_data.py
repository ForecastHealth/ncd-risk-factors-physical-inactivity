import pandas as pd

DATA_INPUT_FILEPATH = "./data/GBD_Country_Data.xlsx"
DATA_OUTPUT_FILEPATH = "./data/physical_inactivity.csv"

def main():
    df = pd.read_excel(
        DATA_INPUT_FILEPATH,
        sheet_name="PIA_Guthold_2018",
        skiprows=1,
        skipfooter=3
    )

    processed_data = []

    age_ranges = ["0_4", "5_9", "10_14", "15_19", "20_24", "25_29", "30_39", "40_49", "50_59", "60_69", "70_79", "80_100"]

    for _, row in df.iterrows():
        iso = row["ISO"]
        if iso == "KNA":
            continue

        for i, age_range in enumerate(age_ranges):
            value = row[df.columns[i+5]]  # Male columns start at index 5
            if pd.isna(value):
                continue

            start_age, end_age = map(int, age_range.split("_"))

            for age in range(start_age, end_age + 1):
                processed_data.append([iso, "Male", age, value])

        for i, age_range in enumerate(age_ranges):
            value = row[df.columns[i+18]]  # Female columns start at index 18
            if pd.isna(value):
                continue

            start_age, end_age = map(int, age_range.split("_"))

            for age in range(start_age, end_age + 1):
                processed_data.append([iso, "Female", age, value])

    output_df = pd.DataFrame(processed_data, columns=["ISO", "Sex", "Age", "Value"])

    output_df.to_csv(DATA_OUTPUT_FILEPATH, index=False)

if __name__ == "__main__":
    main()
