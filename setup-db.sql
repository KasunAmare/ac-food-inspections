drop schema raw if exists cascade;

create schema if not exists raw;

--- Violations

drop table if exists raw.violations;

create table raw.violations (
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


--- Inspections
drop table if exists raw.inspections;

create table raw.inspections (
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


--- Food facilities
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


-- copying the data to the raw schema

raise info "Copying inspections"
\copy raw.inspections FROM '../data/alco-all-inspections.csv' CSV HEADER;

raise infor "Copying restaurants"
\copy raw.food_facilities FROM '../data/alco-all-restaurants.csv' CSV HEADER;

raise info "Copying violations"
\copy raw.violations FROM '../data/alco-restuarant-violations.csv' CSV HEADER;

raise info "Copying raw inspections data: DONE!"
