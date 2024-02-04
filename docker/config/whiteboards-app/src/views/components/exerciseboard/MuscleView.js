import * as React from "react";
import { View, Image, StyleSheet, ImageBackground } from "react-native";
import {
  MaleBodyImage,
  MuscleImages,
  Colors,
} from "../../../controller/muscles/ConstantsMuscles";
import SeparateMuscles from "../../../controller/muscles/Muscles";
import PropTypes from "prop-types";

export class MuscleView extends React.Component {
  render() {
    var separatemuscles = SeparateMuscles(this.props.metaid);
    var muscles = MapColors(separatemuscles);
    var drawable = [];
    for (let colorkey in Colors) {
      let color = Colors[colorkey];
      drawable.push(LoopColor(color, muscles[color]));
    }

    return (
      <ImageBackground style={styles.background} source={MaleBodyImage}>
        {drawable}
      </ImageBackground>
    );
  }
}

MuscleView.propTypes = {
  metaid: PropTypes.string.isRequired,
};

function MapColors(muscles) {
  var mappedcolors = {};
  for (let colorkey in Colors) {
    let color = Colors[colorkey];
    let unmappedcolors = muscles[color];
    mappedcolors[color] = new Set();

    for (let unmapped of unmappedcolors) {
      var musclemap = mapkeys[unmapped];
      if (musclemap == undefined) continue;
      for (var currentkey of musclemap) {
        mappedcolors[color].add(currentkey);
      }
    }
  }
  return mappedcolors;
}

function LoopColor(color, colorarray) {
  var temp = [];
  for (let musclecontainer of colorarray) {
    var current = MuscleImages[musclecontainer];
    var uniquekey = color + musclecontainer;
    temp.push(
      <View style={styles[musclecontainer]} key={uniquekey}>
        <Image style={styles.muscle} source={current[color]}></Image>
      </View>
    );
  }
  return temp;
}

export default MuscleView;

