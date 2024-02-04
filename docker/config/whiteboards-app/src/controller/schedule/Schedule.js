import * as Constants from "../../helpers/ConstantsCode";
import * as ConstantsSchedule from "./ConstantsSchedule";

var ExerciseScheduleJSON = require("../../../public/exercises/schedules/ExerciseSchedule.json");
var ScheduleDataJSON = require("../../../public/exercises/schedules/ScheduleData.json");

export class ExerciseData {
  constructor(data) {
    this.data = data;
  }
  GetName() {
    return this.data["Name"];
  }

  GetNumSets() {
    return parseInt(this.data["Sets"]);
  }

  GetNumReps() {
    return parseInt(this.data["Reps"]);
  }

  GetTime() {
    return parseInt(this.data["Time"]);
  }

  GetIsAlternating() {
    if (parseInt(this.data["Alternating"]) == 0) return false;
    return true;
  }

  GetIsTimeBased() {
    if (this.GetTime() > 0) return true;
  }
}

export class ScheduleData {
  constructor(schedulename) {
    if (!(schedulename in ScheduleDataJSON)) {
      throw schedulename + " is not a valid Schedule Name";
    }
    this.schedulename = schedulename;
    this.scheduledata = ScheduleDataJSON[schedulename];
    this.LoadExerciseData();
  }

  LoadExerciseData() {
    this.keys = [];
    this.exercisesdata = {};
    this.maxsets = 0;
    for (let exercise in this.scheduledata) {
      // Key
      this.keys.push(exercise);

      // Data
      let rawdata = this.scheduledata[exercise];
      let exercisedata = new ExerciseData(rawdata);
      this.exercisesdata[exercise] = exercisedata;

      // Max Sets
      let numsets = exercisedata.GetNumSets();
      if (numsets > this.maxsets) {
        this.maxsets = numsets;
      }
    }
  }

  GetExerciseData(metaid) {
    let exercisedata = this.exercisesdata[metaid];
    if (exercisedata) {
      return exercisedata;
    }
    throw "No Exercise Data for key: " + metaid;
  }

  // Returns the maximum number of sets in this schedule
  GetMaxSets() {
    return this.maxsets;
  }

  GetMetadataKeys() {
    if (this.keys && this.keys.length > 0) return this.keys;
    throw "No keys Object";
  }
}

// Returns a string
export function GetScheduleNameDWT(Day, Week, Type) {
  if (!(Type in ConstantsSchedule.ExerciseType)) {
    throw Type + " is not a valid Schedule Type";
  }
  return GetScheduleNameDW(Day, Week)[ConstantsSchedule.ExerciseType[Type]];
}

// Returns a dictionary of key value pairs
export function GetScheduleNameDW(Day, Week) {
  if (!(Week in ConstantsSchedule.Weeks)) {
    throw Week + " is not a valid week Exercise Schedule";
  }
  let schedule = GetScheduleNameD(Day);
  let weekstring = ConstantsSchedule.Weeks[Week];
  return schedule[weekstring];
}

// Returns a dictionary of schedules relevant to this day
export function GetScheduleNameD(Day) {
  if (!(Day in Constants.days)) {
    throw Day + " not in Exercise Schedule";
  }
  let daystring = Constants.days[Day];
  return ExerciseScheduleJSON[daystring];
}

export function ScheduleExists(Day, Week, Type) {
  if (GetScheduleNameDWT(Day, Week, Type) == "") return false;
  return true;
}
