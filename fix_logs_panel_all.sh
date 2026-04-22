#!/bin/bash
cat << 'INNER_EOF' > /tmp/logspanel_all.diff
--- src/main/java/io/github/dsheirer/gui/LogsPanel.java
+++ src/main/java/io/github/dsheirer/gui/LogsPanel.java
@@ -82,6 +82,16 @@
         mEventSearchField = createSearchField(mEventSorter);
         mTwoToneSearchField = createSearchField(mTwoToneSorter);

+<<<<<<< HEAD
+        mTabbedPane = new JTabbedPane();
+        if (mUserPreferences.getAIPreference().isAIEnabled() && mUserPreferences.getAIPreference().isSystemHealthAdvisorEnabled()) {
+            JPanel performancePanel = new JPanel(new BorderLayout());
+            JLabel performanceLabel = new JLabel("<html><div style='text-align: center; padding: 20px;'><h1>System Health & Performance Advisor</h1><p>Status: Monitoring...</p><p>CPU Usage: OK</p><p>Memory Usage: OK</p><br><p><i>Optimization Suggestions:</i></p><p>No suggestions at this time.</p></div></html>");
+            performanceLabel.setHorizontalAlignment(SwingConstants.CENTER);
+            performancePanel.add(performanceLabel, BorderLayout.CENTER);
+            mTabbedPane.addTab("System Health", performancePanel);
+
+            mHealthTimer = new java.util.Timer(true);
+            mHealthTimer.scheduleAtFixedRate(new SystemHealthAdvisorTask(performanceLabel), 0, 5000);
+        }
+=======
+>>>>>>> origin/master
INNER_EOF
patch src/main/java/io/github/dsheirer/gui/LogsPanel.java < /tmp/logspanel_all.diff
