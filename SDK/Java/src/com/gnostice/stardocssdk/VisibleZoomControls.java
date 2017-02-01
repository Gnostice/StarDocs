package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleZoomControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleZoomControls(boolean fixedSteps, boolean zoomIn)
	{
		this(fixedSteps, zoomIn, true);
	}

	public VisibleZoomControls(boolean fixedSteps)
	{
		this(fixedSteps, true, true);
	}

	public VisibleZoomControls()
	{
		this(true, true, true);
	}

	public VisibleZoomControls(boolean fixedSteps, boolean zoomIn, boolean zoomOut)
	{
		setFixedSteps(fixedSteps);
		setZoomIn(zoomIn);
		setZoomOut(zoomOut);
	}

	// Properties
	/** 
	 Gets or sets whether the fixed-steps zoom control is visible.
	*/
	private boolean fixedSteps;
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
	private boolean zoomIn;
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
	private boolean zoomOut;
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