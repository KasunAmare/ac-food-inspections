import pandas as pd
import numpy as np


violations = pd.read_csv('../data/alco-restaurant-violations.csv')

inspections = pd.read_csv('../data/alco-all-inspections.csv')

restaurants = pd.read_csv('../data/alco-all-restaurants.csv')


print(violations.head())
print(violations.shape)

print(inspections.head())
print(inspections.shape)

print(restaurants.head())
print(restaurants.shape)
