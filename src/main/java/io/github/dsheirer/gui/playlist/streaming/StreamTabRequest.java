package io.github.dsheirer.gui.playlist.streaming;

import io.github.dsheirer.gui.playlist.PlaylistEditorRequest;

public abstract class StreamTabRequest extends PlaylistEditorRequest
{
    @Override
    public TabName getTabName()
    {
        return TabName.STREAM;
    }
}
