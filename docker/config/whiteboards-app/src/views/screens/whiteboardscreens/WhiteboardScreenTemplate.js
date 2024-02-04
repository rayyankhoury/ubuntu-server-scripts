import * as React from "react";
import { StyleSheet, ImageBackground, SafeAreaView, View } from "react-native";
import PropTypes from "prop-types";
// Creates the whiteboard
export class WhiteboardScreenTemplate extends React.Component {
  render() {
    // Renders the board to the screen
    return (
      <ImageBackground
        key="WhiteboardBackground"
        style={styles.background}
        source={require("../../../../public/assets/images/whiteboard/Whiteboard.png")}
      >
        <SafeAreaView style={styles.drawablearea} key="WhiteboardView">
          <View style={styles.top} key="WhiteboardTopView">
            {this.props.toprender}
          </View>
          <View style={styles.main} key="WhiteboardMainView">
            {this.props.mainrender}
          </View>
        </SafeAreaView>
      </ImageBackground>
    );
  }
}

WhiteboardScreenTemplate.propTypes = {
  toprender: PropTypes.object.isRequired,
  mainrender: PropTypes.object.isRequired,
};

WhiteboardScreenTemplate.defaultProps = {
  toprender: [],
  mainrender: [],
};

export default WhiteboardScreenTemplate;

// Style sheet that creates the grid for the whiteboard
const styles = StyleSheet.create({
  background: {
    width: "100%",
    height: "100%",
    flex: 1,
    justifyContent: "center",
  },
  drawablearea: {
    // backgroundColor: "red",
    flex: 1,
    justifyContent: "center",
    marginTop: "2.8%",
    marginBottom: "3%",
    marginLeft: "2.8%",
    marginRight: "3.1%",
  },
  top: {
    //backgroundColor: "red",
    flex: 2,
    flexDirection: "column",
    justifyContent: "flex-start",
    alignItems: "center",
  },
  main: {
    // backgroundColor: "blue",
    flex: 7,
    flexDirection: "column",
    justifyContent: "flex-start",
  },
});
