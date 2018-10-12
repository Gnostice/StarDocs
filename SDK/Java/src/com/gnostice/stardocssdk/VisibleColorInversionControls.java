package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleColorInversionControls
{
	// Properties
	private boolean allPages = false;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleColorInversionControls()
	{
	}

	/** 
	 Gets or sets whether the all-pages color inversion control is visible.
	*/
	public final boolean getAllPages()
	{
		return allPages;
	}
	public final void setAllPages(boolean value)
	{
		allPages = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjVisibleColorInversionControls = new JSONObject();
		jsonObjVisibleColorInversionControls.put("allPages", getAllPages());
		jsonObj.put("visibleColorInversionControls", jsonObjVisibleColorInversionControls);
	}
}