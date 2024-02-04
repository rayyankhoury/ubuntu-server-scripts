#!/bin/bash

# find ../../assets/exercisedata/* -type f  -print
# do
#     …code using "$file"
# done

find ../../assets/exercisedata/* -type f -not -name "*.json"|while read fname; do
# directoryname= $(echo "$(dirname ${fname})")
# echo $directoryname
# detils = $(echo "$(dirname ${fname})/details.json")
# detils = echo "$(dirname ${fname})/details.json"
# jsonfilename = $(echo "$(dirname ${fname})/details.json")
   filename=$(basename -- "$fname")
   name=$(echo "$filename" | cut -f 1 -d '.')
  echo "$filename" >> "unique.txt"
#   parentdir="$(dirname "$fname")"
#     superparentdir="$(dirname "$parentdir")"
#     superparentdir=$(basename -- "$superparentdir")

#   echo "$filename"
#   echo "$parentdir"
#   echo "${parentdir}/${superparentdir}${filename}"
#   echo "$fname"
#   mv $fname ${parentdir}/${superparentdir}${filename}
done