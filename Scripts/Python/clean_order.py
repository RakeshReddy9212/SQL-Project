import pandas as pd

df = pd.read_csv("Datasets/orders.csv", encoding="latin1")
#print(df.to_string())

# Changing DATE Formate 

df['order_date'] =pd.to_datetime(df['order_date'],format="%m/%d/%Y").dt.strftime("%Y-%m-%d")
df['ship_date'] =pd.to_datetime(df['ship_date'],format="%m/%d/%Y").dt.strftime("%Y-%m-%d")

df = df.drop_duplicates()

df.to_csv("clean_orders.csv", index=False, encoding="utf-8")
print(df.to_string())