import * as Recurring from "./ConstantsRecurring";
import * as Daily from "./ConstantsDaily";

import * as Constants from "../../helpers/ConstantsCode";
import * as ConstantsChores from "./ConstantsChores";

//var ChoresJSON = require("../../../database/schedule/ExerciseSchedule.json");

export class Chore {
  constructor(data) {
    this.data = data;
  }
  GetName() {
    return this.data["Name"];
  }

  GetRecurrence() {
    return this.data["Recurrence"];
  }

  GetCategory() {
    return this.data["Category"];
  }

  GetIsComplete() {
    return this.data["IsComplete"];
  }

  SetIsComplete(complete) {
    this.data["IsComplete"] = complete;
  }
}

export class ChoreData {
  constructor(schedulename) {
    if (!(schedulename in ScheduleDataJSON)) {
      throw schedulename + " is not a valid Schedule Name";
    }
  }
}
