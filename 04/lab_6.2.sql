# lab_6.2.sql

select count(),avg(price) from uk_price_paid where date>='2020-01-01' and date<='2020-12-31' limit 10

select toYear(date),count(),avg(price) from uk_price_paid group by toYear(date)

CREATE TABLE prices_by_year_dest (
    price UInt32,
    date Date,
    addr1 String,
    addr2 String,
    street LowCardinality(String),
    town LowCardinality(String),
    district LowCardinality(String),
    county LowCardinality(String)
)
ENGINE = MergeTree
PRIMARY KEY (town, date)
PARTITION BY toYear(date);

CREATE MATERIALIZED VIEW prices_by_year_view
TO prices_by_year_dest
as select price,date,addr1,addr2,street,town,district,county from uk_price_paid


insert into prices_by_year_dest 
	select price,date,addr1,addr2,street,town,district,county from uk_price_paid

select count() from prices_by_year_des

select count(),avg(price) from prices_by_year_dest where toYear(date)=2020 limit 10

select * from prices_by_year_dest where date>='2005-06-01' and date<='2005-06-30' and county='STAFFORDSHIRE'

select max(price),avg(price),quantile(0.9)(price) from prices_by_year_dest where date>='2005-06-01' and date<='2005-06-30' and county='STAFFORDSHIRE' limit 10


