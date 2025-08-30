import pandas as pd

# Load the original file
df = pd.read_csv("Datasets/Superstore.csv", encoding="latin1")

# Convert dates
df["Order Date"] = pd.to_datetime(df["Order Date"], format="%m/%d/%Y").dt.strftime("%Y-%m-%d")
df["Ship Date"] = pd.to_datetime(df["Ship Date"], format="%m/%d/%Y").dt.strftime("%Y-%m-%d")

# Drop duplicates
df = df.drop_duplicates()

# Clean text fields (remove newlines, extra quotes)
for col in df.select_dtypes(include="object").columns:
    df[col] = df[col].astype(str).str.replace("\n", " ", regex=False).str.replace("\r", " ", regex=False).str.replace('"', '""', regex=False)

# Save cleaned CSV with proper quoting
df.to_csv("Superstore_clean.csv", index=False, encoding="utf-8", quoting=1)  # quoting=1 → QUOTE_ALL
