import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.preprocessing 
import LabelEncoder, OneHotEncoder
from sklearn.model_selection 
import train_test_split

data = pd.read_csv('avocado.csv')
X = data.iloc[:, :-1].values
y = data.iloc[:, 2].values

labelencoder = LabelEncoder()
X[:, 7] = labelencoder.fit_transform(X[:, 7])
onehotencoder = OneHotEncoder(categorical_features = [7])
X = onehotencoder.fit_transform(X).toarray()
X = X[:, 1:]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)