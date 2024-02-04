import * as React from "react";
import { View, Button } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import { SafeAreaProvider } from "react-native-safe-area-context";

import WhiteboardScreenTemplate from "../whiteboardscreens/WhiteboardScreenTemplate";
import {
  WhiteboardScreenExerciseMainContainer,
  WhiteboardScreenExerciseTopContainer,
} from "../whiteboardscreens/WhiteboardScreenExercise";
import * as Schedule from "../../../controller/schedule/Schedule";
import * as ScheduleConstants from "../../../controller/schedule/ConstantsSchedule";
import * as Constants from "../../../helpers/ConstantsCode";

const Stack = createStackNavigator();
var ExerciseScheduleKeys = {};
var loadedscreens;

export default class TestNavigationScreen extends React.Component {
  render() {
    return (
      <SafeAreaProvider>
        <NavigationContainer>
          <Stack.Navigator initialRouteName="All Boards">
            {LoadExerciseScreens()}
            <Stack.Screen
              key="Default Whiteboard"
              name="Default Whiteboard"
              options={stackscreenstyle}
            >
              {(props) => <WhiteboardScreenTemplate {...props} />}
            </Stack.Screen>
            <Stack.Screen name="All Boards" component={DetailsScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      </SafeAreaProvider>
    );
  }
}

function DetailsScreen({ navigation }) {
  return (
    <View style={detailsscreenstyle}>
      {RenderScheduleButtons(navigation)}
      <Button
        key="Default Whiteboard"
        title="Default Whiteboard"
        onPress={() => navigation.navigate("Default Whiteboard")}
      />
    </View>
  );
}

function RenderScheduleButtons(navigation) {
  var schedulebuttons = [];
  for (let key in ExerciseScheduleKeys) {
    schedulebuttons.push(
      <Button key={key} title={key} onPress={() => navigation.navigate(key)} />
    );
  }
  return schedulebuttons;
}

function LoadExerciseScreens() {
  if (loadedscreens && loadedscreens.length > 0) return loadedscreens;
  LoadExerciseScheduleData();

  var exercisescreens = [];

  for (let key in ExerciseScheduleKeys) {
    let curr = ExerciseScheduleKeys[key];
    exercisescreens.push(
      <Stack.Screen name={key} key={key} options={stackscreenstyle}>
        {(props) => (
          <WhiteboardScreenTemplate
            {...props}
            toprender={
              <WhiteboardScreenExerciseTopContainer
                day={curr["Headers"][0]}
                week={curr["Headers"][1]}
                type={curr["Headers"][2]}
              />
            }
            mainrender={
              <WhiteboardScreenExerciseMainContainer
                schedulename={curr["Name"]}
              />
            }
          />
        )}
      </Stack.Screen>
    );
  }

  loadedscreens = exercisescreens;
  return exercisescreens;
}

function LoadExerciseScheduleData() {
  for (let day in Constants.days) {
    for (let week in ScheduleConstants.Weeks) {
      for (let type in ScheduleConstants.ExerciseType) {
        if (!Schedule.ScheduleExists(day, week, type)) continue;
        let schedulename = Schedule.GetScheduleNameDWT(day, week, type);
        let key = Constants.days[day] + " " + schedulename;
        if (key in ExerciseScheduleKeys) continue;

        ExerciseScheduleKeys[key] = {
          Name: schedulename,
          Headers: [day, week, type],
        };
      }
    }
  }
}

const stackscreenstyle = {
  headerStyle: {
    height: 50,
  },
  headerTransparent: true,
  headerTitle: false,
};

const detailsscreenstyle = {
  flex: 1,
  alignItems: "center",
  justifyContent: "center",
  backgroundColor: "transparent",
};
