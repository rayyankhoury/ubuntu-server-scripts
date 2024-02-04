import * as React from "react";
import * as Font from "expo-font";
import { AppLoading } from "expo";
import { PreloadImages } from "./helpers/ProjectHelpers";
import TestNavigationScreen from "./views/screens/navigationscreens/TestNavigationScreen";
import AutoNavigationScreen from "./views/screens/navigationscreens/AutoNavigationScreen";

import "react-native-gesture-handler";
import * as Constants from "./helpers/ConstantsCode";
import * as ConstantsSchedule from "./controller/schedule/ConstantsSchedule";
import * as GeneralHelpers from "./helpers/GeneralHelpers";
import AutoNavScreen from "./views/screens/navigationscreens/navtest2";

test = false;

const App = () => {
  // Preloads Fonts
  const [fontsLoaded, error] = Font.useFonts({
    Whiteboard: require("../public/assets/fonts/rabiohead.ttf"),
  });
  if (!fontsLoaded) return <AppLoading />;

  // Preloads all the images
  PreloadImages();

  if (test) return <TestNavigationScreen />;

  var today = new Date().getDay() % 7;
  var weekNumber = new Date().getWeek() % ConstantsSchedule.numWeeks;

  var day = Object.keys(Constants.days)[today];
  var week = ++weekNumber;

  return <AutoNavScreen day={day} week={week} />;
};

export default App;
