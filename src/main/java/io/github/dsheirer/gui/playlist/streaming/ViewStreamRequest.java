package io.github.dsheirer.gui.playlist.streaming;

import io.github.dsheirer.audio.broadcast.BroadcastConfiguration;

public class ViewStreamRequest extends StreamTabRequest
{
    private BroadcastConfiguration mBroadcastConfiguration;

    public ViewStreamRequest(BroadcastConfiguration broadcastConfiguration)
    {
        mBroadcastConfiguration = broadcastConfiguration;
    }

    public BroadcastConfiguration getBroadcastConfiguration()
    {
        return mBroadcastConfiguration;
    }
}
