import React from "react";
import {
  View,
  StyleSheet,
  FlatList,
  Text,
  TouchableOpacity,
  Image
} from "react-native";

const styles = StyleSheet.create({
  itemContainer: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-around",
    height: 100,
    paddingLeft: 15
  },
  textContainer: {
    flex: 1,
    flexDirection: "column",
    paddingHorizontal: 20,
    paddingVertical: 20
  },
  image: {
    width: 90,
    height: 90,
    borderRadius: 5
  },

  descText: {
    marginTop: 5,
    color: "gray"
  }
});

export default class RecipesTable extends React.Component {

  state = {
    isFetching: false
  }

  handleRefresh = () => {
    this.setState({ isFetching: true }, function () {
      this.props.update();
      this.setState({ isFetching: false });
    });
  };

  renderItem = item => {
    return (
      <TouchableOpacity onPress={() => this.props.onPress(item)}>
        <View style={styles.itemContainer}>
          <View style={{ justifyContent: "center" }}>
            <Image style={styles.image} source={{ uri: item.image }} />
          </View>
          <View style={styles.textContainer}>
            <Text>{item.title}</Text>
            <Text style={styles.descText}>{item.description}</Text>
          </View>
        </View>
      </TouchableOpacity>
    );
  };

  render() {
    return (
      <View style={{ flex: 1 }}>
        {this.props.data.length === 0 ? (
          <Text>You haven't any recipe</Text>
        ) : (
            <FlatList
              data={this.props.data}
              renderItem={({ item }) => this.renderItem(item)}
              keyExtractor={({ index }) => index}
              scrollEnabled={true}
              onRefresh={this.handleRefresh}
              refreshing={this.state.isFetching}
            />
          )}
      </View>
    );
  }
}
