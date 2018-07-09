import React from "react";
import {
  View,
  StyleSheet,
  Image,
  Dimensions,
  Text,
  ScrollView,
  TouchableOpacity,
  Share
} from "react-native";
import InstructionTable from "../components/InstructionTable";
import IngredientsTable from "../components/IngredientsTable";

const SCREEN_SIZE = Dimensions.get("window");

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
    alignItems: "center",
    flexDirection: "column"
  },

  image: {
    width: SCREEN_SIZE.width,
    height: 300
  },

  text: {
    fontSize: 20,
    marginHorizontal: 10,
    marginVertical: 10
  },

  nameContainer: {
    height: "auto",
    width: SCREEN_SIZE.width * 0.95,
    backgroundColor: "#169688",
    marginTop: 15,
    borderRadius: 8,
    alignItems: "center",
    justifyContent: "center"
  },

  descContainer: {
    height: "auto",
    width: SCREEN_SIZE.width * 0.95,
    backgroundColor: "#169688",
    marginTop: 15,
    borderRadius: 8,
    alignItems: "center",
    justifyContent: "center"
  },

  shareText: {
    marginRight: 15,
    color: "white"
  }
});

export default class DetailOfRecipe extends React.Component {
  static navigationOptions = ({ navigation }) => ({
    title: "Detail of recipe",
    headerTintColor: "white",
    headerStyle: {
      backgroundColor: "#169688"
    },

    headerRight: (
      <TouchableOpacity
        onPress={() => {
          Share.share({
            message: "efmnlejfbewfe"
          })
            .then(result => console.log(result))
            .catch(errorMsg => console.log(errorMsg));
        }}
      >
        <Text style={styles.shareText}>Share</Text>
      </TouchableOpacity>
    )
  });

  item = this.props.navigation.getParam("recipe", "default");
  render() {
    return (
      <ScrollView>
        <View style={styles.container}>
          <Image style={styles.image} source={{ uri: this.item.image }} />
          <View style={styles.nameContainer}>
            <Text style={styles.text}>{this.item.title}</Text>
          </View>
          <View style={styles.descContainer}>
            <Text style={styles.text}>{this.item.description}</Text>
          </View>
          <IngredientsTable data={this.item.ingredients} />
          <InstructionTable data={this.item.instructions} />
        </View>
      </ScrollView>
    );
  }
}
