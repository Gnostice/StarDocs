package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerSettings
{
	// Properties
	private boolean toolbarVisible = true;
	private boolean fullScreenVisible = true;
	private ViewerInitialView initialView = new ViewerInitialView();
	private VisibleFileOperationControls visibleFileOperationControls = new VisibleFileOperationControls();
	private VisibleNavigationControls visibleNavigationControls = new VisibleNavigationControls();
	private VisibleZoomControls visibleZoomControls = new VisibleZoomControls();
	private VisibleRotationControls visibleRotationControls = new VisibleRotationControls();
	private VisibleColorInversionControls visibleColorInversionControls = new VisibleColorInversionControls();
	private Search search = new Search();
	private ViewerNavigationPane navigationPane = new ViewerNavigationPane();
	private ViewerInteractiveElements interactiveElements = new ViewerInteractiveElements();

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerSettings()
	{
	}

	/** 
	 Gets or sets whether the toolbar is visible.
	*/
	public final void setToolbarVisible(boolean value)
	{
		toolbarVisible = value;
	}
	public final boolean getToolbarVisible()
	{
		return toolbarVisible;
	}

	/** 
	 Gets or sets whether the full-screen popup control is visible.
	*/
	public final void setFullScreenVisible(boolean value)
	{
		fullScreenVisible = value;
	}
	public final boolean getFullScreenVisible()
	{
		return fullScreenVisible;
	}

	public final ViewerInitialView getInitialView()
	{
		return initialView;
	}

	/** 
	 Gets or sets which file operation controls should be visible.
	*/
	public final VisibleFileOperationControls getVisibleFileOperationControls()
	{
		return visibleFileOperationControls;
	}
	
	/** 
	 Gets or sets which navigation controls should be visible.
	*/
	public final VisibleNavigationControls getVisibleNavigationControls()
	{
		return visibleNavigationControls;
	}
	
	/** 
	 Gets or sets which zoom controls should be visible.
	*/
	public final VisibleZoomControls getVisibleZoomControls()
	{
		return visibleZoomControls;
	}
	
	/** 
	 Gets or sets which rotation controls should be visible.
	*/
	public final VisibleRotationControls getVisibleRotationControls()
	{
		return visibleRotationControls;
	}

	/** 
	 Gets or sets which color inversion controls should be visible.
	*/
	public final VisibleColorInversionControls getVisibleColorInversionControls()
	{
		return visibleColorInversionControls;
	}

	/** 
	 Gets or sets whether the quick search control should be visible.
	*/
	public final Search getSearchControls()
	{
		return search;
	}

	/** 
	 Gets or sets settings related to navigation pane.
	*/
	public final ViewerNavigationPane getNavigationPane()
	{
		return navigationPane;
	}

	/** 
	 Gets or sets settings related to interactive elements.
	*/
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
		initialView.EncodeJson(jsonObjViewerSettings);
		visibleFileOperationControls.EncodeJson(jsonObjViewerSettings);
		visibleNavigationControls.EncodeJson(jsonObjViewerSettings);
		visibleZoomControls.EncodeJson(jsonObjViewerSettings);
		visibleRotationControls.EncodeJson(jsonObjViewerSettings);
		visibleColorInversionControls.EncodeJson(jsonObjViewerSettings);
		search.EncodeJson(jsonObjViewerSettings);
		navigationPane.EncodeJson(jsonObjViewerSettings);
		interactiveElements.EncodeJson(jsonObjViewerSettings);
		jsonObj.put("viewerSettings", jsonObjViewerSettings);
	}
}