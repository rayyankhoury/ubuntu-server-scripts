import * as React from "react";
import { Text, View, TouchableOpacity, StyleSheet } from "react-native";
import { TabView, SceneMap } from "react-native-tab-view";
import Animated from "react-native-reanimated";
import * as Schedule from "../../../controller/schedule/Schedule";
import * as ConstantsSchedule from "../../../controller/schedule/ConstantsSchedule";
// import ScrollableTabView, {
//   DefaultTabBar,
// } from "react-native-scrollable-tab-view";

import WhiteboardScreenTemplate from "../whiteboardscreens/WhiteboardScreenTemplate";
import {
  WhiteboardScreenExerciseMainContainer,
  WhiteboardScreenExerciseTopContainer,
} from "../whiteboardscreens/WhiteboardScreenExercise";

/*

  */

export default class AutoNavScreen extends React.Component {
  state = {
    index: 0,
    routes: [
      {
        key: "Warmups",
        title: "Warmups",
      },
      {
        key: "Exercises",
        title: "Exercises",
      },
    ],
  };
  day = this.props.day;
  week = this.props.week;
  schedulename = Schedule.GetScheduleNameDWT(
    this.props.day,
    this.props.week,
    Object.keys(ConstantsSchedule.ExerciseType)[0]
  );

  schedulename2 = Schedule.GetScheduleNameDWT(
    this.props.day,
    this.props.week,
    Object.keys(ConstantsSchedule.ExerciseType)[1]
  );

  FirstRoute = () => (
    <WhiteboardScreenTemplate
      toprender={
        <WhiteboardScreenExerciseTopContainer
          day={this.day}
          week={this.week}
          type={this.state.routes[0].key}
        />
      }
      mainrender={
        <WhiteboardScreenExerciseMainContainer
          schedulename={this.schedulename}
        />
      }
    />
  );

  SecondRoute = (data) => (
    <WhiteboardScreenTemplate
      toprender={
        <WhiteboardScreenExerciseTopContainer
          day={this.day}
          week={this.week}
          type={this.state.routes[1].key}
        />
      }
      mainrender={
        <WhiteboardScreenExerciseMainContainer
          schedulename={this.schedulename2}
        />
      }
    />
  );

  _handleIndexChange = (index) => this.setState({ index });

  _renderTabBar = (props) => {
    // let route0 = this.state.routes[0].key;
    // let route1 = this.state.routes[1].key;
    // if (!Schedule.ScheduleExists(this.props.day, this.props.week, route0))
    //   return <Text>No exercises yay!</Text>;

    // if (!Schedule.ScheduleExists(this.props.day, this.props.week, route1))
    //   return <Text>No exercises yay!</Text>;

    // console.log(route0);
    // console.log("hello" + route0);
    // schedulename = Schedule.GetScheduleNameDWT(
    //   this.props.day,
    //   this.props.week,
    //   route0
    // );

    const inputRange = props.navigationState.routes.map((x, i) => i);
    return (
      <View style={styles.tabBar}>
        {props.navigationState.routes.map((route, i) => {
          const color = Animated.color(
            Animated.round(
              Animated.interpolate(props.position, {
                inputRange,
                outputRange: inputRange.map((inputIndex) =>
                  inputIndex === i ? 50 : 0
                ),
              })
            ),
            0,
            0
          );

          return (
            <TouchableOpacity
              style={styles.tabItem}
              onPress={() => this.setState({ index: i })}
            >
              <Animated.Text style={{ color }}>{route.title}</Animated.Text>
            </TouchableOpacity>
          );
        })}
      </View>
    );
  };

  _renderScene = SceneMap({
    Warmups: this.FirstRoute,
    Exercises: this.SecondRoute,
  });

  render() {
    return (
      <TabView
        tabBarPosition={"bottom"}
        navigationState={this.state}
        renderScene={this._renderScene}
        renderTabBar={this._renderTabBar}
        onIndexChange={this._handleIndexChange}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "green",
    flex: 1,
  },
  tabBar: {
    zIndex: 500,
    backgroundColor: "rgba(50, 50, 50, 0.6)",
    alignItems: "center",
    position: "absolute",
    flexDirection: "row",
    top: 0,
  },
  tabItem: {
    position: "relative",
    flex: 1,
    alignItems: "center",
    padding: 10,
  },
});
