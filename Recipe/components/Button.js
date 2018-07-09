import React from 'react';
import { View, StyleSheet, TouchableOpacity, Text } from 'react-native';

const styles = StyleSheet.create({
    buttonStyle: {
        backgroundColor: '#169688',
        width: 250,
        height: 35,
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 5,
        marginTop: 15,
        marginBottom: 15,
        alignSelf: 'center'
    },
})


export default class Button extends React.Component {
    render() {
        return (
            <TouchableOpacity onPress={this.props.onPress}>
                <View style={styles.buttonStyle}>
                    <Text style={{ fontSize: this.props.font }}>{this.props.title}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}