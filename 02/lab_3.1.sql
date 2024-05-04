# lab_3.1.sql

select count(distinct(COUNTRY_CODE)),count(distinct(PROJECT)),uniqExact(URL) from test.pypi3 limit 100

CREATE OR REPLACE TABLE test.pypi5 (
    TIMESTAMP DateTime,
    COUNTRY_CODE LowCardinality(String),
    URL String,
    PROJECT LowCardinality(String) 
)
ENGINE = MergeTree
PRIMARY KEY (TIMESTAMP);

INSERT INTO test.pypi5
    SELECT *
    FROM test.pypi;

SELECT
    table,
    formatReadableSize(sum(data_compressed_bytes)) AS compressed_size,
    formatReadableSize(sum(data_uncompressed_bytes)) AS uncompressed_size,
    count() AS num_of_active_parts
FROM system.parts
WHERE (active = 1) AND (table LIKE 'pypi%')
GROUP BY table;

SELECT
    toStartOfMonth(TIMESTAMP) AS month,
    count() AS count
FROM pypi2
WHERE COUNTRY_CODE = 'US'
GROUP BY
    month
ORDER BY
    month ASC,
    count DESC;