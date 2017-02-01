package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleColorInversionControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleColorInversionControls()
	{
		this(false);
	}

	public VisibleColorInversionControls(boolean allPages)
	{
		this.setAllPages(allPages);
	}

	// Properties
	/** 
	 Gets or sets whether the all-pages color inversion control is visible.
	*/
	private boolean allPages;
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