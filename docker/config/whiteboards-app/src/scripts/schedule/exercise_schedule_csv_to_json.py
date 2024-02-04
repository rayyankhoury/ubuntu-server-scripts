import os
os.chdir('../../../database/schedule')
# writing to file
with open('ExerciseSchedule.csv', 'r') as file:
    csvdata = file.readlines()

with open("ExerciseSchedule.json", "w+") as file:
    file.write('{\n')
    first = True
    second = False
    weeks = []
    schedules = []

    for line in csvdata:
        line = line.strip()
        if not first and not second:
            data = line.split(",")
            file.write(f'"{data.pop(0)}" : {{\n')
            start = True
            for week, schedule, data in zip(weeks, schedules, data):
                if (week):
                    if not start:
                        file.write('},\n')
                        file.write(f'"{week}" : {{\n')
                    if (start):
                        file.write(f'"{week}" : {{\n')
                        start = False
                file.write(f'"{schedule}" : "{data}",\n')
            file.write('},\n')
            file.write('},\n')

        elif first:
            weeks = line.split(",")
            weeks.pop(0)
            first = False
            second = True
        elif second:
            schedules = line.split(",")
            schedules.pop(0)
            second = False
    file.write('\n}')
