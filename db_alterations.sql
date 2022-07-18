-- change dataypes to match every table
alter table copy_2015  alter column datetime set data type timestamp using to_timestamp(datetime, 'DD-MM-YYYY HH24:MI');
alter table copy_2015 alter column temperature set data type float8 using temperature::double precision; 
alter table copy_2015 alter column humidity set data type float8 using humidity::double precision;
alter table copy_2015 alter column windspeed set data type float8 using windspeed::double precision;
alter table copy_2015 alter column data set data type float8 using data::double precision;
-- change datatypes and update 'NULL' to NULL
alter table copy_2016 alter column datetime set data type timestamp using to_timestamp(datetime, 'DD-MM-YYYY HH24:MI');
update copy_2016 set temperature=null where temperature='NULL';
alter table copy_2016 alter column temperature set data type float8 using temperature::double precision;
update copy_2016 set humidity=null where humidity='NULL';
alter table copy_2016 alter column humidity set data type float8 using humidity::double precision;
update copy_2016 set windspeed=null where windspeed='NULL';
update copy_2016 set percipitation =null where percipitation ='NULL';
alter table copy_2016 alter column windspeed set data type float8 using windspeed::double precision;
-- change datatypes and update 'NULL' to NULL
update copy_2017 set percipitation =null where percipitation ='NULL';
alter table copy_2017 alter column datetime set data type timestamp using to_timestamp(datetime, 'DD-MM-YYYY HH24:MI');
alter table copy_2017 alter column data set data type float8 using data::double precision;
alter table copy_2017 alter column temperature set data type float8 using temperature::double precision;
alter table copy_2017 alter column humidity set data type float8 using humidity::double precision;
alter table copy_2017 alter column windspeed set data type float8 using windspeed::double precision;
-- change datatypes to match
alter table copy_2018 alter column datetime set data type timestamp using to_timestamp(datetime, 'YYYY-MM-DD HH24:MI');
alter table copy_2018 alter column data set data type float8 using data::double precision;
alter table copy_2018 alter column temperature set data type float8 using temperature::double precision;
alter table copy_2018 alter column humidity set data type float8 using humidity::double precision;
alter table copy_2018 alter column windspeed set data type float8 using windspeed::double precision;
-- change datatype and add the missing columns NULLs
alter table copy_2019 alter column datetime set data type timestamp using to_timestamp(datetime, 'YYYY-MM-DD HH24:MI');
alter table copy_2019 alter column data set data type float8 using data::double precision;
alter table copy_2019 add column temperature float8;
alter table copy_2019 add column humidity float8;
alter table copy_2019 add column windspeed float8;
alter table copy_2019 add column percipitation text;
-- reorder columns 2019
create table copy_2019_copy (stationname text, datetime timestamp, data float8, type text, temperature float8,
humidity float8, windspeed float8, percipitation text);
insert into copy_2019_copy (stationname, datetime, data, type, temperature, humidity, windspeed, percipitation) select
stationname, datetime, data, type, temperature, humidity, windspeed, percipitation from copy_2019;
-- rename 2019
drop table copy_2019;
alter table copy_2019_copy rename to copy_2019;
-- create new one to consisting of all
CREATE TABLE all_in_one AS SELECT * FROM copy_2015 UNION ALL SELECT * FROM copy_2016 UNION all 
SELECT * FROM copy_2017 UNION all SELECT * FROM copy_2018 UNION all SELECT * FROM copy_2019; 
-- drop the rest
drop table copy_2015;
drop table copy_2016;
drop table copy_2017;
drop table copy_2018;
drop table copy_2019;
