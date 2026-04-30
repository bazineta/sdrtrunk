cat << 'INNER_EOF' > patch_sdrtrunk_final.diff
--- src/main/java/io/github/dsheirer/gui/SDRTrunk.java
+++ src/main/java/io/github/dsheirer/gui/SDRTrunk.java
@@ -494,13 +494,15 @@
         mBroadcastStatusVisible = mPreferences.getBoolean(PREFERENCE_BROADCAST_STATUS_VISIBLE, false);
         mResourceStatusVisible = mPreferences.getBoolean(PREFERENCE_RESOURCE_STATUS_VISIBLE, true);

-        mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());
+        mControllerResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);
+        mNowPlayingResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);
+
+        mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);

         mMainGui.add(mMainContentPanel, BorderLayout.CENTER);

         mResourceMonitor.start();
-        mControllerPanel.setResourcePanel(getResourceStatusPanel());
+        mControllerPanel.setResourcePanel(mControllerResourceStatusPanel);

     }

@@ -566,18 +568,6 @@
         });
     }

-    /**
-     * Lazy constructor for resource status panel
-     */
-    private JFXPanel getResourceStatusPanel()
-    {
-
-        if(mResourceStatusPanel == null)
-        {
-            mResourceStatusPanel = mJavaFxWindowManager.getStatusPanel(mResourceMonitor);
-        }
-
-        return mResourceStatusPanel;
-    }
-
     /**
      * Toggles visibility of the resource status panel at the bottom of the main UI window
      */
@@ -787,7 +777,7 @@
             mTopContentPanel.remove(mSpectralPanel);
             mControllerPanel.setResourcePanelVisible(false);
             // Pass null for spectrum if disabled
-            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());
+            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
             mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
         } else if (id.equals("tuners") && !mSpectrumDisabled) {
             mTopContentPanel.add(mSpectralPanel, BorderLayout.CENTER);
INNER_EOF
patch -p0 < patch_sdrtrunk_final.diff

./gradlew clean classes
