import os
import sys
import json

# This file takes in a folder location with multiple or singular details.json files and media files

_FOLDER = "exrx"

datalocation = "/app/database/exercises/"
relativelocation = "../../../database/exercises/"


def chop_self_off_parent(location, folder_name):
    # reusable
    split = location.split('/')
    res = [index for index, i in enumerate(split) if folder_name in i][0]
    rootdir = ('/').join(split[:res])
    return rootdir


def chop_parent_dirs(location, folder_name):
    # reusable
    split = location.split('/')
    res = [index for index, i in enumerate(split) if folder_name in i][0]
    rootdir = ('/').join(split[res:])
    return rootdir


def format_string(jsonid, jsondetailslocation, exerciseid, mediafilelocation):

    choppedjsondetailslocation = chop_parent_dirs(
        jsondetailslocation, _FOLDER)
    choppedmediafilelocation = chop_parent_dirs(
        mediafilelocation, _FOLDER)
    json = f"{relativelocation}{choppedjsondetailslocation}"
    media = f"{relativelocation}{choppedmediafilelocation}"

    return(f'''
    {jsonid}:
    {{
        id: "{exerciseid}",
        details: require("{json}"),
        media: require("{media}"),
    }},
    ''')


def find_filename_with_substring(filenames, substring):
    for filename in filenames:
        split = filename.split('.')
        if substring == split[0]:
            return filename
    raise ValueError(f"Cannot find substring {substring} in list of files")


def import_details_json(details_file_location):
    with open(details_file_location, "r") as f:
        try:
            temp = json.loads(f.read())
            return temp
        except json.decoder.JSONDecodeError as err:
            print(f"JSONDecodeError at: {details_file_location}")
        except ValueError as err:
            print(err)


def walk_to_details_json():
    towrite = ""
    app_dir = chop_self_off_parent(os.getcwd(), "app")
    data_dir = app_dir + datalocation + _FOLDER
    for root, dirs, files in os.walk(data_dir):
        for name in files:
            if name == "details.json":
                path = os.path.join(root, name)
                json = import_details_json(path)
                jsonkeys = [key for key in json]
                exerciseids = [json[key]["exerciseid"] for key in jsonkeys]

                for jsonkey, exerciseid in zip(jsonkeys, exerciseids):
                    mediafilename = find_filename_with_substring(
                        files, exerciseid)
                    medialocation = os.path.join(root, mediafilename)
                    towrite += format_string(jsonkey, path,
                                             exerciseid, medialocation)

    return towrite


to_write = 'var metadata = {'

walk_to_details_json()

with open("exercise_metadata.js", "w+") as file:
    file.write(to_write)
    file.write(walk_to_details_json())
    file.write('}')
