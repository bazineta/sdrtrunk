import re

with open('src/main/java/io/github/dsheirer/gui/JavaFxWindowManager.java', 'r') as f:
    content = f.read()

content = content.replace('public JFXPanel getStatusPanel(ResourceMonitor resourceMonitor)', 'public JFXPanel createStatusPanel(ResourceMonitor resourceMonitor)')
content = content.replace('mStatusPanel = new JFXPanel();', 'JFXPanel panel = new JFXPanel();')
content = content.replace('mStatusPanel.setPreferredSize(new java.awt.Dimension(0, 30));', 'panel.setPreferredSize(new java.awt.Dimension(0, 30));')
content = content.replace('mStatusPanel.setScene(scene);', 'panel.setScene(scene);')
content = content.replace('if(mStatusPanel == null)\n        {\n', '')
content = content.replace('        return mStatusPanel;', 'return panel;')
content = content.replace('        }\n\nreturn panel;', 'return panel;')

with open('src/main/java/io/github/dsheirer/gui/JavaFxWindowManager.java', 'w') as f:
    f.write(content)

with open('src/main/java/io/github/dsheirer/gui/SDRTrunk.java', 'r') as f:
    content = f.read()

content = content.replace('private JFXPanel mResourceStatusPanel;', 'private JFXPanel mControllerResourceStatusPanel;\n    private JFXPanel mNowPlayingResourceStatusPanel;')

# In SDRTrunk() constructor
content = content.replace('mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());',
    'mControllerResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);\n        mNowPlayingResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);\n\n        mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);')

content = content.replace('mControllerPanel.setResourcePanel(getResourceStatusPanel());', 'mControllerPanel.setResourcePanel(mControllerResourceStatusPanel);')

# In onItemSelected() and onToggleSpectrum()
content = content.replace('mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), getResourceStatusPanel());', 'mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);')

# Remove getResourceStatusPanel
pattern_to_remove = r"""    /\*\*
     \* Lazy constructor for resource status panel
     \*/
    private JFXPanel getResourceStatusPanel\(\)
    \{

        if\(mResourceStatusPanel == null\)
        \{
            mResourceStatusPanel = mJavaFxWindowManager\.getStatusPanel\(mResourceMonitor\);
        \}

        return mResourceStatusPanel;
    \}"""
content = re.sub(pattern_to_remove, '', content, flags=re.MULTILINE)

with open('src/main/java/io/github/dsheirer/gui/SDRTrunk.java', 'w') as f:
    f.write(content)
