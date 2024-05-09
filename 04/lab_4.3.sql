# lab_4.3.sql

set format_csv_delimiter='~';
select count() from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv');


set format_csv_delimiter='~';
select sum(actual_amount) from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') limit 10;

set format_csv_delimiter='~';
select sum(toUInt32OrZero(approved_amount)),sum(toUInt32OrZero(recommended_amount)) from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') limit 10;

```
The schema_inference_hints setting can be a great time saver, but for this particular CSV file it is not helping. To really make this work, we need to ingest the data into a MergeTree table with proper data types. Start by creating a new table named operating_budget that satisfies the following requirements:

a. Uses the MergeTree table engine

b. Contains the following columns as LowCardinality(String):

i. fiscal_year, service, department, program, item_category, and fund

c. Contains a String column for description

d. Contains the following columns as UInt32:

i. approved_amount and recommended_amount

e. Contains a new program_code column as LowCardinality(String). This data is derived from the program column as explained later.

f. Contains a Decimal(12,2) column for actual_amount

g. The fund_type is an Enum with three values:

i. GENERAL FUNDS, FEDERAL FUNDS, and OTHER FUNDS

h. The PRIMARY KEY is (fiscal_year, program)
```

DESC s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') settings format_csv_delimiter='~'

CREATE TABLE test.operating_budget (
    fiscal_year LowCardinality(String),
    service LowCardinality(String),
    department LowCardinality(String),
    program LowCardinality(String),
    description String,
    item_category LowCardinality(String),
    approved_amount UInt32,
    recommended_amount UInt32,
    actual_amount Decimal(12,2),
    fund LowCardinality(String),
    fund_type Enum('GENERAL FUNDS'=1,'FEDERAL FUNDS'=2,'OTHER FUNDS'=0),
    program_code LowCardinality(String)
)
ENGINE = MergeTree
PRIMARY KEY (fiscal_year,program);

select c1 as fiscal_year,c2 as service,c3 as department,c4 as program,
c5 as description,c6 as item_category,c7 as approved_amount,
c8 as recommended_amount,c9 as actual_amount,c10 as fund,
c11 as fund_type,splitByChar(')',splitByChar('(',assumeNotNull(c4))[2])[1] as program_code 
from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') limit 10 settings format_csv_delimiter='~',input_format_csv_skip_first_lines=1\G

