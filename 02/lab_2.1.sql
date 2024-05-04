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


# Re-run the query from Step 6 above that returned the top 100 downloaded projects, but this time filter the results by only downloads that occurred in April of 2023. (Hint: check the toStartOfMonth() or toDate() functions.)
select count() as c,PROJECT from test.pypi where TIMESTAMP>=toDate('2023-04-01') group by PROJECT order by c desc limit 100

# Write a query that only counts downloads of Python projects that start with "boto". (Hint: LIKE allows partial matches.)
SELECT 
    PROJECT,
    count() AS c
FROM test.pypi
WHERE PROJECT LIKE 'boto%'
GROUP BY PROJECT
ORDER BY c DESC;
