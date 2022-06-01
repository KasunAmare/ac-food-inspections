\echo 'Allegheny county food inspections Layout'
\echo 'Kasun / Adolfo (adolfo@cmu.edu)'
\set VERBOSITY terse
\set ON_ERROR_STOP true


do language plpgsql $$ declare
    exc_message text;
    exc_context text;
    exc_detail text;
begin

raise notice 'Assuming role food-inspections-role';
set role "food-inspections-role";

raise notice 'Dropping schemas';
drop schema if exists raw cascade;
drop schema if exists clean cascade;


raise notice 'Creating schemas';
create schema if not exists raw;
create schema if not exists clean;

raise notice 'Populating inspections';
do $inspections$ begin

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

end $inspections$;


raise notice 'Populating restaurants';
do $restaurants$ begin

--- Food facilities

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


end $restaurants$;


raise notice 'Populating  violations';
do $violations$ begin
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


end $violations$;



exception when others then
    get stacked diagnostics exc_message = message_text;
    get stacked diagnostics exc_context = pg_exception_context;
    get stacked diagnostics exc_detail = pg_exception_detail;
    raise exception E'\n------\n%\n%\n------\n\nCONTEXT:\n%\n', exc_message, exc_detail, exc_context;
end $$;


-- Can't use \copy inside functions

\echo 'Copying data into raw tables'
\copy raw.food_facilities FROM './data/alco-all-restaurants.csv' CSV HEADER;
\copy raw.inspections FROM './data/alco-all-inspections.csv' CSV HEADER;
\copy raw.violations FROM './data/alco-restuarant-violations.csv' CSV HEADER;


do language plpgsql $$ declare
    exc_message text;
    exc_context text;
    exc_detail text;
begin

raise notice 'Assuming role food-inspections-role';
set role "food-inspections-role";

raise notice 'Cleaning data';

do $cleaning$ begin

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
        point(y::float,x::float) as location, -- x is latitude, y is longitude
        address::text
    from raw.food_facilities ff;


    create table clean.violations as
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

end $cleaning$;

raise notice 'Indexing data';

do $indexing$ begin

    create index on clean.violations(id);
    create index on clean.violations(inspect_dt);
    create index on clean.violations(encounter);


    create index on clean.inspections(encounter);
    create index on clean.inspections(id);

    create index on clean.food_facilities(id);

end $indexing$;



exception when others then
    get stacked diagnostics exc_message = message_text;
    get stacked diagnostics exc_context = pg_exception_context;
    get stacked diagnostics exc_detail = pg_exception_detail;
    raise exception E'\n------\n%\n%\n------\n\nCONTEXT:\n%\n', exc_message, exc_detail, exc_context;
end $$;
