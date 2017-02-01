package com.gnostice.stardocssdk;

import java.net.URISyntaxException;

public class Viewer
{
	// Fields
	public ViewerInt viewerInt;

	// Ctors
	public Viewer(StarDocs starDocs)
	{
		viewerInt = new ViewerInt(starDocs);
	}

	// Properties

	// Methods

	public final ViewResponse createView(FileObject file) throws StarDocsException, URISyntaxException
	{
		return createView(file, null, null, null);
	}

	public final ViewResponse createView(FileObject file, String password) throws StarDocsException, URISyntaxException
	{
		return createView(file, password, null, null);
	}

	public final ViewResponse createView(FileObject file, String password, ViewerSettings viewerSettings) throws StarDocsException, URISyntaxException
	{
		return viewerInt.createView(file, password, viewerSettings, null);
	}

	public final ViewResponse createView(FileObject file, String password, ViewerSettings viewerSettings, Integer timeToLiveSecs) throws StarDocsException, URISyntaxException
	{
		return viewerInt.createView(file, password, viewerSettings, timeToLiveSecs);
	}

	public final void deleteView(ViewResponse viewResponse) throws StarDocsException
	{
		viewerInt.deleteView(viewResponse);
	}
}