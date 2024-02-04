import os

exec(open("xlsx_to_csv.py").read())
os.chdir('../../code/scripts/schedule')

exec(open("schedule_data_csv_to_json.py").read())
os.chdir('../../code/scripts/schedule')

exec(open("exercise_schedule_csv_to_json.py").read())
os.chdir('../../code/scripts/schedule')
