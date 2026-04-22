#!/bin/bash
cat << 'INNER_EOF' > /tmp/conflict2.patch
--- src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
+++ src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java
@@ -102,12 +102,9 @@
             mUserPreferences.getAIPreference().setSystemHealthAdvisorEnabled(newValue);
         });

-<<<<<<< HEAD
         Label systemHealthExplanationLabel = new Label("If turned on, a background AI agent will monitor system metrics and suggest configuration optimizations.");
         systemHealthExplanationLabel.setWrapText(true);
         VBox systemHealthBox = new VBox(5, enableSystemHealthSwitch, systemHealthExplanationLabel);

-        VBox settingsBox = new VBox(10, explanationLabel, apiKeyBox, apiKeyLink, systemHealthBox);
-=======
-        VBox settingsBox = new VBox(10, explanationLabel, enableLogAnalysisSwitch, logExplanationLabel, apiKeyBox, apiKeyLink);
->>>>>>> origin/master
+        VBox settingsBox = new VBox(10, explanationLabel, enableLogAnalysisSwitch, logExplanationLabel, apiKeyBox, apiKeyLink, systemHealthBox);
         settingsBox.visibleProperty().bind(enableAiSwitch.selectedProperty());
         settingsBox.managedProperty().bind(enableAiSwitch.selectedProperty());
INNER_EOF
patch src/main/java/io/github/dsheirer/gui/preference/ai/AIPreferenceEditor.java < /tmp/conflict2.patch
