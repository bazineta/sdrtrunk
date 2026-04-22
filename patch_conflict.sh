#!/bin/bash
cat << 'INNER_EOF' > /tmp/conflict.patch
--- src/main/java/io/github/dsheirer/gui/LogsPanel.java
+++ src/main/java/io/github/dsheirer/gui/LogsPanel.java
@@ -69,18 +69,10 @@
             mHealthTimer = new java.util.Timer(true);
             mHealthTimer.scheduleAtFixedRate(new SystemHealthAdvisorTask(performanceLabel), 0, 5000);
         }
-<<<<<<< HEAD
-        tabbedPane.addTab("Application Logs", createTabPanel(mAppTable, mAppSearchField));
-        tabbedPane.addTab("Channel Event Logs", createTabPanel(mEventTable, mEventSearchField));
-        tabbedPane.addTab("Two-Tone Logs", createTabPanel(mTwoToneTable, mTwoToneSearchField));
-=======
         mTabbedPane = new JTabbedPane();
         mTabbedPane.addTab("Application Logs", createTabPanel(mAppTable, mAppSearchField));
         mTabbedPane.addTab("Channel Event Logs", createTabPanel(mEventTable, mEventSearchField));
         mTabbedPane.addTab("Two-Tone Logs", createTabPanel(mTwoToneTable, mTwoToneSearchField));
->>>>>>> origin/master

         JButton refreshBtn = new JButton("Refresh");
         refreshBtn.addActionListener(e -> loadLogs());
INNER_EOF
patch src/main/java/io/github/dsheirer/gui/LogsPanel.java < /tmp/conflict.patch
