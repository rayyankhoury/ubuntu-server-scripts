import os
os.chdir('../../../database/chores')
# writing to file
with open('RecurringChores.csv', 'r') as file:
    csvdata = file.readlines()

with open("RecurringChores.json", "w+") as file:
    file.write('{\n')
    headings = []
    for line in csvdata:
        line = line.strip()
        # Header line: contains days
        if line.startswith(','):
            headings = line.split(",")
            headings = list(filter(None, headings))

        # Converts location of x to heading basd on index location
        else:
            data = line.split(",")
            file.write(f'"{data.pop(0)}":\n')

            for i, x in enumerate(data):
                if x == "X":
                    file.write(f'"{headings[i]}",\n')

    file.write('\n}')
