# lab_4.2.sql
desc s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/uk_property_prices.snappy.parquet')

```
Create a table that satisfies the following criteria:

a. The name of the table is uk_price_paid

b. Use the same column names that are in the Parquet file (the names returned from the DESCRIBE command)

c. Do not use NULLABLE on any column

d. The date column should be a Date

e. Make all of the String columns LowCardinality except addr1 and addr2

f. The type column is an enumeration that has the values:
'terraced' = 1, 'semi-detached' = 2, 'detached' = 3, 'flat' = 4, 'other' = 0

g. The duration column is an enumeration that has the values: 'freehold' = 1, 'leasehold' = 2, 'unknown' = 0

h. The table engine is MergeTree

i. The primary key is postcode1, postcode2, date (in that order)
```

CREATE TABLE test.uk_price_paid (
    price UInt32,
    date Date,
    postcode1 LowCardinality(String),
    postcode2 LowCardinality(String),
    type Enum('terraced' = 1, 'semi-detached' = 2, 'detached' = 3, 'flat' = 4, 'other' = 0),
    is_new UInt8,
    duration Enum('freehold' = 1, 'leasehold' = 2, 'unknown' = 0),
    addr1 String,
    addr2 String,
    locality LowCardinality(String),
    town LowCardinality(String),
    distinct LowCardinality(String),
    country LowCardinality(String)
)
ENGINE = MergeTree
PRIMARY KEY (postcode1,postcode2,date);

INSERT INTO test.uk_price_paid SELECT * from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/uk_property_prices.snappy.parquet')

# use the primary key search. only one granule need to load
select avg(price) from test.uk_price_paid where postcode1='LU1' and postcode2='5FT'

```
interesting, equal to search postcode1='*' and postcode2='5FT'.
how can the clickhouse handle in this case
```
select avg(price) from test.uk_price_paid where postcode2='5FT'

# do not match any column in primary key. clickhouse do the full table scan
select avg(price) from test.uk_price_paid where town='YORK'

# 



