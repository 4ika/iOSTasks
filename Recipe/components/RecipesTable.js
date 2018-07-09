import React from "react";
import {
  View,
  StyleSheet,
  FlatList,
  Text,
  TouchableOpacity,
  Image
} from "react-native";
import Button from "./Button";
import { Mutation } from "react-apollo";
import gql from "graphql-tag";

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
  };

  addFavorite = gql`
    mutation addFavorite($recipeId : ID! , $userId : ID!){
      addToUserOnRecipe1(favoritesRecipeId : $recipeId, usersFavoriteUserId: $userId) {
        usersFavoriteUser{email}
        favoritesRecipe{title}
      }
    }
`;

  handleAddRecipeOnPress = () => {
    this.props.nav.navigate("AddRecipe");
  };

  handlePressToFavorites = () => {
    this.props.nav.navigate("Favorites", { user: this.props.user });
  }



  handleRefresh = () => {
    console.log("Refresh");
    this.setState({ isFetching: true }, function () {
      this.props.onRefresh();
      this.setState({ isFetching: false });
    });
  };

  renderItem = (item) => {
    return (
      <Mutation mutation={this.addFavorite}>
        {(addToUserOnRecipe1) => (
          <TouchableOpacity onPress={() => {
            addToUserOnRecipe1({
              variables: {
                recipeId: item.id,
                userId: this.props.user.id
              }
            });
            this.props.onPress(item)
          }}>
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
        )
        }
      </Mutation>
    );
  };

  render() {
    return (
      <View style={{ flex: 1 }}>
        <View style={{ flex: 8 }}>
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
        <View style={{ flex: 2, flexDirection: 'column' }}>
          <Button
            font={15}
            title={"Add new recipe"}
            onPress={this.handleAddRecipeOnPress}
          />
          <Button
            font={15}
            title={"Favorite"}
            onPress={this.handlePressToFavorites}
          />
        </View>
      </View>
    );
  }
}
