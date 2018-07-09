import React from 'react';
import { createStackNavigator } from 'react-navigation';
import { ApolloProvider } from "react-apollo";
import ApolloClient from 'apollo-boost';
import { SignIn, SignUp, AddRecipe, Recipes, DetailOfRecipe, Favorites } from './screens'
import { createHttpLink } from 'apollo-link-http';



const AppStackNavigation = createStackNavigator(
  {
    'Recipes': Recipes,
    'DetailOfRecipe': DetailOfRecipe,
    'AddRecipe': AddRecipe,
    'SignIn': SignIn,
    'SignUp': SignUp,
    'Favorites': Favorites,
  },
  {
    initialRouteName: 'SignIn',
  }
)

const client2 = new ApolloClient({
  uri: 'https://api.graph.cool/simple/v1/cjj6o65iu268e01971w3dv0s7'

})


export default class App extends React.Component {

  render() {
    return (
      <ApolloProvider client={client2}>
        <AppStackNavigation />
      </ApolloProvider>
    );
  }
}

