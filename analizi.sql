--- kolku imame null
select count(stationname) from all_in_one; -- 4 686 226
select count(stationname) from all_in_one where data is null; -- 1 412 578 od 4 686 226
select count(stationname) from all_in_one where temperature is null; -- 2 574 649 i humidity i windspeed isto
select count(stationname) from all_in_one where percipitation is null; -- 3 948 964

select count(stationname) from all_in_one 
where data is not null
and type = 'PM10';

select count(stationname) from all_in_one -- 1 168 439 celosni
where data is not null
and temperature is not null
and windspeed is not null
and humidity is not null;

select stationname, type, avg(data), max(data), min(data), count(type) as count -- prosek po stanica
from all_in_one
group by stationname, type;

select (extract (month from datetime)), type, avg(data), count(data) -- prosek po mesec
from all_in_one
group by (extract (month from datetime)), type;

select (extract (hour from datetime)), type, avg(data), count(data) -- prosek po mesec
from all_in_one
group by (extract (hour from datetime)), type;

select type, avg(data) -- prosek po tip
from all_in_one
group by type;

-- merna stanica so2 outlier
select stationname, type, avg(data) as avg, count(data) as cnt
from table_copy
where type = 'SO2' and data is not null
group by stationname, type

select count(stationname) from table_copy
where data is not null
and type = 'SO2';

-- histogram spored type
select avg(data), count(data) as cnt
from table_copy
where type = 'PM25'
group by stationname 

select round(temperature), type, avg(data)
from table_copy
group by round(temperature), type
-- normalizacija -- min max norm -- standard normalization

select * from table_copy where stationname = 'Karpos' and data is not null and temperature is not null and humidity is not null and windspeed is not null limit 10

select round(temperature), avg(windspeed) -- zavisnost od 
from table_copy
group by round(temperature)
-- 1300 -- 800 pm outliers
select round(temperature), avg(data) 
    from table_copy 
    where  type='PM25' 
    group by round(temperature) 
    having count(data)>100;

-- data where < 0 to null vo nova
CREATE TABLE table_copy AS SELECT * FROM all_in_one;
UPDATE table_copy SET data = null WHERE data < 0;
-- veter sporedba od zavisnost
select round(temperature), avg(windspeed) -- zavisnost od temp
from table_copy
group by round(temperature)
select round(data::integer, -2), avg(windspeed) -- relacija so pm25 
from table_copy where type = 'PM25'
group by round(data::integer, -2)
select round(data::integer), avg(windspeed) -- relacija so pm10 -- ???
from table_copy where type = 'PM10'
group by round(data::integer)
-- o3 prosek po stanica
select stationname, avg(data)
from table_copy
where type = 'O3' 
group by stationname;
-- use windspeed -- spored round windspeed sporedba
select round(windspeed), avg(temperature) -- wind so temp
from table_copy
group by round(windspeed)
-- korelacija temp so wind i type
select type, round(temperature) as temp, avg(data) as izmeren_prosek, avg(windspeed) as wind, count(data) as data_primeroci
from table_copy
group by type, round(temperature)
-- spored saat, vreme
select (extract (hour from datetime)) as cas, type, round(avg(data)::numeric, 2), count(data)
from all_in_one
group by (extract (hour from datetime)), type;
-- merna stanica so2 outlier
select stationname, type, avg(data) as avg, count(data) as cnt
from table_copy
where type = 'SO2' and data is not null
group by stationname, type

select type, avg(data)
from all_in_one
where stationname = 'Kicevo'
group by type;

select count (stationname) from all_in_one 
where data < 0 -- 394 negativni vrednosti

select count(stationname)
from all_in_one
where data is not null

select * from all_in_one;

-- proekcija
select datetime, type, avg(data), count(data)
from all_in_one
where data<1000
group by datetime, type;

-- zema maksimalna vrednost
select type, max(data)
from all_in_one
group by type;

select type, count(data)
from all_in_one
group by type;

-- data where < 0 to null vo nova
CREATE TABLE table_copy AS SELECT * FROM all_in_one;
UPDATE table_copy SET data = null WHERE data < 0;

-- veter sporedba zavisnost
select round(temperature), avg(windspeed) -- zavisnost od temp zagaduvanje so wind
from table_copy
group by round(temperature)

select round(data::integer, -2), avg(windspeed) -- relacija so pm25 wind x
from table_copy where type = 'PM25'
group by round(data::integer, -2)

select round(data::integer, -2), avg(windspeed) -- relacija so pm10 -- ???
from table_copy where type = 'PM10'
group by round(data::integer, -2)

-- o3 prosek po stanica
select stationname, avg(data)
from table_copy
where type = 'O3' 
group by stationname;

-- use windspeed -- spored round windspeed sporedba
select round(windspeed), avg(temperature) -- wind so temp
from table_copy
group by round(windspeed)

