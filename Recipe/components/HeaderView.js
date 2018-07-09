import React from 'react';
import {
  Text,
  View,
} from 'react-native';

const styles = {
  header : {
    height : 40,
    backgroundColor : 'white',
    justifyContent : 'flex-end',
    paddingLeft : 15,
  },
  
  text : {
    fontSize : 27,
    color : 'gray'
  }
}

export default class HeaderView extends React.Component{
  render(){
    return(
      <View style = {styles.header}>
        <Text style = {styles.text}>{this.props.title}</Text>
      </View>
    );
  }
}