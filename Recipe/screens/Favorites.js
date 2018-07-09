import React from "react";
import { View, StyleSheet, ScrollView, TouchableOpacity, Text, ActivityIndicator } from "react-native";
import FavoritesTable from "../components/FavoritesTable";
import { Query } from "react-apollo";
import gql from "graphql-tag";



const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white"
  },
  scrollView: {
    backgroundColor: "white"
  },
  favoritText: {
    marginRight: 15,
    color: "white"
  }
});

export default class Favorites extends React.Component {
  static navigationOptions = ({ navigation }) => ({
    title: "Favorites",
    headerTintColor: "white",
    headerStyle: {
      backgroundColor: "#169688"
    },
  });

  handleOnChangeToDetailOfRecipe = item => {
    this.props.navigation.navigate("DetailOfRecipe", { recipe: item });
  };

  user = this.props.navigation.getParam("user", 'default')

  USER = gql`
    {
        User(email: "${this.user.email}", id: "${this.user.id}") {
          favorites{
            description
            image
            ingredients           
            instructions
            title
          }
        }
    }
  `;
  render() {

    return (
      <Query query={this.USER}>
        {({ loading, data, refetch }) => (
          (
            loading ? (
              <ActivityIndicator />
            ) : (
                <View style={styles.container}>
                  <FavoritesTable
                    onPress={this.handleOnChangeToDetailOfRecipe}
                    data={data.User.favorites}
                    update={refetch}
                  />
                </View>
              )
          )
        )}
      </Query>
    )
  }
}