-- korelacija temp so wind i type
select type, round(temperature) as temp, avg(data) as izmeren_prosek, avg(windspeed) as wind, count(data) as data_primeroci
from table_copy
group by type, round(temperature) --- round po temp i r wind

select round(windspeed::numeric, 1), round(temperature::numeric, -1), avg(data) --nepregledno
from table_copy where type='PM25'
group by  round(windspeed::numeric, 1), round(temperature::numeric, -1)

select round(windspeed::numeric, 1), avg(data) -- count(data) -- zagadenost so wind
from table_copy where type='PM25'
group by  round(windspeed::numeric, 1)

select round(temperature::numeric), avg(data) -- count(data) -- zagadenost so temp
from table_copy where type='PM25'
group by round(temperature::numeric)

-- cel zagaduvanje - predviduvanje
-- spored saat, vreme
select (extract (hour from datetime)) as cas, type, round(avg(data)::numeric, 2), count(data)
from all_in_one
group by (extract (hour from datetime)), type;

-- merna stanica so2 outlier --  analiza na so2 bez oulirer
select stationname, type, avg(data) as avg, count(data) as cnt
from table_copy
where type = 'SO2' and data is not null
group by stationname, type
-- bi se isfrlile 
update table_copy set data = null where type = 'SO2' and stationname = 'Centar';
update table_copy set data = null where type = 'SO2' and stationname = 'Karpos';
update table_copy set data = null where type = 'SO2' and stationname = 'Rektorat';
update table_copy set data = null where type = 'SO2' and stationname = 'Veles1';

-----------
-------
-- novo
-- korelacija temp so wind i type
select type, round(temperature) as temp, avg(data) as izmeren_prosek, avg(windspeed) as wind, count(data) as data_primeroci
from table_copy
group by type, round(temperature) --- round po temp i r wind

select round(windspeed::numeric, 1), round(temperature::numeric, -1), avg(data) --nepregledno
from table_copy where type='PM25'
group by  round(windspeed::numeric, 1), round(temperature::numeric, -1)

select round(windspeed::numeric, 1), avg(data), count(data) -- count(data) -- zagadenost so wind
from table_copy where type='PM25' -- popravi so having count > 500
group by  round(windspeed::numeric, 1) 

select round(temperature::numeric), avg(data) -- count(data) -- zagadenost so temp
from table_copy where type='PM25'
group by round(temperature::numeric)

-- isfrleni outlieri SO2 stanicite sto ne rabotat
update table_copy set data = null where type = 'SO2' and stationname = 'Centar';
update table_copy set data = null where type = 'SO2' and stationname = 'Karpos';
update table_copy set data = null where type = 'SO2' and stationname = 'Rektorat';
update table_copy set data = null where type = 'SO2' and stationname = 'Veles1';

-- nova normalizirana tabela
-- norm = (data - avg) / (max - min)
create table normalized_table as select * from table_copy;
-- AQI
update normalized_table set data = null where type = 'AQI' and data>500;
select max(data) from normalized_table where type = 'AQI'
select min(data) from normalized_table where type = 'AQI'
select avg(data) from normalized_table where type = 'AQI'
update normalized_table set data = (data - 29.01)/497 where type = 'AQI';
-- CO - nema outliers da receme - smeneto
select max(data) from normalized_table where type = 'CO'
select min(data) from normalized_table where type = 'CO'
select avg(data) from normalized_table where type = 'CO'
update normalized_table set data = (data - 1.18)/540 where type = 'CO';
-- CO2 - ok data - updejtnato
select max(data) from normalized_table where type = 'CO2'
select min(data) from normalized_table where type = 'CO2'
select avg(data) from normalized_table where type = 'CO2'
update normalized_table set data = (data - 2900)/7066 where type = 'CO2';
-- NO2 - ok - smeneto
select max(data) from normalized_table where type = 'NO2'
select min(data) from normalized_table where type = 'NO2'
select avg(data) from normalized_table where type = 'NO2'
update normalized_table set data = (data - 19.43)/706 where type = 'NO2';
-- O3 - ok smeneto
select max(data) from normalized_table where type = 'O3'
select min(data) from normalized_table where type = 'O3'
select avg(data) from normalized_table where type = 'O3'
update normalized_table set data = (data - 44.82)/2081 where type = 'O3';
-- PM10 - trgnati outliers > 1300 - smeneto
update normalized_table set data = null where type = 'PM10' and data > 1300
select max(data) from normalized_table where type = 'PM10'
select min(data) from normalized_table where type = 'PM10'
select avg(data) from normalized_table where type = 'PM10'
update normalized_table set data = (data - 44.47)/1297 where type = 'PM10';
-- PM25 - trgnato outliers > 800 - smeneto
update normalized_table set data = null where type = 'PM25' and data > 800
select max(data) from normalized_table where type = 'PM25'
select min(data) from normalized_table where type = 'PM25'
select avg(data) from normalized_table where type = 'PM25'
update normalized_table set data = (data - 24.7)/757 where type = 'PM25';
--update normalized_table set data = data *757 + 24.7 where type = 'PM25';
-- SO2 - smeneto
update normalized_table set data = null where type = 'SO2' and stationname = 'Centar';
update normalized_table set data = null where type = 'SO2' and stationname = 'Karpos';
update normalized_table set data = null where type = 'SO2' and stationname = 'Rektorat';
update normalized_table set data = null where type = 'SO2' and stationname = 'Veles1';
select max(data) from normalized_table where type = 'SO2'
select min(data) from normalized_table where type = 'SO2'
select avg(data) from normalized_table where type = 'SO2'
update normalized_table set data = (data - 3.08)/6783 where type = 'SO2';
-- temp - smeneto
select max(temperature) from normalized_table
select min(temperature) from normalized_table
select avg(temperature) from normalized_table
--update normalized_table set temperature = (temperature - 12.59)/71.37;
update normalized_table set temperature = temperature *71.37 + 12.59;
-- humidity - smeneto
select max(humidity) from normalized_table
select min(humidity) from normalized_table
select avg(humidity) from normalized_table
update normalized_table set humidity = (humidity - 0.68);
-- windspeed - smeneto
select max(windspeed) from normalized_table
select min(windspeed) from normalized_table
select avg(windspeed) from normalized_table
update normalized_table set windspeed = (windspeed - 1.74)/11;