const styles = StyleSheet.create({
  background: {
    position: "relative",
    width: "100%",
    height: "100%",
    aspectRatio: 1.3333333333333333333,
    flex: 1,
  },
  muscle: {
    width: "100%",
    aspectRatio: 1,
    height: undefined,
    resizeMode: "contain",
  },
  AnteriorBicepsLeft: {
    top: "26.9%",
    left: "19.5%",
    position: "relative",
    width: "6.7%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorBicepsRight: {
    top: "26.9%",
    left: "35.3%",
    position: "absolute",
    width: "6.7%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorDeltoidsLeft: {
    top: "20.7%",
    left: "21.9%",
    position: "absolute",
    width: "5.75%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorDeltoidsRight: {
    top: "20.7%",
    left: "34%",
    position: "absolute",
    width: "5.75%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorForearmsLeft: {
    top: "33.5%",
    left: "15.45%",
    position: "absolute",
    width: "9.1%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorForearmsRight: {
    top: "33.5%",
    left: "36.95%",
    position: "absolute",
    width: "9.1%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorGastrocnemiusLeft: {
    top: "65%",
    left: "19.2%",
    position: "absolute",
    width: "12.7%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorGastrocnemiusRight: {
    top: "65%",
    left: "29.7%",
    position: "absolute",
    width: "12.7%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorHipAbductors: {
    top: "34.2%",
    left: "23.8%",
    position: "absolute",
    width: "13.9%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorLowerMiddleRectusAbdominis: {
    top: "33.95%",
    left: "27.45%",
    position: "absolute",
    width: "6.4%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorLowerRectusAbdominis: {
    top: "39.45%",
    left: "27.22%",
    position: "absolute",
    width: "6.8%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorObliques: {
    top: "28.05%",
    left: "23.45s%",
    position: "absolute",
    width: "14.7%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorPectoralis: {
    top: "16.9%",
    left: "24.3%",
    position: "absolute",
    width: "13%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorQuadriceps: {
    top: "43.15%",
    left: "23.33%",
    position: "absolute",
    width: "14.9%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorSternocleidomastoid: {
    top: "16.6%",
    left: "26.25%",
    position: "absolute",
    width: "9%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorTibialis: {
    top: "64.35%",
    left: "24.25%",
    position: "absolute",
    width: "13.2%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorTrapeziusLeft: {
    top: "17.3%",
    left: "26.65%",
    position: "absolute",
    width: "3.5%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorTrapeziusRight: {
    top: "17.3%",
    left: "31.35%",
    position: "absolute",
    width: "3.5%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorUpperMidRectusAbdominis: {
    top: "30.5%",
    left: "27.4%",
    position: "absolute",
    width: "6.45%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorUpperRectusAbdominis: {
    top: "26.6%",
    left: "27.4%",
    position: "absolute",
    width: "6.45%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorDeltoidsLeft: {
    top: "19.35%",
    left: "61.6%",
    position: "absolute",
    width: "5.5%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorDeltoidsRight: {
    top: "19.3%",
    left: "74.8%",
    position: "absolute",
    width: "5.6%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorErectorSpinae: {
    top: "32.87%",
    left: "66.73%",
    position: "absolute",
    width: "8.35%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorForearmsLeft: {
    top: "33.58%",
    left: "54.41%",
    position: "absolute",
    width: "9.8%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorForearmsRight: {
    top: "33.58%",
    left: "77.64%",
    position: "absolute",
    width: "9.8%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorGastrocnemiusLeft: {
    top: "64.2%",
    left: "59.4%",
    position: "absolute",
    width: "9.9%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorGastrocnemiusRight: {
    top: "64.2%",
    left: "72.6%",
    position: "absolute",
    width: "9.8%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorGluteusMaximus: {
    top: "38.53%",
    left: "64.89%",
    position: "absolute",
    width: "12.1%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorHamstrings: {
    top: "47.53%",
    left: "63.12%",
    position: "absolute",
    width: "15.75%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorHipAbductors: {
    top: "35.5%",
    left: "64.4%",
    position: "absolute",
    width: "13.1%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorLatissimusLeft: {
    top: "26.75%",
    left: "62.55%",
    position: "absolute",
    width: "10.3%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorLatissimusRight: {
    top: "26.75%",
    left: "69.1%",
    position: "absolute",
    width: "10.3%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorLowerTrapezius: {
    top: "18.05%",
    left: "65.45%",
    position: "absolute",
    width: "10.95%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorRhomboids: {
    top: "15.2%",
    left: "64.3%",
    position: "absolute",
    width: "13.3%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorSoleus: {
    top: "70.0%",
    left: "61.7%",
    position: "absolute",
    width: "18.55%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorTricepsLeft: {
    top: "24.9%",
    left: "58.65%",
    position: "absolute",
    width: "7.6%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorTricepsRight: {
    top: "24.85%",
    left: "75.68%",
    position: "absolute",
    width: "7.58%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorUpperTrapezius: {
    top: "12.3%",
    left: "67%",
    position: "absolute",
    width: "7.58%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  PosteriorHipAdductors: {
    top: "52.2%",
    left: "69.4%",
    position: "absolute",
    width: "3.1%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
  AnteriorHipAdductors: {
    top: "47.6%",
    left: "26.93%",
    position: "absolute",
    width: "7.58%",
    height: undefined,
    resizeMode: "contain",
    flex: 1,
  },
});

var mapkeys = {
  Back: [],
  General: [],
  "Hip Abductors (listed below)": [
    "AnteriorHipAbductors",
    "PosteriorHipAbductors",
  ],
  "Hip Abductors (opposite)": ["AnteriorHipAbductors", "PosteriorHipAbductors"],
  "Hip External Rotators (listed below)": [],
  "Hip Internal Rotators (listed below)": [],
  "Longus capitis": ["AnteriorSternocleidomastoid"],
  "Longus colli": ["AnteriorSternocleidomastoid"],
  "No significant stabilizer": [],
  "No significant stabilizers": [],
  "No significant stabilizers.": [],
  None: [],
  "Rectus capitus": [],
  "See comments": [],
  Supinator: [
    "AnteriorForearmsLeft",
    "AnteriorForearmsRight",
    "PosteriorForearmsLeft",
    "PosteriorForearmsRight",
  ],
  adductors: ["AnteriorHipAdductors", "PosteriorHipAdductors"],
  bicepsbrachii: ["AnteriorBicepsLeft", "AnteriorBicepsRight"],
  brachialis: ["AnteriorBicepsLeft", "AnteriorBicepsRight"],
  brachioradialis: [
    "AnteriorForearmsLeft",
    "AnteriorForearmsRight",
    "PosteriorForearmsLeft",
    "PosteriorForearmsRight",
  ],
  deltoidanterior: ["AnteriorDeltoidsLeft", "AnteriorDeltoidsRight"],
  deltoidlateral: [
    "AnteriorDeltoidsLeft",
    "AnteriorDeltoidsRight",
    "PosteriorDeltoidsLeft",
    "PosteriorDeltoidsRight",
  ],
  deltoidposterior: ["PosteriorDeltoidsLeft", "PosteriorDeltoidsRight"],
  erectorspinae: ["PosteriorErectorSpinae"],
  "forearm#pronation": [
    "AnteriorForearmsLeft",
    "AnteriorForearmsRight",
    "PosteriorForearmsLeft",
    "PosteriorForearmsRight",
  ],
  gastrocnemius: [
    "AnteriorGastrocnemiusLeft",
    "AnteriorGastrocnemiusRight",
    "PosteriorGastrocnemiusLeft",
    "PosteriorGastrocnemiusRight",
  ],
  gluteusmaximus: ["PosteriorGluteusMaximus"],
  gluteusmedius: ["PosteriorHipAbductors"],
  gluteusminimus: ["PosteriorHipAbductors"],
  gracilis: ["AnteriorHipAdductors"],
  hamstrings: ["PosteriorHamstrings"],
  "hip#abduction": ["AnteriorHipAbductors", "PosteriorHipAbductors"],
  "hip#flexion": ["AnteriorQuadricepsLeft", "AnteriorQuadricepsRight"],
  hipexernalrotators: ["PosteriorHipAdductors"],
  iliopsoas: ["AnteriorHipAdductors"],
  infraspinatus: ["PosteriorRhomboids"],
  latissimusdorsi: ["PosteriorLatissimusLeft", "PosteriorLatissimusRight"],
  levatorscapulae: ["PosteriorUpperTrapezius"],
  obliques: ["AnteriorObliques"],
  pectineus: ["AnteriorHipAdductors"],
  pectoralisclavicular: ["AnteriorPectoralis"],
  pectoralisminor: ["AnteriorPectoralis"],
  pectoralissternal: ["AnteriorPectoralis"],
  popliteus: ["PosteriorGastrocnemiusLeft", "PosteriorGastrocnemiusRight"],
  quadratuslumborum: ["AnteriorObliques"],
  quadriceps: ["AnteriorQuadriceps"],
  rectusabdominis: [
    "AnteriorUpperRectusAbdominis",
    "AnteriorUpperMidRectusAbdominis",
    "AnteriorLowerMiddleRectusAbdominis",
    "AnteriorLowerRectusAbdominis",
  ],
  rhomboids: ["PosteriorRhomboids"],
  sartorius: ["AnteriorHipAdductors"],
  serratusanterior: [],
  soleus: ["PosteriorSoleus"],
  splenius: ["PosteriorUpperTrapezius"],
  sternocleidomastoid: ["AnteriorSternocleidomastoid"],
  subscapularis: ["PosteriorRhomboids"],
  supraspinatus: ["PosteriorRhomboids"],
  tensorfasciaelatae: ["AnteriorHipAdductors"],
  teresmajor: ["PosteriorRhomboids"],
  teresminor: ["PosteriorRhomboids"],
  tibialisanterior: ["AnteriorTibialis"],
  trapeziuslower: ["PosteriorLowerTrapezius"],
  trapeziusmiddle: [
    "PosteriorLowerTrapezius",
    "PosteriorUpperTrapezius",
    "AnteriorTrapeziusLeft",
    "AnteriorTrapeziusRight",
  ],
  trapeziusupper: [
    "PosteriorUpperTrapezius",
    "AnteriorTrapeziusLeft",
    "AnteriorTrapeziusRight",
  ],
  tricepsbrachii: ["PosteriorTricepsLeft", "PosteriorTricepsRight"],
  wristextensors: [
    "AnteriorForearmsLeft",
    "AnteriorForearmsRight",
    "PosteriorForearmsLeft",
    "PosteriorForearmsRight",
  ],
  wristflexors: [
    "AnteriorForearmsLeft",
    "AnteriorForearmsRight",
    "PosteriorForearmsLeft",
    "PosteriorForearmsRight",
  ],
};
