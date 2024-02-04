import * as React from "react";
import { View, Text } from "react-native";
import {
  ExerciseBoardDataLine,
  ExerciseBoardHeaderLine,
} from "../../components/exerciseboard/ExerciseBoardComponents";
import * as ConstantsViews from "../../ConstantsViews";
import * as Schedule from "../../../controller/schedule/Schedule";
import * as ScheduleConstants from "../../../controller/schedule/ConstantsSchedule";
import * as Constants from "../../../helpers/ConstantsCode";

export class WhiteboardScreenExerciseTopContainer extends React.Component {
  render() {
    let day = this.props.day;
    let week = this.props.week;
    let type = this.props.type;

    let daystring = Constants.days[day];
    let weekstring = ScheduleConstants.Weeks[week];
    let typestring = ScheduleConstants.ExerciseType[type];

    var TitleData = [daystring, weekstring, typestring];
    let title = [];
    for (let detail of TitleData) {
      title.push(
        <View key={detail}>
          <Text style={ConstantsViews.whiteboard.subtitle}>{detail}</Text>
        </View>
      );
    }

    return title;
  }
}

export class WhiteboardScreenExerciseMainContainer extends React.Component {
  render() {
    let schedulename = this.props.schedulename;
    var scheduledata = new Schedule.ScheduleData(schedulename);
    var maxsets = scheduledata.GetMaxSets();
    var metaidkeys = scheduledata.GetMetadataKeys();

    let temp = [];
    temp.push(
      <ExerciseBoardHeaderLine
        key={"ExerciseBoardHeaderLine"}
        maxsets={maxsets}
      />
    );

    for (let metaid of metaidkeys) {
      let exercisedata = scheduledata.GetExerciseData(metaid);
      temp.push(
        <ExerciseBoardDataLine
          key={metaid}
          metaid={metaid}
          exercisedata={exercisedata}
          maxsets={maxsets}
        />
      );
    }

    return temp;
  }
}

export default WhiteboardScreenExerciseMainContainer;
