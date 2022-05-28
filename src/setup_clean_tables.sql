drop schema if exists clean cascade;

create schema if not exists clean;

--- Violations

drop table if exists clean.inspection_violations;

create table clean.inspection_violations as 
select
    encounter::bigint,
    id::bigint, 
    placard_st::smallint,
    facility_name::text,
    bus_st_date::date,
    "description"::text,
    "description_new"::text,
    num::text,
    street::text,
    city::text,
    state::text,
    zip::text,
    inspect_dt::date,
    start_time::time,
    end_time::time,
    municipal::text, 
    rating::text,
    low::text, 
    medium::text,
    high::text,
    "url"::text
from raw.violations;

create index on clean.violations(id);
create index on clean.violations(inspect_dt);
create index on clean.violations(encounter);

--- Inspections

drop table if exists clean.inspections;

create table clean.inspections as
select 
	encounter::bigint,
    id::bigint, 
    placard_st::smallint,
    placard_desc::text,
    facility_name::text,
    bus_st_date::date,
    category_cd::smallint,
    description::text,
    num::text,
    street::text,
    city::text,
    state::text,
    zip::text,
    inspect_dt::date,
    start_time::time, 
    end_time::time,
    municipal::text,
    ispt_purpose::smallint,
    abrv::text,
    purpose::text,
    reispt_cd::smallint,
    reispt_dt::date,
    status::smallint
from raw.inspections;

create index on clean.inspections(encounter);

create index on clean.inspections(id);

--- Food facilities

drop table if exists clean.food_facilities;

create table clean.food_facilities as
select 
    id::bigint,
    facility_name::text,
    num::text,
    street::text,
    city::text,
    state::text,
    zip::text,
    municipal::text,
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

raise info "Cleaning food inspections data: DONE!"
