import React from "react";
import { View, StyleSheet, FlatList, Text, Dimensions } from "react-native";
import HeaderView from "./HeaderView";

const SCREEN_SIZE = Dimensions.get("window");

const styles = StyleSheet.create({
  itemContainer: {
    flex: 1,
    height: "auto",
    paddingLeft: 15,
    backgroundColor: "#169688",
    borderRadius: 8,
    marginTop: 5
  },
  textContainer: {
    flex: 1
  },

  text: {
    fontSize: 20,
    marginHorizontal: 10,
    marginVertical: 10
  },

  tableContainer: {
    width: SCREEN_SIZE.width * 0.95,
    marginTop: 15
  }
});

export default class InstructionTable extends React.Component {
  renderItem = (item, index) => {
    console.log("sdfsdf", item, index);
    return (
      <View style={styles.itemContainer}>
        <View style={styles.textContainer}>
          <Text style={styles.text}>{item}</Text>
        </View>
      </View>
    );
  };

  render() {
    console.log("render", this.props.data);
    return (
      <FlatList
        style={styles.tableContainer}
        data={this.props.data}
        renderItem={({ item, index }) => this.renderItem(item, index)}
        keyExtractor={({ index }) => index}
        scrollEnabled={false}
        ListHeaderComponent={() => <HeaderView title="Instructions" />}
      />
    );
  }
}
