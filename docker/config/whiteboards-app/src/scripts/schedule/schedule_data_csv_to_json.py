import os
os.chdir('../../../database/schedule')
# writing to file
with open('ScheduleData.csv', 'r') as file:
    csvdata = file.readlines()

with open("ScheduleData.json", "w+") as file:
    file.write('{\n')
    headings = []
    first = True
    for line in csvdata:
        line = line.strip()
        if line.startswith(','):
            data = line.split(",")
            data = list(filter(None, data))
            file.write(f'"{data.pop(0)}" : {{\n')

            for heading, data in zip(headings, data):
                if heading == "Name":
                    file.write(f'"{heading}" : "{data}",\n')
                else:
                    file.write(f'"{heading}" : {data.lower()},\n')
            file.write('},\n')

        else:
            if not first:
                file.write('},\n')
            headings = line.split(",")
            file.write(f'"{headings.pop(0)}":{{\n')
            headings.pop(0)
            first = False
    file.write('\n}}')
