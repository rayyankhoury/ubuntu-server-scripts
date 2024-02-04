import { Asset } from "expo-asset";
import { Image } from "expo";
import * as ConstantsMuscles from "../controller/muscles/ConstantsMuscles";


export function IntToDay(day)
{
  return 
}
export function PreloadImages() {
  // Preloads all the images
  Asset.fromModule(
    require("../../public/assets/images/whiteboard/Whiteboard.png")
  ).downloadAsync();

  // Muscles preloader
  PreloadMuscles();
}

function PreloadMuscles() {
  // Muscles preloader
  Asset.fromModule(
    require("../../public/assets/muscles/MaleBody.png")
  ).downloadAsync();
  for (var key of Object.keys(ConstantsMuscles.MuscleImages)) {
    var red = ConstantsMuscles.MuscleImages[key]["red"];
    var green = ConstantsMuscles.MuscleImages[key]["green"];
    var blue = ConstantsMuscles.MuscleImages[key]["blue"];
    Asset.fromModule(red).downloadAsync();
    Asset.fromModule(green).downloadAsync();
    Asset.fromModule(blue).downloadAsync();
  }
}
