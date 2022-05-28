#!/bin/sh

# Fetching data from https://data.wprdc.org/dataset/allegheny-county-restaurant-food-facility-inspection-violations


echo "Downloadning AC food inspections data"


# all violations
wget https://data.wprdc.org/dataset/8744b4f6-5525-49be-9054-401a2c4c2fac/resource/1a1329e2-418c-4bd3-af2c-cc334e7559af/download/alco-restuarant-violations.csv

# all inspections
wget https://data.wprdc.org/datastore/dump/410f80a1-d18c-44f3-9964-2205b2ea7f5a
mv 410f80a1-d18c-44f3-9964-2205b2ea7f5a alco-all-inspections.csv

# List of restaurants
wget https://data.wprdc.org/datastore/dump/112a3821-334d-4f3f-ab40-4de1220b1a0a
mv 112a3821-334d-4f3f-ab40-4de1220b1a0a alco-all-restaurants.csv


# The files seem to be created on windows, so we need to change the end of line characters

echo "Basic cleaning on downloaded files"

sed -i 's/\r//' alco-restuarant-violations.csv
sed -i 's/\r//' alco-all-inspections.csv
sed -i 's/\r//' alco-all-restaurants.csv 


echo "Done!"
