# lab 8.1

select * from clusterAllReplicas('default', system.query_log) 
where has(tables,'test.uk_price_paid') order by event_time limit 10

select * from clusterAllReplicas('default', system.query_log) 
where positionCaseInsensitive(query,'insert') >0 order by event_time limit 10


SELECT count()
FROM system.parts;
316

SELECT count()
FROM clusterAllReplicas(default, system.parts);
636