select round(data), avg(temperature), avg(humidity), avg(windspeed)
from table_copy tc where type = 'PM25'
group by round(data)

select extract(month from datetime), avg(data) as pm25, avg(temperature) as temp, avg(humidity) as humidity, avg(windspeed) as wind 
from table_copy where type = 'PM25' 
group by extract(month from datetime)

select datetime, avg(data) from table_copy where type='PM25' group by datetime 

select round(data) as pm25, avg(temperature) as temp_ from table_copy where type='PM25' group by round(data) 
select round(data) as pm25, avg(windspeed) as wind from table_copy where type='PM25' group by round(data) 
select extract(month from datetime) as month, avg(data) as pm25 from table_copy where type='PM25' group by extract(month from datetime)

select round(data) as pm25, avg(humidity) as humidity
from table_copy tc where type = 'PM25'
group by round(data)

select extract(month from datetime) as mesec, (select datetime, data from table_copy where type='PM25') as pm25, 
avg(windspeed) as wind, avg(temperature) as temp from table_copy tc -- nemoze vaka
group by extract(month from datetime)

--novo
select * from table_copy where type = 'PM25' and data=999 -- pm25 greshni 999ki
select * from table_copy where type = 'PM25' and stationname = 'Gjorce' 
and datetime::date ='2018-11-04'
select * from table_copy where type = 'PM25' and stationname = 'Karpos' 
and datetime::date ='2018-11-04'
select * from table_copy where type = 'PM25' and stationname = 'Gjorce' 
and datetime::date ='2018-11-05'

select * from table_copy where type = 'PM10' and data =1999
select * from table_copy where type = 'PM10' and stationname ='Gjorce'
and datetime::date ='2018-11-04'
select * from table_copy where type = 'PM10' and stationname ='Gjorce'
and datetime::date ='2018-11-05'

select * from table_copy where type = 'PM10'  and stationname ='Gjorce' -- se rasipuva gjorce na 5ti vo 10h
and extract(year from datetime) = '2018' and extract(month from datetime) = '11' and extract(day from datetime) < '20'
select * from table_copy where type = 'PM10'  and stationname ='Gjorce'
and extract(year from datetime) = '2018' and extract(month from datetime) = '12'
select * from table_copy where type = 'PM10'  and stationname ='Gjorce' -- ja popravaat 31vi dek
and extract(year from datetime) = '2018' and extract(month from datetime) = '12' and extract(day from datetime) > '28'

select * from table_copy where type = 'AQI'  and stationname ='Gjorce' -- isto i AQI a dr type ne meri
and extract(year from datetime) = '2018' and extract(month from datetime) = '12' and extract(day from datetime) > '28'

select round(windspeed::numeric, 1), avg(data), count(data) -- count(data) -- zagadenost so wind
from table_copy where type='PM25'
group by  round(windspeed::numeric, 1) 

select stationname, windspeed, avg(data), count(data) --  povekjeto zaokruzivaat
from table_copy where type='PM25' and windspeed = 1 or windspeed = 2 or windspeed = 3 or windspeed = 4 or windspeed = 5 or
windspeed = 6 or windspeed = 7 or windspeed = 8
group by windspeed, stationname

select stationname, windspeed, count(stationname) -- 
from table_copy where windspeed is not null and stationname = 'Centar'
group by windspeed, stationname

select count(windspeed) from table_copy where windspeed is not null and stationname = 'Centar'

