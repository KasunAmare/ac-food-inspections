#!/bin/sh


echo "Creating the raw schema on the database and copying data over..."

# create the Raw Schema
psql -f setup_raw_tables.sql

echo "Clean up the raw schema and copy data over to the clean schema..."

# create the Raw Schema
psql -f setup_clean_tables.sql

echo "Done!"

