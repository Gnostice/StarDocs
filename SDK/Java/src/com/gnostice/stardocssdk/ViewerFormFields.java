package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerFormFields
{
	// Properties
	private boolean enableFormFilling = true;
	private Color formFieldHighlightColor = new Color(204, 215, 255, 50);
	private Color formFieldReadonlyColor = new Color(246, 246, 246, 50);
	private Color formFieldFocusColor = null;
	private boolean allowJavaScriptExecution = false;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public ViewerFormFields()
	{
	}

	/** 
	 Gets or sets whether form filling is enabled.
	*/
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
	public final Color getFormFieldHighlightColor()
	{
		return formFieldHighlightColor;
	}
	public final void setFormFieldHighlightColor(Color value)
	{
		formFieldHighlightColor = value;
	}

	public final Color getFormFieldReadonlyColor()
	{
		return formFieldReadonlyColor;
	}
	public final void setFormFieldReadonlyColor(Color value)
	{
		formFieldReadonlyColor = value;
	}

	public final Color getFormFieldFocusColor()
	{
		return formFieldFocusColor;
	}
	public final void setFormFieldFocusColor(Color value)
	{
		formFieldFocusColor = value;
	}

	/** 
	 Gets or sets whether the JavaScript present in the PDF file is allowed to be executed.
	*/
	public final boolean getAllowJavaScriptExecution()
	{
		return allowJavaScriptExecution;
	}
	public final void setAllowJavaScriptExecution(boolean value)
	{
		allowJavaScriptExecution = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjFormFields = new JSONObject();
		jsonObjFormFields.put("enableFormFilling", enableFormFilling);
		jsonObjFormFields.put("formFieldHighlightColor", formFieldHighlightColor.toRGBA());
		jsonObjFormFields.put("formFieldReadonlyColor", formFieldReadonlyColor.toRGBA());
		if (formFieldFocusColor != null)
		{
			jsonObjFormFields.put("formFieldFocusColor", formFieldFocusColor.toRGBA());
		}
		else
		{
			jsonObjFormFields.put("formFieldFocusColor", "");
		}
		jsonObjFormFields.put("allowJavaScriptExecution", allowJavaScriptExecution);
		jsonObj.put("formFields", jsonObjFormFields);
	}
}
