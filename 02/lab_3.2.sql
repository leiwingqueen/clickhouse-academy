# lab_3.2.sql

```
┌─name─────────┬─type──────────────┐
│ trade_date   │ Nullable(UInt16)  │  
│ crypto_name  │ Nullable(String)  │ 
│ volume       │ Nullable(Float32) │ 
│ price        │ Nullable(Float32) │ 
│ market_cap   │ Nullable(Float32) │ 
│ change_1_day │ Nullable(Float32) │ 
└──────────────┴───────────────────┘
```

# Define a new table named crypto_prices that satisfies the following requirements:

# a. Use the column names and data types above, except: 

# i. do not use Nullable on any columns

# ii. change trade_date to a Date

# iii. use LowCardinality for the crypto_name

# b. The table engine is MergeTree

# c. The primary key is the crypto_name followed by the trade_date

CREATE TABLE crypto_prices (
	trade_date Date,
	crypto_name LowCardinality(String),
	volume Float32,
	price Float32,
	market_cap Float32,
	change_1_day Float32
)
ENGINE = MergeTree
PRIMARY KEY (trade_date,crypto_name);

select avg(price) from crypto_prices where crypto_name='Bitcoin' limit 10

select crypto_name,avg(price) from crypto_prices where crypto_name like 'B%' group by crypto_name limit 100

