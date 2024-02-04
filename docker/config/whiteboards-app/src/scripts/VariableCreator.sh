#!/bin/bash

# for entry in *
# do
#   name=$(echo "$entry" | cut -f 1 -d '.')
#   views=$(echo "<View style={styles.${name}container}><Image style={styles.muscle} source={$name}></Image></View>")
#   echo $views >> "variables.txt"
# done


# for entry in *
# do
#   name=$(echo "$entry" | cut -f 1 -d '.')
#   echo "${name}container: {top: \"16.9%\",left: \"24.3%\",position: \"absolute\",width: \"13%\",height: undefined,resizeMode: \"contain\",flex: 1,}," >> "variables.txt"
# done



 for file in ./red/*.png
 do
   filename=$(basename -- "$file")
   convert "$file" -fuzz 50% -fill '#46f146' -opaque '#f14646' "green/${filename}"
 done


 for file in ./red/*.png
 do
    filename=$(basename -- "$file")
   convert "$file" -fuzz 80% -fill '#4646f1' -opaque '#f14646' "blue/${filename}"
 done

# for file in ./red/*.png
#  do
#    filename=$(basename -- "$file")
#    name=$(echo "$filename" | cut -f 1 -d '.')
#    echo "\"$name\":{\"red\":require(\"../../assets/images/muscles/red/$name.png\"),\"green\":require(\"../../assets/images/muscles/green/$name.png\"),\"blue\":require(\"../../assets/images/muscles/blue/$name.png\"),\"style\":styles.${name}container}," >> "variables.txt"

# #  done
# filename=$(basename -- "./red/AnteriorHipAdductors.png")
#   name=$(echo "AnteriorHipAdductors.png" | cut -f 1 -d '.')
#    echo "\"$name\":{\"red\":require(\"../../assets/images/muscles/red/$name.png\"),\"green\":require(\"../../assets/images/muscles/green/$name.png\"),\"blue\":require(\"../../assets/images/muscles/blue/$name.png\"),\"style\":styles.${name}container}," >> "variables.txt"
# filename=$(basename -- "./red/PosteriorHipAdductors.png")
#   name=$(echo "PosteriorHipAdductors.png" | cut -f 1 -d '.')
#    echo "\"$name\":{\"red\":require(\"../../assets/images/muscles/red/$name.png\"),\"green\":require(\"../../assets/images/muscles/green/$name.png\"),\"blue\":require(\"../../assets/images/muscles/blue/$name.png\"),\"style\":styles.${name}container}," >> "variables.txt"
