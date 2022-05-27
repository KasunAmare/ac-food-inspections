create schema if not exists raw;

drop table if exists raw.inspection_violations;

create table raw.inspection_violations (
    encounter varchar,
    id varchar, 
    placard_st varchar,
    facility_name text,
    bus_st_date varchar,
    "description" text,
    "description_new" text,
    num varchar,
    street text,
    city varchar,
    state varchar,
    zip varchar,
    inspect_dt varchar,
    start_time varchar,
    end_time varchar,
    municipal varchar, 
    rating varchar,
    low varchar, 
    medium varchar,
    high varchar,
    "url" text
);


drop table if exists raw.all_inspections;

create table raw.all_inspections (
    encounter varchar,
    id varchar, 
    placard_st varchar,
    placard_desc varchar,
    facility_name varchar,
    bus_st_date varchar,
    category_cd varchar,
    description varchar,
    num varchar,
    street varchar,
    city varchar,
    state varchar,
    zip varchar,
    inspect_dt varchar,
    start_time varchar, 
    end_time varchar,
    municipal varchar,
    ispt_purpose varchar,
    abrv varchar,
    purpose varchar,
    reispt_cd varchar,
    reispt_dt varchar,
    status varchar  
);


drop table if exists raw.food_facilities;

create table raw.food_facilities (
    id varchar,
    facility_name text,
    num varchar,
    street text,
    city varchar,
    state varchar,
    zip varchar,
    municipal varchar,
    category_cd varchar,
    description varchar,
    p_code varchar,
    fdo varchar,
    bus_st_date varchar,
    bus_cl_date varchar,
    seat_count varchar, 
    noroom varchar,
    sq_feet varchar,
    status varchar,
    placard_st varchar,
    x varchar,
    y varchar,
    address text
);
