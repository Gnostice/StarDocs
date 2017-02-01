package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerSettings
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerSettings()
	{
		this(true);
	}

	public ViewerSettings(boolean toolbarVisible)
	{
		this(toolbarVisible, false);
	}

	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible)
	{
		this(toolbarVisible, fullScreenVisible, null);
	}

	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, null);
	}
	
	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, null);
	}

	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls, VisibleZoomControls visibleZoomControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, visibleZoomControls, null);
	}
	
	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls, VisibleZoomControls visibleZoomControls, VisibleRotationControls visibleRotationControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, visibleZoomControls, visibleRotationControls, null);
	}
	
	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls, VisibleZoomControls visibleZoomControls, VisibleRotationControls visibleRotationControls, VisibleColorInversionControls visibleColorInversionControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, visibleZoomControls, visibleRotationControls, visibleColorInversionControls, null);
	}

	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls, VisibleZoomControls visibleZoomControls, VisibleRotationControls visibleRotationControls, VisibleColorInversionControls visibleColorInversionControls, SearchControls searchControls)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, visibleZoomControls, visibleRotationControls, visibleColorInversionControls, searchControls, null);
	}
	
	public ViewerSettings(boolean toolbarVisible, boolean fullScreenVisible, VisibleFileOperationControls visibleFileOperationControls, VisibleNavigationControls visibleNavigationControls, VisibleZoomControls visibleZoomControls, VisibleRotationControls visibleRotationControls, VisibleColorInversionControls visibleColorInversionControls, SearchControls searchControls, ViewerNavigationPane navigationPane)
	{
		this(toolbarVisible, fullScreenVisible, visibleFileOperationControls, visibleNavigationControls, visibleZoomControls, visibleRotationControls, visibleColorInversionControls, searchControls, navigationPane, null);
	}

	public ViewerSettings(boolean _toolbarVisible, boolean _fullScreenVisible, 
			VisibleFileOperationControls _visibleFileOperationControls, 
			VisibleNavigationControls _visibleNavigationControls, 
			VisibleZoomControls _visibleZoomControls, 
			VisibleRotationControls _visibleRotationControls, 
			VisibleColorInversionControls _visibleColorInversionControls, 
			SearchControls _searchControls,
			ViewerNavigationPane _navigationPane,
			ViewerInteractiveElements _interactiveElements)
	{
		toolbarVisible = _toolbarVisible;
		fullScreenVisible = _fullScreenVisible;
		visibleFileOperationControls = (_visibleFileOperationControls != null) ? _visibleFileOperationControls : new VisibleFileOperationControls();
		visibleNavigationControls = (_visibleNavigationControls != null)? _visibleNavigationControls : new VisibleNavigationControls();
		visibleZoomControls = (_visibleZoomControls != null) ? _visibleZoomControls : new VisibleZoomControls();
		visibleRotationControls = (_visibleRotationControls != null) ? _visibleRotationControls : new VisibleRotationControls();
		visibleColorInversionControls = (_visibleColorInversionControls != null) ? _visibleColorInversionControls : new VisibleColorInversionControls();
		searchControls = (_searchControls != null) ? _searchControls : new SearchControls();
		navigationPane = (_navigationPane != null) ? _navigationPane : new ViewerNavigationPane();
		interactiveElements = (_interactiveElements != null) ? _interactiveElements : new ViewerInteractiveElements();
	}

	// Properties

	/** 
	 Gets or sets whether the toolbar is visible.
	*/
	private boolean toolbarVisible;
	public final void setToolbarVisible(boolean value)
	{
		toolbarVisible = value;
	}

	/** 
	 Gets or sets whether the full-screen popup control is visible.
	*/
	private boolean fullScreenVisible;
	public final void setFullScreenVisible(boolean value)
	{
		fullScreenVisible = value;
	}
	
	/** 
	 Gets or sets which file operation controls should be visible.
	*/
	private VisibleFileOperationControls visibleFileOperationControls;
	public final VisibleFileOperationControls getVisibleFileOperationControls()
	{
		return visibleFileOperationControls;
	}
	
	/** 
	 Gets or sets which navigation controls should be visible.
	*/
	private VisibleNavigationControls visibleNavigationControls;
	public final VisibleNavigationControls getVisibleNavigationControls()
	{
		return visibleNavigationControls;
	}
	
	/** 
	 Gets or sets which zoom controls should be visible.
	*/
	private VisibleZoomControls visibleZoomControls;
	public final VisibleZoomControls getVisibleZoomControls()
	{
		return visibleZoomControls;
	}
	
	/** 
	 Gets or sets which rotation controls should be visible.
	*/
	private VisibleRotationControls visibleRotationControls;
	public final VisibleRotationControls getVisibleRotationControls()
	{
		return visibleRotationControls;
	}

	/** 
	 Gets or sets which color inversion controls should be visible.
	*/
	private VisibleColorInversionControls visibleColorInversionControls;
	public final VisibleColorInversionControls getVisibleColorInversionControls()
	{
		return visibleColorInversionControls;
	}

	/** 
	 Gets or sets whether the quick search control should be visible.
	*/
	private SearchControls searchControls;
	public final SearchControls getSearchControls()
	{
		return searchControls;
	}

	/** 
	 Gets or sets settings related to navigation pane.
	*/
	private ViewerNavigationPane navigationPane;
	public final ViewerNavigationPane getNavigationPane()
	{
		return navigationPane;
	}

	/** 
	 Gets or sets settings related to interactive elements.
	*/
	private ViewerInteractiveElements interactiveElements;
	public final ViewerInteractiveElements getInteractiveElements()
	{
		return interactiveElements;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjViewerSettings = new JSONObject();
		jsonObjViewerSettings.put("toolbarVisible", toolbarVisible);
		jsonObjViewerSettings.put("fullScreenVisible", fullScreenVisible);
		visibleFileOperationControls.EncodeJson(jsonObjViewerSettings);
		visibleNavigationControls.EncodeJson(jsonObjViewerSettings);
		visibleZoomControls.EncodeJson(jsonObjViewerSettings);
		visibleRotationControls.EncodeJson(jsonObjViewerSettings);
		visibleColorInversionControls.EncodeJson(jsonObjViewerSettings);
		searchControls.EncodeJson(jsonObjViewerSettings);
		navigationPane.EncodeJson(jsonObjViewerSettings);
		interactiveElements.EncodeJson(jsonObjViewerSettings);
		jsonObj.put("viewerSettings", jsonObjViewerSettings);
	}
}