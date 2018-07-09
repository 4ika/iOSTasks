import React from "react";
import { View, StyleSheet, TouchableOpacity } from "react-native";
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
})

const SIGN_UP = gql`
  mutation addUser($email: String!,$password: String!) {
    createUser(authProvider:{ email:{email: $email, password: $password}}) {
      email
      password
    }
  }
`

export default class SignUp extends React.Component {

  state = {
    email: '',
    password: '',
  }

  static navigationOptions = ({ navigation }) => ({
    title: "Sign-Up",
    headerTintColor: "white",
    headerStyle: {
      backgroundColor: "#169688"
    }
  });

  onChangeTextEmail = (text) => {
    this.setState({ email: text })
  }

  onChangeTextPass = (text) => {
    this.setState({ password: text })
  }

  storeData = async (email, id) => {
    try {
      await AsyncStorage.setItem('user', [email, id]);
    } catch (error) { }
  }

  render() {

    return (
      <Mutation mutation={SIGN_UP}>
        {(createUser) => (
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
            <Button font={17} title={'Sign-Up'} onPress={() => {
              createUser({
                variables: {
                  email: this.state.email,
                  password: this.state.password
                }
              })
              this.navigation.navigate('SignIn')
            }}
            />
          </View>
        )}
      </Mutation>
    );
  }
}