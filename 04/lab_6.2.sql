# lab_6.2.sql

select count(),avg(price) from uk_price_paid where date>='2020-01-01' and date<='2020-12-31' limit 10

select toYear(date),count(),avg(price) from uk_price_paid group by toYear(date)

