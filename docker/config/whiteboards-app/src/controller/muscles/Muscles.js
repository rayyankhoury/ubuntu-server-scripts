import * as Exercises from "../exercises/Exercises";

const { MuscleImages, MaleBodyImage, Colors } = require("./ConstantsMuscles");

export function SeparateMuscles(metaid) {
  let muscles = {};
  var muscleinfo = Exercises.GetMuscleInformation(metaid);
  for (let colorkey in Colors) {
    muscles[Colors[colorkey]] = new Set();
  }
  // Gets the necessary information from the details file
  for (let category in muscleinfo) {
    let color = FilterColor(category);
    let info = muscleinfo[category];

    for (let muscle of info) {
      muscles[color].add(muscle);
    }
  }
  return muscles;
}

// Gets the base male body image
export function GetMaleBodyImage() {
  return MaleBodyImage;
}

export function GetMuscleOfColor(muscle, color) {
  return MuscleImages[muscle][color];
}

export function GetMusclesOfColor(muscle_array, color) {
  // error check for colors
  if (!Colors.has(colors)) {
    throw "Color doesn't exist";
  }

  musclecolors = [];
  for (let muscle of muscle_array) {
    // error check for muscles
    if (!MuscleImages.has(muscle)) {
      throw "Muscle doesn't exist";
    }
    let musclecolor = GetMuscleOfColor(muscle, color);
    musclecolors.push(musclecolor);
  }
  return _.uniq(musclecolors);
}

function FilterColor(musclegroup) {
  switch (musclegroup) {
    case "antagonist stabilizers":
      return Colors.GREEN;
    case "dynamic stabilizers":
      return Colors.GREEN;
    case "other":
      return Colors.GREEN;
    case "stabilizers":
      return Colors.GREEN;
    case "synergists":
      return Colors.BLUE;
    case "target":
      return Colors.RED;
    default:
      throw "Muscle Group doesn't exist: " + musclegroup;
  }
}

export default SeparateMuscles;
