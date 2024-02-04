import * as React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { Button, Text, View } from "react-native";
import { NavigationContainer } from "@react-navigation/native";

import WhiteboardScreenTemplate from "../whiteboardscreens/WhiteboardScreenTemplate";
import {
  WhiteboardScreenExerciseMainContainer,
  WhiteboardScreenExerciseTopContainer,
} from "../whiteboardscreens/WhiteboardScreenExercise";

import * as Schedule from "../../../controller/schedule/Schedule";
import * as ConstantsSchedule from "../../../controller/schedule/ConstantsSchedule";
// import * as Constants from "../../../code/ConstantsCode";

const Tab = createBottomTabNavigator();

/*
initialRouteName={ConstantsSchedule.ExerciseType["WARMUPS"]}
        >
        */

export default class AutoNavigationScreen extends React.Component {
  render() {
    let day = this.props.day;
    // let week = this.props.week;
    // let warmupsscr = RenderExerciseScreen(
    //   day,
    //   week,
    //   Object.keys(ConstantsSchedule.ExerciseType)[0]
    // );
    // let exercisescr = RenderExerciseScreen(
    //   day,
    //   week,
    //   Object.keys(ConstantsSchedule.ExerciseType)[1]
    // );
    let yes = "fuck you";
    let screentest = screen("h");
    return (
      <NavigationContainer>
        <Tab.Navigator>
          <Tab.Screen
            name={ConstantsSchedule.ExerciseType["WARMUPS"]}
            component={screen}
          />
          <Tab.Screen
            name={ConstantsSchedule.ExerciseType["EXERCISES"]}
            component={screen}
            style={{ backgroundColor: "blue" }}
          />
        </Tab.Navigator>
      </NavigationContainer>
    );
  }
}

function screen({ yes }) {
  return (
    <View style={{ backgroundColor: "pink" }}>
      <Text>hi{yes}</Text>
    </View>
  );
}

function RenderExerciseScreen(day, week, type) {
  if (!Schedule.ScheduleExists(day, week, type))
    return <Text>No exercises yay!</Text>;
  let schedulename = Schedule.GetScheduleNameDWT(day, week, type);
  console.log(day);
  console.log(week);
  console.log(type);
  console.log(schedulename);
  return (
    <SafeAreaProvider>
      {(props) => (
        <WhiteboardScreenTemplate
          {...props}
          toprender={
            <WhiteboardScreenExerciseTopContainer
              day={day}
              week={week}
              type={type}
            />
          }
          mainrender={
            <WhiteboardScreenExerciseMainContainer
              schedulename={schedulename}
            />
          }
        />
      )}
    </SafeAreaProvider>
  );
}

const stackscreenstyle = {
  headerStyle: {
    height: 50,
  },
  headerTransparent: true,
  headerTitle: false,
};

// function HomeScreen() {
//   return (
//     <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
//       <Text>Home!</Text>
//     </View>
//   );
// }

// function SettingsScreen() {
//   return (
//     <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
//       <Text>Settings!</Text>
//     </View>
//   );
// }

// function HomeScreen({ navigation }) {
//   return (
//     <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
//       <Text>Home screen</Text>
//       <Button
//         title="Go to Details"
//         onPress={() => navigation.navigate('Details')}
//       />
//     </View>
//   );
// }

// function SettingsScreen({ navigation }) {
//   return (
//     <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
//       <Text>Settings screen</Text>
//       <Button
//         title="Go to Details"
//         onPress={() => navigation.navigate('Details')}
//       />
//     </View>
//   );
// }
