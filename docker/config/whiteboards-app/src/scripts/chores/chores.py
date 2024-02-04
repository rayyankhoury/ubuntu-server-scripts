import os

exec(open("xlsx_to_csv.py").read())
os.chdir('../../code/scripts/chores')

exec(open("day_specific_csv_to_json.py").read())
os.chdir('../../code/scripts/chores')

exec(open("recurring_csv_to_json.py").read())
os.chdir('../../code/scripts/chores')
