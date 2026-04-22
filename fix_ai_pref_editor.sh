#!/bin/bash
sed -i '/<<<<<<< HEAD/d' src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
sed -i '/VBox settingsBox = new VBox(10, explanationLabel, apiKeyBox, apiKeyLink, systemHealthBox);/d' src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
sed -i '/=======/d' src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
sed -i 's/VBox settingsBox = new VBox(10, explanationLabel, enableLogAnalysisSwitch, logExplanationLabel, apiKeyBox, apiKeyLink);/VBox settingsBox = new VBox(10, explanationLabel, enableLogAnalysisSwitch, logExplanationLabel, apiKeyBox, apiKeyLink, systemHealthBox);/g' src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
sed -i '/>>>>>>> origin\/master/d' src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
