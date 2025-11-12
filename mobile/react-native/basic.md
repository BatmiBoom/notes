# Core Components and Native Components

With React Native, you use Javascript to access your platform's APIs as well as to describe the appearance and behavior of your UI using React components: bundles of reusable, nestable code.

## Views and mobile developments

In Android and IOS development, a **view** is the basic building block of UI: a small rectangular element on the screen which can be used to displat text, images, or respond to use input. Even the smallest visual elements of an app, like a line of text or a button, are kinds of views. Some kinds of views can contain other views

```text
Android
------------ ViewGroup ---------------
|                                    |
| ImageView                TextView  |
|     |                       |      |
|     |                       |      |
|     |                       |      |
|     |                       |      |
|     |                       |      |
|     |                       |      |
| UIImageView             UITextView |
|                                    |
---------------- UIView --------------
IOS
```

## Native Components

In Android dev, you write views in Kotlin; in IOS dev, you use Swift. With React Native, you can invoke these views with JavaScript using React Components. At runtime, React Native creates the corresponding Android and IOS views for those components. Because React Native components are backed by the same views as Android and IOS, React Native apps look, feel and perform like any other apps. We call these platform-backed components **NATIVE COMPONENTS**

## Core Components

React Native has many core components for everything from controls to activity indicators. You can find them all documented in the API section. You will mostly work with the following Core Components.

| React Natvice UI Component | Android View | IOS View       | Web Analog          | Description                                 |
| -------------------------- | ------------ | -------------- | ------------------- | ------------------------------------------- |
| <View>                     | <ViewGroup>  | <UIView>       | <div>               | Container that supports layout with flexbox |
| <Text>                     | <TextView>   | <UITextView>   | <p>                 | Display Text and handles touch events       |
| <Image>                    | <ImageView>  | <UIImageView>  | <img>               | Display Images                              |
| <ScrollView>               | <ScrollView> | <UIScrollView> | <div>               | Scrolling Container                         |
| <TextInput>                | <EditText>   | <UiTextField>  | <input type="text"> | User enter Text                             |

```javascript
import React from "react";
import { View, Text, Image, ScrollView, TextInput } from "react-native";

const App = () => {
  return (
    <ScrollView>
      <Text>Some text</Text>
      <View>
        <Text>Some more text</Text>
        <Image
          source={{
            uri: "https://reactnative.dev/docs/assets/p_cat2.png",
          }}
          style={{ width: 200, height: 200 }}
        />
      </View>
      <TextInput
        style={{
          height: 40,
          borderColor: "gray",
          borderWidth: 1,
        }}
        defaultValue="You can type in me"
      />
    </ScrollView>
  );
};

export default App;
```
