# lab_6.1.sql

```
Define a view on the uk_price_paid table that satisfies the following requirements:

a. The name of the view is london_properties_view 

b. The view only returns properties in the town of London

c. The view only returns the date, price, addr1, addr2 and street columns
```

create view london_properties_view as select date,price,addr1,addr2,street from uk_price_paid where town='LONDON'

select avg(price) from london_properties_view where date>='2022-01-01' and date<='2022-12-31'

select count() from london_properties_view
2188031

CREATE VIEW properties_by_town_view AS SELECT date,price,addr1,addr2,street FROM uk_price_paid WHERE town = {town_filter:String}

select max(price),argMax(street,price) from properties_by_town_view(town_filter='LIVERPOOL')



