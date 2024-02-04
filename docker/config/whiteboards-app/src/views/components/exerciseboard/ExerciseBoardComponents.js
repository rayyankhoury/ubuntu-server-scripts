import * as React from "react";
import { StyleSheet, View, Text, Image } from "react-native";
import { Video } from "expo-av";
import MuscleView from "./MuscleView";
import { Dimensions } from "react-native";

import {
  WhiteboardErasableText,
  WhiteboardBlankModalContainer,
} from "../whiteboard/WhiteboardComponents";
import PropTypes from "prop-types";
import * as ConstantsCode from "../../../helpers/ConstantsCode";
import { whiteboard } from "../../ConstantsViews";
import * as Exercises from "../../../controller/exercises/Exercises";

export class ExerciseBoardHeaderLine extends React.Component {
  render() {
    return (
      <View style={styles.line} key={"ExerciseBoardHeaderLine"}>
        <View style={styles.name} key={"Name"}>
          <Text style={whiteboard.subtitle}>Name</Text>
        </View>
        {this.renderSetHeaders()}
      </View>
    );
  }

  renderSetHeaders() {
    let sets = [];
    for (var j = 1; j <= this.props.maxsets; j++) {
      sets.push(
        <View style={styles.sets} key={"Set" + j}>
          <Text style={whiteboard.subtitle}>Set {j}</Text>
        </View>
      );
    }
    return sets;
  }
}

ExerciseBoardHeaderLine.propTypes = {
  maxsets: PropTypes.number.isRequired,
};

export class ExerciseBoardDataLine extends React.Component {
  render() {
    // let renderedmodal = this.rendermodal(name, media, mediatype);
    // let media = Exercises.GetMedia(this.props.metaid);
    let name = "   " + this.props.exercisedata.Name();
    return (
      <View style={styles.line} key={this.props.exercisedata.Name()}>
        <WhiteboardBlankModalContainer text={name}>
          <ExerciseBoardModalContents metaid={this.props.metaid} />
        </WhiteboardBlankModalContainer>
        {this.rendersets()}
      </View>
    );
  }

  rendersets() {
    let temp = [];
    for (var i = 0; i < this.props.maxsets; i++) {
      if (i < this.props.exercisedata.NumSets()) {
        temp.push(
          <View style={styles.sets} key={i}>
            <WhiteboardErasableText textColor={this.getcolor(i)}>
              {this.getdatastring()}
            </WhiteboardErasableText>
          </View>
        );
      } else {
        temp.push(<View style={styles.sets} key={i}></View>);
      }
    }
    return temp;
  }

  getdatastring() {
    let exercisedata = this.props.exercisedata;
    if (exercisedata.IsTimeBased()) return exercisedata.Time() + "secs";
    return exercisedata.NumReps() + "reps";
  }

  getcolor(index) {
    let alternating = this.props.exercisedata.IsAlternating();
    if (!alternating) return this.props.defaultcolor;
    if (index % 2 == 0) return this.props.leftcolor;
    return this.props.rightcolor;
  }
}

ExerciseBoardDataLine.propTypes = {
  exercisedata: PropTypes.object.isRequired,
  metaid: PropTypes.string.isRequired,
  maxsets: PropTypes.number.isRequired,
  defaultcolor: PropTypes.string,
  leftcolor: PropTypes.string,
  rightcolor: PropTypes.string,
};

ExerciseBoardDataLine.defaultProps = {
  defaultcolor: "purple",
  leftcolor: "red",
  rightcolor: "blue",
};

// Modal Popup for the exercise board
export class ExerciseBoardModalContents extends React.Component {
  render() {
    return (
      <View style={styles.modalcontents}>
        <Text key={"ExerciseName"} style={whiteboard.title}>
          {Exercises.GetName(this.props.metaid)}
        </Text>
        <View key={"MediaAndMusclesRow"} style={styles.mediaandmusclesrow}>
          <View key={"Media"} style={styles.mediacontainer}>
            {this.rendermedia()}
          </View>
          <MuscleView
            key={"Muscles"}
            style={styles.muscles}
            metaid={this.props.metaid}
          />
        </View>
        {this.renderinformation()}
      </View>
    );
  }
  rendermedia() {
    const windowHeight = Dimensions.get("window").height;

    let mediatype = Exercises.GetMediaType(this.props.metaid);
    let media = Exercises.GetMedia(this.props.metaid);
    switch (mediatype) {
      case ConstantsCode.mediatypes.IMAGE:
        return (
          <Image source={media} style={styles.image} shouldPlay isLooping />
        );
      case ConstantsCode.mediatypes.VIDEO:
        return (
          <Video source={media} style={styles.video} shouldPlay isLooping />
        );
      default:
        throw "MediaType invalid:" + mediatype;
    }
  }

  renderinformation() {
    let preparation = Exercises.GetPreparation(this.props.metaid);
    let execution = Exercises.GetExecution(this.props.metaid);
    let comments = Exercises.GetComments(this.props.metaid);

    let information = [preparation, execution, comments];
    let titles = ["Preparation", "Execution", "Comments"];

    let temp = [];
    for (let index = 0; index < titles.length; index++) {
      if (information[index] != undefined) {
        temp.push(
          <View key={index}>
            <Text key={"TitleText"} style={whiteboard.subtitle}>
              {titles[index]}
            </Text>
            <Text key={"InformationText"} style={styles.modaldefaultText}>
              {information[index]}
            </Text>
          </View>
        );
      }
    }

    return (
      <View key={"InformationRow"} style={styles.informationrow}>
        {temp}
      </View>
    );
  }
}

ExerciseBoardModalContents.propTypes = {
  metaid: PropTypes.string.isRequired,
};

export default ExerciseBoardModalContents;

// Style sheet that creates the styles for the whiteboard

const styles = StyleSheet.create({
  name: {
    flex: 6.5,
  },
  sets: {
    color: "red",
    alignItems: "center",
    flex: 1,
  },
  line: {
    flexDirection: "row",
  },
  modalcontents: {
    // justifyContent: "center",
    alignItems: "center",
    flexDirection: "column",
    position: "relative",
    width: "100%",
    height: "90%",
  },
  informationrow: {
    height: "45%",
    width: "100%",
    flexDirection: "column",
    alignItems: "flex-start",
    justifyContent: "flex-start",
    // alignSelf: "flex-start",
  },
  mediaandmusclesrow: {
    height: "45%",
    flexDirection: "row",
    alignItems: "center",
  },
  mediacontainer: {
    position: "relative",
    justifyContent: "center",
    alignItems: "flex-start",
    alignSelf: "flex-start",
    width: "100%",
    height: "100%",
    flex: 1,
    // flexWrap: "wrap",
  },
  video: {
    height: "100%",
    width: "100%",
    alignItems: "stretch",
    alignSelf: "flex-start",
  },
  image: {
    width: "100%",
    alignItems: "flex-start",
    alignSelf: "flex-start",
    // flexShrink: 1,
  },
  muscles: {
    position: "relative",
    justifyContent: "center",
    alignItems: "center",
    alignSelf: "center",
    flex: 1,
    width: "100%",
    height: "100%",
  },
  modaltitleText: {
    fontFamily: "Arial",
    fontSize: 30,
  },
  modaldefaultText: {
    fontFamily: "Arial",
    fontSize: 15,
  },
});
