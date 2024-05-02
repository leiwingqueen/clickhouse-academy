select * from s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet') limit 100

select avg(volume) from s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet') limit 100

select formatReadableQuantity(count()) from s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet')

select count(),crypto_name from s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet') group by crypto_name order by crypto_name limit 100

select count(),trim(crypto_name) from s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet') group by trim(crypto_name) order by trim(crypto_name) limit 100