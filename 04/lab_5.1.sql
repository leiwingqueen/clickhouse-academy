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

