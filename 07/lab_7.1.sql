# lab_7.1.sql

CREATE TABLE prices_sum_dest
(
    town LowCardinality(String),
    sum_price UInt64
)
ENGINE = SummingMergeTree(sum_price)
ORDER BY town

CREATE MATERIALIZED VIEW prices_sum_view
TO prices_sum_dest
AS
    SELECT
        town,
        sum(price) AS sum_price
    FROM uk_price_paid
    GROUP BY town;

INSERT INTO prices_sum_dest
    SELECT
        town,
        sum(price) AS sum_price
    FROM uk_price_paid
    GROUP BY town;

 select count() from prices_sum_dest
 1172

 # 有点奇怪的特性，甚至有点像bug的味道。it tastes like a bug

 SELECT
    town,
    sum(sum_price) AS sum,
    formatReadableQuantity(sum)
FROM prices_sum_dest
WHERE town = 'LONDON' group by town


 SELECT
    town,
    sum_price AS sum,
    formatReadableQuantity(sum)
FROM prices_sum_dest
WHERE town = 'LONDON'

 SELECT
    town,
    sum(sum_price) AS sum,
    formatReadableQuantity(sum)
FROM prices_sum_dest group by town order by sum desc limit 10

