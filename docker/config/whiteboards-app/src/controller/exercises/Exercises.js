import * as Exrx from "./ConstantsExrx";
import * as Custom from "./ConstantsCustom";
import * as Constants from "../../helpers/ConstantsCode";
import { Image } from "react-native";

/* Promises to return a dictionary as follows:
  {
    metaid:
        {
            id:
            details:
            media:
        }
  }
*/
export function GetMultipleMetadata(metaids) {
  var temp = {};
  for (var metaid of metaids) {
    temp[metaid] = GetSingleMetadata(metaid);
  }
  return temp;
}

/* Promises to return a dictionary as follows:
  metaid:
    {
      id:
      details:
      media:
    }
*/
export function GetSingleMetadata(metaid) {
  return SelectDatabase(metaid).metadata[metaid];
}

export function GetExerciseDetails(metaid) {
  return SelectDatabase(metaid).metadata[metaid]["details"][metaid];
}

export function GetExerciseID(metaid) {
  return SelectDatabase(metaid).metadata[metaid]["id"];
}

export function GetMedia(metaid) {
  return SelectDatabase(metaid).metadata[metaid]["media"];
}

export function GetMediaType(metaid) {
  let uri = Image.resolveAssetSource(GetMedia(metaid)).uri;
  for (let type in Constants.imageextensions) {
    if (uri.includes("." + Constants.imageextensions[type]))
      return Constants.mediatypes.IMAGE;
  }
  for (let type in Constants.videoextensions) {
    if (uri.includes("." + Constants.videoextensions[type]))
      return Constants.mediatypes.VIDEO;
  }
  throw "Media Extension not found: " + metaid;
}

// Returns the muscle inf in set format
export function GetMuscleInformation(metaid) {
  var temp = {};
  let details = GetExerciseDetails(metaid);

  for (let key in Constants.MuscleTypes) {
    let muscletype = Constants.MuscleTypes[key];
    if (muscletype in details) {
      temp[muscletype] = new Set();
      muscles = ParseMuscleString(details[muscletype]);
      for (let muscle of muscles) {
        temp[muscletype].add(muscle);
      }
    }
  }
  return temp;
}

export function GetMuscleGroup(metaid) {
  return GetExerciseDetails(metaid)["musclegroup"];
}
export function GetEquipment(metaid) {
  return GetExerciseDetails(metaid)["equipment"];
}
export function GetExerciseType(metaid) {
  return GetExerciseDetails(metaid)["exercisetype"];
}
export function GetName(metaid) {
  return GetExerciseDetails(metaid)["name"];
}
export function GetMuscleClass(metaid) {
  return GetExerciseDetails(metaid)["muscleclass"];
}
export function GetUtility(metaid) {
  return GetExerciseDetails(metaid)["utlity"];
}
export function GetMechanics(metaid) {
  return GetExerciseDetails(metaid)["mechanics"];
}
export function GetForce(metaid) {
  return GetExerciseDetails(metaid)["force"];
}
export function GetPreparation(metaid) {
  return GetExerciseDetails(metaid)["preparation"];
}
export function GetExecution(metaid) {
  return GetExerciseDetails(metaid)["execution"];
}
export function GetComments(metaid) {
  return GetExerciseDetails(metaid)["comments"];
}

function ParseMuscleString(muscles) {
  var muscles = muscles.replace(/ /g, "");
  var muscles = muscles.split(",");
  return muscles;
}

// Chooses the correct database to return information from
function SelectDatabase(metaid) {
  if (metaid.startsWith("Custom")) {
    return Custom;
  } else return Exrx;
}
