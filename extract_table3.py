import pandas as pd
import sys

excel_file = "resultat-ansokningsomgang-2025.xlsx"

try:
    df = pd.read_excel(excel_file, sheet_name="Tabell 3", header=None)

    header_row = None
    for i, row in df.iterrows():
        if "Utbildningsområde" in str(row.values):
            header_row = i
            break

    if header_row is not None:
        df.columns = df.iloc[header_row]
        df = df[header_row + 1:]
        df = df.reset_index(drop=True)
        df.to_csv("ansokningar_2025.csv", index=False, encoding="utf-8-sig")
        print(f"Klart! Sparade {len(df)} rader till ansokningar_2025.csv")
    else:
        print("Kunde inte hitta rubrikraden.")

except Exception as e:
    print(f"Fel: {e}")
    sys.exit(1)

