import re

with open('src/main/java/io/github/dsheirer/gui/SDRTrunk.java', 'r') as f:
    content = f.read()

content = content.replace('''        if (mCurrentViewId != null && mCurrentViewId.equals("now_playing")) {
            mControllerResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);
        mNowPlayingResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);

        mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
            mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
        }''', '''        if (mCurrentViewId != null && mCurrentViewId.equals("now_playing")) {
            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
            mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
        }''')

content = content.replace('''        if (id.equals("now_playing")) {
            mTopContentPanel.remove(mSpectralPanel);
            mControllerPanel.setResourcePanelVisible(false);
            // Pass null for spectrum if disabled
            mControllerResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);
        mNowPlayingResourceStatusPanel = mJavaFxWindowManager.createStatusPanel(mResourceMonitor);

        mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
            mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
        } else if (id.equals("tuners") && !mSpectrumDisabled) {''', '''        if (id.equals("now_playing")) {
            mTopContentPanel.remove(mSpectralPanel);
            mControllerPanel.setResourcePanelVisible(false);
            // Pass null for spectrum if disabled
            mControllerPanel.getNowPlayingPanel().setComponents(mSpectralPanel, getBroadcastStatusPanel(), mNowPlayingResourceStatusPanel);
            mControllerPanel.getNowPlayingPanel().setSpectralPanelVisible(!mSpectrumDisabled);
        } else if (id.equals("tuners") && !mSpectrumDisabled) {''')

with open('src/main/java/io/github/dsheirer/gui/SDRTrunk.java', 'w') as f:
    f.write(content)
