# lab_5.1.sql

 select * from uk_price_paid where price>=100_000_000 order by price desc

 select count() from uk_price_paid where price>=1_000_000 and date>='2022-01-01' and date<='2022-12-31'

 select uniqExact(town) from uk_price_paid

 select town,count() as c from uk_price_paid group by town order by c desc limit 1

 select topKIf(10)(town,town!='LONDON') from uk_price_paid

 # What are the top 10 most expensive towns to buy property in the UK, on average?
select town,avg(price) as avg_price from uk_price_paid group by town order by avg_price desc limit 10

select addr1,addr2,street,town,price from uk_price_paid order by price desc limit 1

select type,avg(price) as avg_price from uk_price_paid group by type limit 10

select county,sum(price) from uk_price_paid where lowerUTF8(county) in ['avon','essex', 'devon', 'kent', 'cornwall'] and date>=toDate('2020-01-01') and date<=toDate('2020-12-31') group by county limit 10

select date,avg(price) as avg_price from uk_price_paid where date>=toDate('2005-01-01') and date<=toDate('2010-12-31') group by date order by avg_price desc

# How many properties were sold in Liverpool each day in 2020?
select date,count() from uk_price_paid where town='LIVERPOOL' and date>=toDate('2020-01-01') and date<=toDate('2020-12-31') group by date order by date

with(
	select max(price) from uk_price_paid
)as mx_price
select max(price)/mx_price as p,town from uk_price_paid group by town order by p desc
