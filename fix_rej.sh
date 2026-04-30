cat << 'INNER_EOF' > patch_controller2.diff
--- src/main/java/io/github/dsheirer/controller/ControllerPanel.java
+++ src/main/java/io/github/dsheirer/controller/ControllerPanel.java
@@ -108,16 +108,14 @@

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
     }
INNER_EOF
patch -p0 < patch_controller2.diff

./gradlew clean classes
