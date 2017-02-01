package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleRotationControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleRotationControls(boolean clockwise)
	{
		this(clockwise, true);
	}

	public VisibleRotationControls()
	{
		this(true, true);
	}

	public VisibleRotationControls(boolean clockwise, boolean counterClockwise)
	{
		setClockwise(clockwise);
		setCounterClockwise(counterClockwise);
	}

	// Properties
	/** 
	 Gets or sets whether the clockwise rotation control is visible.
	*/
	private boolean clockwise;
	public final boolean getClockwise()
	{
		return clockwise;
	}
	public final void setClockwise(boolean value)
	{
		clockwise = value;
	}
	
	/** 
	 Gets or sets whether the counter-clockwise rotation control is visible.
	*/
	private boolean counterClockwise;
	public final boolean getCounterClockwise()
	{
		return counterClockwise;
	}
	public final void setCounterClockwise(boolean value)
	{
		counterClockwise = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjVisibleRotationControls = new JSONObject();
		jsonObjVisibleRotationControls.put("clockwise", getClockwise());
		jsonObjVisibleRotationControls.put("counterClockwise", getCounterClockwise());
		jsonObj.put("visibleRotationControls", jsonObjVisibleRotationControls);
	}
}