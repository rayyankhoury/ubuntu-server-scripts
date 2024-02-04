import pandas as pd
import sys
import os

os.chdir('../../../database/chores')

files = os.listdir(os.getcwd())
for fi in files:
    print(fi)
    if len(fi.split('.')) == 1:
        print(fi)
        continue
    if fi.split('.')[1] == 'xlsx':
        read_file = pd.read_excel(fi)
        read_file.to_csv(f"{fi.split('.')[0]}.csv",
                         index=None, header=False)
