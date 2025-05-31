import pandas as pd
import sqlite3

df = pd.read_csv("cleaned_dataset.csv")

conn = sqlite3.connect("delivery_data.db")

df.to_sql("deliveries", conn, if_exists="replace", index=False)
