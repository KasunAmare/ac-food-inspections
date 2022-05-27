create schema if not exists clean;

drop table if exists clean.inspection_violations;

create table clean.inspection_violations (
    encounter bigint,
    id bigint, 
    placard_st smallint,
    facility_name text,
    bus_st_date date,
    "description" text,
    "description_new" text,
    num varchar,
    street text,
    city text,
    state text,
    zip text,
    inspect_dt date,
    start_time time,
    end_time time,
    municipal text, 
    rating varchar,
    low varchar, 
    medium varchar,
    high varchar,
    "url" text
);


insert into clean.inspection_violations 
select 
	encounter::bigint,
    id::bigint, 
    placard_st::smallint,
    facility_name::text,
    bus_st_date::date,
    "description"::text,
    "description_new"::text,
    num::varchar,
    street::text,
    city::text,
    state::text,
    zip::text,
    inspect_dt::date,
    start_time::time,
    end_time::time,
    municipal::text, 
    rating::varchar,
    low::varchar, 
    medium::varchar,
    high::varchar,
    "url"::text
from raw.inspection_violations;

create index on clean.inspection_violations(id);
create index on clean.inspection_violations(inspect_dt);
create index on clean.inspection_violations(encounter);


-- all insepections
drop table if exists clean.all_inspections;

create table clean.all_inspections (
    encounter bigint,
    id bigint, 
    placard_st smallint,
    placard_desc varchar,
    facility_name varchar,
    bus_st_date date,
    category_cd smallint,
    description text,
    num varchar,
    street varchar,
    city varchar,
    state varchar,
    zip varchar,
    inspect_dt date,
    start_time time, 
    end_time time,
    municipal varchar,
    ispt_purpose smallint,
    abrv varchar,
    purpose varchar,
    reispt_cd smallint,
    reispt_dt date,
    status smallint  
);

insert into clean.all_inspections 
select 
	encounter::bigint,
    id::bigint, 
    placard_st::smallint,
    placard_desc::varchar,
    facility_name::varchar,
    bus_st_date::date,
    category_cd::smallint,
    description::text,
    num::varchar,
    street::varchar,
    city::varchar,
    state::varchar,
    zip::varchar,
    inspect_dt::date,
    start_time::time, 
    end_time::time,
    municipal::varchar,
    ispt_purpose::smallint,
    abrv::varchar,
    purpose::varchar,
    reispt_cd::smallint,
    reispt_dt::date,
    status::smallint
from raw.all_inspections;

create index on clean.all_inspections(encounter);

create index on clean.all_inspections(id);


-- All facilties
drop table if exists clean.food_facilities;

create table clean.food_facilities (
    id bigint,
    facility_name text,
    num varchar,
    street varchar,
    city varchar,
    state varchar,
    zip varchar,
    municipal varchar,
    category_cd smallint,
    description text,
    p_code smallint,
    fdo date,
    bus_st_date date,
    bus_cl_date date,
    seat_count smallint, 
    noroom smallint,
    sq_feet int,
    status smallint,
    placard_st smallint,
    x float,
    y float,
    address text
);

insert into clean.food_facilities 
select 
	id::bigint,
    facility_name::text,
    num::varchar,
    street::varchar,
    city::varchar,
    state::varchar,
    zip::varchar,
    municipal::varchar,
    category_cd::smallint,
    description::text,
    p_code::smallint,
    fdo::date,
    bus_st_date::date,
    bus_cl_date::date,
    seat_count::smallint, 
    noroom::smallint,
    sq_feet::int,
    status::smallint,
    placard_st::smallint,
    x::float,
    y::float,
    address::text
from raw.food_facilities ff;

create index on clean.food_facilities(id);
