import React from "react";
import { View, StyleSheet, ActivityIndicator, ScrollView, TouchableOpacity, Text } from "react-native";
import RecipesTable from "../components/RecipesTable";
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
  },
  signOutText: {
    marginRight: 15,
    color: "white"
  }
});

const GET_ALL_RECIPES = gql`
{
  allRecipes {
    id
    title
    description
    instructions
  }
}
`;

export default class Recipes extends React.Component {
  static navigationOptions = ({ navigation }) => ({
    title: "Recipe",
    headerTintColor: "white",
    headerStyle: {
      backgroundColor: "#169688"
    },
    headerLeft: null,
    headerRight: (
      <TouchableOpacity
        onPress={() => {
          navigation.goBack()
        }}
      >
        <Text style={styles.signOutText}>SignOut</Text>
      </TouchableOpacity>
    )

  });


  handleOnChangeToDetailOfRecipe = item => {
    this.props.navigation.navigate("DetailOfRecipe", { recipe: item });
  };

  user = this.props.navigation.getParam("user", 'NO_USER')

  render() {
    return (
      <Query query={GET_ALL_RECIPES}>
        {({ loading, data, refetch }) =>
          (
            loading ? (
              <ActivityIndicator />
            ) : (
                <View style={styles.container}>
                  <RecipesTable
                    onPress={this.handleOnChangeToDetailOfRecipe}
                    data={data.allRecipes}
                    nav={this.props.navigation}
                    user={this.user}
                    onRefresh={refetch}
                  />
                </View>
              )
          )
        }
      </Query>
    );
  }
}
