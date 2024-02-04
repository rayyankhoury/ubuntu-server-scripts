import * as React from "react";
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  TouchableHighlight,
  Modal,
} from "react-native";
import { whiteboard } from "../../ConstantsViews";

// Whiteboard Container than on press updates an internal state passed in as a child
// Takes contents
// Takes title
export class WhiteboardBlankModalContainer extends React.Component {
  state = {
    modalcontainer: <View />,
    modalcontainervisibility: false,
  };

  // toggles the visibility
  onPress = () => {
    this.setState({
      modalcontainervisibility: true,
    });
  };

  render() {
    let text = this.props.text;
    return (
      <View style={grid.name}>
        <TouchableOpacity onPress={this.onPress} key={text}>
          <Text style={whiteboard.midsize}>{text}</Text>
          {this.rendermodal()}
        </TouchableOpacity>
      </View>
    );
  }

  rendermodal() {
    return (
      <Modal
        animationType="slide"
        transparent={true}
        visible={this.state.modalcontainervisibility}
        onRequestClose={() => {
          Alert.alert("Modal has been closed.");
        }}
      >
        <View style={styles.centeredView}>
          <View style={styles.modalView} backgroundColor="lightgrey">
            {this.props.children}
            {this.renderclosebutton()}
          </View>
        </View>
      </Modal>
    );
  }

  renderclosebutton() {
    return (
      <TouchableHighlight
        style={{
          ...styles.openButton,
          backgroundColor: "transparent",
        }}
        onPress={() => {
          this.setState({ modalcontainervisibility: false });
        }}
      >
        <Text style={whiteboard.title}>X</Text>
      </TouchableHighlight>
    );
  }
}

// Custom component for erasable text
// Takes in a text initially and replaces it with a blank string on touch
export class WhiteboardErasableText extends React.Component {
  // Inputs
  state = {
    textValue: this.props.children,
  };
  // Action
  onPress = () => {
    this.setState({
      textValue: "",
    });
  };
  // Draw
  render() {
    return (
      <TouchableOpacity
        style={styles.reps}
        onPress={this.onPress}
        key={this.state.textValue}
      >
        <Text
          style={{
            fontFamily: "Whiteboard",
            fontSize: 35,
            color: this.props.textColor,
          }}
        >
          {this.state.textValue}
        </Text>
        {this.state.imageValue}
      </TouchableOpacity>
    );
  }
}
export default WhiteboardErasableText;

const styles = StyleSheet.create({
  reps: {
    color: "red",
    alignItems: "center",
    flex: 1,
    //backgroundColor: "pink",
  },
  name: {
    // backgroundColor: "purple",
    flex: 6.5,
  },
  background: {
    flex: 1,
    justifyContent: "center",
  },
  modalBackground: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  centeredView: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    marginTop: 22,
  },
  modalView: {
    width: "70%",
    margin: 20,
    // backgroundColor: "white",
    borderRadius: 20,
    padding: 35,
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },
  openButton: {
    backgroundColor: "#F194FF",
    borderRadius: 20,
    padding: 10,
    elevation: 2,
  },
  textStyle: {
    // color: "white",
    fontWeight: "bold",
    textAlign: "center",
  },
  modalText: {
    marginBottom: 15,
    textAlign: "center",
    fontFamily: "Arial",
  },
});

const grid = StyleSheet.create({
  workouts: {
    // backgroundColor: "blue",
    flex: 7,
    flexDirection: "column",
    justifyContent: "flex-start",
  },
  exercises: {
    // backgroundColor: "yellow",
    flexDirection: "row",
  },
  name: {
    // backgroundColor: "white",
    flex: 6.5,
  },
  reps: {
    color: "red",
    alignItems: "center",
    backgroundColor: "pink",
    flex: 1,
  },
});
