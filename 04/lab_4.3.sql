# lab_4.3.sql

set format_csv_delimiter='~';
select count() from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv');


set format_csv_delimiter='~';
select sum(actual_amount) from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') limit 10;

set format_csv_delimiter='~';
select sum(toUInt32OrZero(approved_amount)),sum(toUInt32OrZero(recommended_amount)) from s3('https://learn-clickhouse.s3.us-east-2.amazonaws.com/operating_budget.csv') limit 10;

