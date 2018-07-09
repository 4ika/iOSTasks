import React from 'react';
import { ImagePicker, Permissions } from 'expo';
import { View, StyleSheet, ScrollView, KeyboardAvoidingView, Alert, Image, TouchableOpacity } from 'react-native';
import { TextInput } from 'react-native-paper';
import { Mutation } from 'react-apollo';
import gql from 'graphql-tag';
import Button from '../components/Button';


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
        alignItems: 'center',
    },
    scrollView: {
        backgroundColor: 'white',
    },
    textInput: {
        width: 250,
        marginTop: 30,
    },
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

    pickImage: {
        width: 150,
        height: 150,
        marginTop: 20,
        borderRadius: 10,
    }
})

const CREATE_RECIPE = gql`
  mutation addRecipe($desc: String!,$image :String!,$ingre: [String!]!, $instr:[String!]!,$title: String!) {
    createRecipe(description:$desc,image : $image,ingredients: $ingre, instructions: $instr , title: $title) {
      description
      image
      ingredients           
      instructions
      title
    }
  }
`;


const FILE_UPLOAD_URL = 'https://api.graph.cool/file/v1/cjj6o65iu268e01971w3dv0s7'

export default class AddRecipe extends React.Component {

    state = {
        name: '',
        description: '',
        ingredient: '',
        ingredients: [],
        instruction: '',
        instructions: [],
        photo: "file:///Users/i/Library/Developer/CoreSimulator/Devices/4A3C5CE6-FBD7-4D06-BA44-E1FDDE6A8523/data/Containers/Data/Application/E7945847-A61D-4FCD-B3D0-76496719153D/Library/Caches/ExponentExperienceData/%2540anonymous%252Frecipe-4757e32b-5b5c-4814-a61c-b4175ead130a/ImagePicker/344018D7-7AAD-41BE-A0C0-86E466063A86.jpg",
    }

    static navigationOptions = ({ navigation }) => ({
        title: "Add new recipe",
        headerTintColor: 'white',
        headerStyle: {
            backgroundColor: '#169688'
        }
    });

    onChangeTextName = (text) => {
        this.setState({ name: text })
    }

    onChangeTextDescription = (text) => {
        this.setState({ description: text })
    }

    onChangeTextInstruction = (text) => {
        this.setState({ instruction: text })
    }

    onChangeTextIngredient = (text) => {
        this.setState({ ingredient: text })
    }

    handleAddInstruction = () => {
        if (this.state.instruction !== '') {
            this.setState({
                instructions: [...this.state.instructions, this.state.instruction],
                instruction: '',
            })
        }
    }

    handleAddIngredient = () => {
        if (this.state.ingredient !== '') {
            this.setState({
                ingredients: [...this.state.ingredients, this.state.ingredient],
                ingredient: '',
            })
        }
    }

    handleOnPickerPress = async () => {
        await Permissions.askAsync(Permissions.CAMERA_ROLL)
        const photo = await ImagePicker.launchImageLibraryAsync();

        this.setState({
            photo: photo.uri,
        })
    }


    render() {
        return (
            <Mutation mutation={CREATE_RECIPE}>
                {(createRecipe, { data, loading, error }) => (
                    <KeyboardAvoidingView
                        behavior="padding"
                        contentContainerStyle={{ flex: 1 }}
                        style={{ flex: 1 }}
                        keyboardVerticalOffset={100}
                    >
                        <ScrollView style={styles.scrollView}>
                            <View style={styles.container}>
                                <TouchableOpacity onPress={this.handleOnPickerPress}>
                                    <Image
                                        source={{ uri: this.state.photo }}
                                        style={styles.pickImage}
                                        r
                                    />
                                </TouchableOpacity>
                                <TextInput
                                    style={styles.textInput}
                                    label="Food name"
                                    value={this.state.name}
                                    onChangeText={this.onChangeTextName}
                                />
                                <TextInput
                                    style={styles.textInput}
                                    label="Description"
                                    value={this.state.description}
                                    onChangeText={this.onChangeTextDescription}
                                />
                                <View>
                                    <TextInput
                                        style={styles.textInput}
                                        label="Ingredient"
                                        value={this.state.ingredient}
                                        onChangeText={this.onChangeTextIngredient}
                                    />
                                    <Button font={20} title={'+'} onPress={this.handleAddIngredient} />
                                </View>
                                <View>
                                    <TextInput
                                        style={styles.textInput}
                                        label="Instruction"
                                        value={this.state.instruction}
                                        onChangeText={this.onChangeTextInstruction}
                                    />
                                    <Button font={20} title={'+'} onPress={this.handleAddInstruction} />
                                </View>
                                <Button font={15} title={'Add new recipe'} onPress={
                                    async () => {
                                        if (
                                            this.state.description.length !== 0 &&
                                            this.state.ingredients.length !== 0 &&
                                            this.state.instructions.length !== 0 &&
                                            this.state.name.length !== 0
                                        ) {

                                            let formatData = new FormData()
                                            formatData.append('data', {
                                                uri: this.state.photo,
                                                name: 'image.png',
                                                type: 'multipart/form-data'
                                            });

                                            try {
                                                const res = await fetch(FILE_UPLOAD_URL, {
                                                    method: 'POST',
                                                    body: formatData
                                                });

                                                const resJson = await res.json()
                                                createRecipe({
                                                    variables: {
                                                        desc: this.state.description,
                                                        image: resJson.url,
                                                        ingre: this.state.ingredients,
                                                        instr: this.state.instructions,
                                                        title: this.state.name,
                                                    }
                                                });
                                                this.props.navigation.goBack()
                                            }
                                            catch (err) { console.log(err) }
                                        }
                                        else {
                                            Alert.alert(
                                                'Error',
                                                'Fill all fields',
                                                [
                                                    { text: 'OK', onPress: () => console.log('OK Pressed') },
                                                ],
                                                { cancelable: false }
                                            )
                                        }
                                    }}
                                />
                            </View>
                        </ScrollView>
                    </KeyboardAvoidingView>
                )}
            </Mutation>
        );
    }
}