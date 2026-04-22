#!/bin/bash
cat << 'INNER_EOF' > /tmp/logs.patch
--- src/main/java/io/github/dsheirer/gui/LogsPanel.java
+++ src/main/java/io/github/dsheirer/gui/LogsPanel.java
@@ -27,6 +27,8 @@

 public class LogsPanel extends JPanel {

+    private java.util.Timer mHealthTimer;
+
     private UserPreferences mUserPreferences;

     private LogFileTableModel mAppListModel;
@@ -75,6 +77,16 @@
         mEventSearchField = createSearchField(mEventSorter);
         mTwoToneSearchField = createSearchField(mTwoToneSorter);

         mTabbedPane = new JTabbedPane();
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
         mTabbedPane.addTab("Application Logs", createTabPanel(mAppTable, mAppSearchField));
         mTabbedPane.addTab("Channel Event Logs", createTabPanel(mEventTable, mEventSearchField));
INNER_EOF
patch src/main/java/io/github/dsheirer/gui/LogsPanel.java < /tmp/logs.patch
