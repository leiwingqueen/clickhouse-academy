# lab_7.2.sql

CREATE TABLE uk_prices_aggs_dest
(
	month Date,
	min_price SimpleAggregateFunction(min,UInt32),
	max_price SimpleAggregateFunction(max,UInt32),
	avg_price AggregateFunction(avg,UInt32),
    total AggregateFunction(count,UInt32)
)
ENGINE = AggregatingMergeTree()
ORDER BY month

CREATE MATERIALIZED VIEW uk_prices_aggs_view
TO uk_prices_aggs_dest
AS
    WITH
    toStartOfMonth(date) AS month
SELECT 
    month,
    minSimpleState(price) as min_price,
    maxSimpleState(price) as max_price,
    avgState(price) as avg_price,
    countState() as total
FROM uk_price_paid
GROUP BY month 

INSERT INTO uk_prices_aggs_dest
	WITH
    toStartOfMonth(date) AS month
   SELECT 
    month,
    minSimpleState(price) as min_price,
    maxSimpleState(price) as max_price,
    avgState(price) as avg_price,
    countState() as total
FROM uk_price_paid where date < toDate('2024-01-01')
GROUP BY month 

# 测试查询
select month,min(min_price),max(max_price),avgMerge(avg_price),countMerge(total) from uk_prices_aggs_dest 
where month >= (toStartOfMonth(now()) - (INTERVAL 12 MONTH))
    AND month < toStartOfMonth(now())
group by month

select month,min(min_price),max(max_price) from uk_prices_aggs_dest 
where month >= (toStartOfMonth(now()) - (INTERVAL 12 MONTH))
    AND month < toStartOfMonth(now())
group by month order by month desc

select month,avgMerge(avg_price) from uk_prices_aggs_dest 
where month >= (toStartOfMonth(now()) - (INTERVAL 24 MONTH))
    AND month < toStartOfMonth(now())
group by month order by month desc




select sum(t) from (select month,countMerge(total) as t from uk_prices_aggs_dest where toYear(month)=2020 group by month)

SELECT
    countMerge(total)
FROM uk_prices_aggs_dest
WHERE toYear(month) = '2020';

886642





