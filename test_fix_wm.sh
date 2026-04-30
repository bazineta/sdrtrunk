cat << 'INNER_EOF' > patch_wm.diff
--- src/main/java/io/github/dsheirer/gui/JavaFxWindowManager.java
+++ src/main/java/io/github/dsheirer/gui/JavaFxWindowManager.java
@@ -134,16 +134,13 @@
      * @param resourceMonitor for statistics
      * @return JFXPanel accessible on Swing thread that delegates JavaFX scene creation to the FX event thread.
      */
-    public JFXPanel getStatusPanel(ResourceMonitor resourceMonitor)
+    public JFXPanel createStatusPanel(ResourceMonitor resourceMonitor)
     {
-        if(mStatusPanel == null)
-        {
-            mStatusPanel = new JFXPanel();
-            mStatusPanel.setPreferredSize(new java.awt.Dimension(0, 30));
+        JFXPanel panel = new JFXPanel();
+        panel.setPreferredSize(new java.awt.Dimension(0, 30));

-            //JFXPanel has to be populated on the FX event thread
-            Platform.runLater(() -> {
-                Scene scene = new Scene(new StatusBox(resourceMonitor));
-                mStatusPanel.setScene(scene);
-            });
-        }
-
-        return mStatusPanel;
+        //JFXPanel has to be populated on the FX event thread
+        Platform.runLater(() -> {
+            Scene scene = new Scene(new StatusBox(resourceMonitor));
+            panel.setScene(scene);
+        });
+        return panel;
     }

     private void setup()
INNER_EOF
patch -p0 < patch_wm.diff

cat << 'INNER_EOF' > patch_sdrtrunk.diff
--- src/main/java/io/github/dsheirer/gui/SDRTrunk.java
+++ src/main/java/io/github/dsheirer/gui/SDRTrunk.java
@@ -126,7 +126,7 @@
             mTopContentPanel.add(mSpectralPanel, BorderLayout.CENTER);
         }
         if (mCurrentViewId != null && mCurrentViewId.equals("now_playing")) {
-            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());
+            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
             mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
         }
         mMainContentPanel.revalidate();
@@ -467,7 +467,8 @@
     private TwoToneLog mTwoToneLog;
     private ResourceMonitor mResourceMonitor;
     private Rectangle mNormalBounds;
-    private JFXPanel mResourceStatusPanel;
+    private JFXPanel mControllerResourceStatusPanel;
+    private JFXPanel mNowPlayingResourceStatusPanel;

     private String mTitle;

@@ -495,12 +496,15 @@
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

@@ -567,18 +571,6 @@
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
@@ -788,7 +780,7 @@
             mTopContentPanel.remove(mSpectralPanel);
             mControllerPanel.setResourcePanelVisible(false);
             // Pass null for spectrum if disabled
-            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());
+            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
             mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
         } else if (id.equals("tuners") && !mSpectrumDisabled) {
             mTopContentPanel.add(mSpectralPanel, BorderLayout.CENTER);
INNER_EOF
patch -p0 < patch_sdrtrunk.diff

cat << 'INNER_EOF' > patch_controller.diff
--- src/main/java/io/github/dsheirer/controller/ControllerPanel.java
+++ src/main/java/io/github/dsheirer/controller/ControllerPanel.java
@@ -124,14 +124,12 @@
     }

     public void setResourcePanel(javax.swing.JComponent resourcePanel) {
         mResourcePanel = resourcePanel;
+        add(mResourcePanel, BorderLayout.SOUTH);
+        mResourcePanel.setVisible(false);
     }

     public void setResourcePanelVisible(boolean visible) {
         if (mResourcePanel != null) {
-            if (visible) {
-                add(mResourcePanel, BorderLayout.SOUTH);
-            } else {
-                remove(mResourcePanel);
-            }
+            mResourcePanel.setVisible(visible);
             revalidate();
             repaint();
         }
INNER_EOF
patch -p0 < patch_controller.diff

./gradlew clean classes
