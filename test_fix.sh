cat << 'INNER_EOF' > patch_widget.diff
--- src/main/java/io/github/dsheirer/gui/widget/WidgetContainer.java
+++ src/main/java/io/github/dsheirer/gui/widget/WidgetContainer.java
@@ -16,7 +16,7 @@

     public WidgetContainer(NowPlayingPreference preference) {
         mPreference = preference;
-        setLayout(new MigLayout("wrap 1, insets 0, fillx, gapy 2", "[grow,fill]"));
+        setLayout(new MigLayout("wrap 1, insets 0, fillx, hidemode 3, gapy 2", "[grow,fill]"));
     }

     public NowPlayingPreference getPreference() {
@@ -62,9 +62,7 @@
                 add(indicator, "growx, wrap");
             }

-            if (w.isVisible()) {
-                add(w, "growx");
-            }
+            add(w, "growx");
         }

         if (mDraggingWidget != null && mDropIndex == mWidgets.size()) {
@@ -83,7 +81,8 @@
             if (w.getId().equals(id)) {
                 w.setVisible(visible);
                 mPreference.setWidgetVisible(id, visible);
-                rebuildLayout();
+                revalidate();
+                repaint();
                 break;
             }
         }
@@ -101,6 +100,15 @@
         }
     }

+    public void ensureComponentInWidget(String id) {
+        for (Widget w : mWidgets) {
+            if (w.getId().equals(id)) {
+                w.ensureContentComponentParent();
+                break;
+            }
+        }
+    }
+
     private void setupDragAndDrop(Widget widget) {
         JPanel header = widget.getHeaderPanel();

INNER_EOF
patch -p0 < patch_widget.diff

cat << 'INNER_EOF' > patch_widget_class.diff
--- src/main/java/io/github/dsheirer/gui/widget/Widget.java
+++ src/main/java/io/github/dsheirer/gui/widget/Widget.java
@@ -113,6 +113,14 @@
         return mHeaderPanel;
     }

+    public void ensureContentComponentParent() {
+        if (mContentComponent != null && mContentComponent.getParent() != this) {
+            add(mContentComponent, "grow, wrap", 1);
+            revalidate();
+            repaint();
+        }
+    }
+
     public void setDragging(boolean dragging) {
         if (dragging) {
             mHeaderPanel.setBackground(UIManager.getColor("Component.focusColor"));
INNER_EOF
patch -p0 < patch_widget_class.diff

cat << 'INNER_EOF' > patch_nowplaying.diff
--- src/main/java/io/github/dsheirer/channel/metadata/NowPlayingPanel.java
+++ src/main/java/io/github/dsheirer/channel/metadata/NowPlayingPanel.java
@@ -87,11 +87,16 @@
     }

     public void setComponents(javax.swing.JComponent spectralPanel, javax.swing.JComponent broadcastStatusPanel, javax.swing.JComponent resourceStatusPanel) {
+        boolean initialized = (mSpectralPanel != null);
         mSpectralPanel = spectralPanel;
         mBroadcastStatusPanel = broadcastStatusPanel;
         mResourceStatusPanel = resourceStatusPanel;

-        setupWidgets();
+        if (!initialized) {
+            setupWidgets();
+        } else {
+            mWidgetContainer.ensureComponentInWidget("spectrum");
+        }
     }


INNER_EOF
patch -p0 < patch_nowplaying.diff
