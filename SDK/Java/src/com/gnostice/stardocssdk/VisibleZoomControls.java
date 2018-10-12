package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleZoomControls
{
	// Properties
	private boolean fixedSteps = true;
	private boolean zoomIn = true;
	private boolean zoomOut = true;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public VisibleZoomControls()
	{
	}

	/** 
	 Gets or sets whether the fixed-steps zoom control is visible.
	*/
	public final boolean getFixedSteps()
	{
		return fixedSteps;
	}
	public final void setFixedSteps(boolean value)
	{
		fixedSteps = value;
	}
	
	/** 
	 Gets or sets whether the zoom-in control is visible.
	*/
	public final boolean getZoomIn()
	{
		return zoomIn;
	}
	public final void setZoomIn(boolean value)
	{
		zoomIn = value;
	}
	
	/** 
	 Gets or sets whether the zoom-out control is visible.
	*/
	public final boolean getZoomOut()
	{
		return zoomOut;
	}
	public final void setZoomOut(boolean value)
	{
		zoomOut = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjVisibleZoomControls = new JSONObject();
		jsonObjVisibleZoomControls.put("fixedSteps", getFixedSteps());
		jsonObjVisibleZoomControls.put("zoomIn", getZoomIn());
		jsonObjVisibleZoomControls.put("zoomOut", getZoomOut());
		jsonObj.put("visibleZoomControls", jsonObjVisibleZoomControls);
	}
}