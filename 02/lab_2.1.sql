# lab2.1

# describe table
DESCRIBE s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/pypi/2023/pypi_0_7_34.snappy.parquet');

# create table
create table test.pypi(
	TIMESTAMP DateTime64(3),
	COUNTRY Nullable(String),
	URL Nullable(String),
	PROJECT Nullable(String),
	primary key TIMESTAMP
)ENGINE = MergeTree

# insert rows
insert into test.pypi select TIMESTAMP,COUNTRY_CODE,URL,PROJECT from s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/pypi/2023/pypi_0_7_34.snappy.parquet')

# Write a query using the count() function that returns the top 100 downloaded projects (i.e. the count() of the PROJECT column).
select count() as c,PROJECT from test.pypi group by PROJECT order by c desc limit 100