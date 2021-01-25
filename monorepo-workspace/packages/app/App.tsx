import { StyleSheet, Text, View } from "react-native";

import React from "react";

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center"
  }
});

const App = () => {
  return (
    <View style={styles.container}>
      <Text>aa</Text>
    </View>
  );
};

export default App;
