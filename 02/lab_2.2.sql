# lab_2.2.sql

SELECT
    formatReadableSize(sum(data_compressed_bytes)) AS compressed_size,
    formatReadableSize(sum(data_uncompressed_bytes)) AS uncompressed_size,
    count() AS num_of_active_parts
FROM system.parts
WHERE (active = 1) AND (table = 'pypi');

CREATE OR REPLACE TABLE test.pypi4 (
    TIMESTAMP DateTime,
    COUNTRY_CODE String,
    URL String,
    PROJECT String 
)
ENGINE = MergeTree
PRIMARY KEY (PROJECT,COUNTRY_CODE,TIMESTAMP);


INSERT INTO test.pypi4
    SELECT *
    FROM test.pypi;

# check data compressed size
 SELECT
    table,
    formatReadableSize(sum(data_compressed_bytes)) AS compressed_size,
    formatReadableSize(sum(data_uncompressed_bytes)) AS uncompressed_size,
    count() AS num_of_active_parts
FROM system.parts
WHERE (active = 1) AND (table LIKE '%pypi%')
GROUP BY table;