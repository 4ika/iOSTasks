import React from "react";
import { View, StyleSheet, TouchableOpacity, Text, AsyncStorage } from "react-native";
import { TextInput } from 'react-native-paper';
import Button from '../components/Button'
import { Mutation } from "react-apollo";
import gql from "graphql-tag";


const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    flexDirection: 'column',
    alignItems: 'center',
  },
  textInput: {
    width: 250,
    marginTop: 30,
  },
  text: {
    marginTop: 20,
  }
})

const SIGN_IN = gql`
  mutation signIn($email: String!,$password: String!) {
    signinUser(email:{email: $email,password: $password}){
      token
      user{
        id
        email
      }
    }
  }
`

export default class SignUp extends React.Component {

  state = {
    email: '',
    password: '',
  }

  static navigationOptions = ({ navigation }) => ({
    title: "Sign-In",
    headerTintColor: "white",
    headerStyle: {
      backgroundColor: "#169688"
    },
    headerLeft: null
  });

  onChangeTextEmail = (text) => {
    this.setState({ email: text })
  }

  onChangeTextPass = (text) => {
    this.setState({ password: text })
  }

  handleSignUp = () => {
    this.props.navigation.navigate("SignUp")
  }

  render() {
    return (
      <Mutation mutation={SIGN_IN}>
        {(signinUser) => (
          <View style={styles.container}>
            <TextInput
              style={styles.textInput}
              theme={{ colors: { primary: '#169688' } }}
              label="Email"
              value={this.state.email}
              onChangeText={this.onChangeTextEmail}
            />

            <TextInput
              style={styles.textInput}
              theme={{ colors: { primary: '#169688' } }}
              label="Password"
              value={this.state.password}
              onChangeText={this.onChangeTextPass}
            />
            <Button font={17} title={'Sign-In'} onPress={() => {
              signinUser({
                variables: {
                  email: this.state.email,
                  password: this.state.password
                }
              }).then((json) => {
                this.props.navigation.navigate('Recipes', { user: json.data.signinUser.user })
              })
            }}
            />
            <TouchableOpacity onPress={this.handleSignUp}>
              <Text style={styles.text}>Don't have an account? Sign up</Text>
            </TouchableOpacity>
          </View>
        )}
      </Mutation>
    );
  }
}