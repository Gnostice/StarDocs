package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerFormFields
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerFormFields()
	{
		this(true);
	}

	public ViewerFormFields(boolean enableFormFilling)
	{
		this(enableFormFilling, new Color(204, 215, 255, 50));
	}

	public ViewerFormFields(boolean enableFormFilling, Color highlightColor)
	{
		this.setEnableFormFilling(enableFormFilling);
		this.setHighlightColor(highlightColor);
	}

	// Properties
	/** 
	 Gets or sets whether form filling is enabled.
	*/
	private boolean enableFormFilling;
	public final boolean getEnableFormFilling()
	{
		return enableFormFilling;
	}
	public final void setEnableFormFilling(boolean value)
	{
		enableFormFilling = value;
	}
	/** 
	 Gets or sets the form field fill area highlight color.
	*/
	private Color highlightColor;
	public final Color getHighlightColor()
	{
		return highlightColor;
	}
	public final void setHighlightColor(Color value)
	{
		highlightColor = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjFormFields = new JSONObject();
		jsonObjFormFields.put("enableFormFilling", enableFormFilling);
		jsonObjFormFields.put("highlightColor", highlightColor.toHexString());
		jsonObj.put("formFields", jsonObjFormFields);
	}
}
