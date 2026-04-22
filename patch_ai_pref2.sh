#!/bin/bash
cat << 'INNER_EOF' > /tmp/aipref2.diff
--- src/main/java/io/github/dsheirer/preference/ai/AIPreference.java
+++ src/main/java/io/github/dsheirer/preference/ai/AIPreference.java
@@ -53,6 +53,8 @@

     public void setSystemHealthAdvisorEnabled(boolean enabled) {
         mPreferences.putBoolean(KEY_SYSTEM_HEALTH_ENABLED, enabled);
+        notifyPreferenceUpdated();
+    }
     public String getGeminiModel() {
         return mPreferences.get(KEY_GEMINI_MODEL, "models/gemini-1.5-flash");
     }
INNER_EOF
patch src/main/java/io/github/dsheirer/preference/ai/AIPreference.java < /tmp/aipref2.diff
