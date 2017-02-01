package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerInteractiveElements 
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerInteractiveElements()
	{
		this(null);
	}

	public ViewerInteractiveElements(ViewerFormFields _formFields)
	{
		viewerFormFields = (_formFields != null) ? _formFields : new ViewerFormFields();
	}

	// Properties
	/** 
	 Gets or sets form filling related settings.
	*/
	private ViewerFormFields viewerFormFields;
	public final ViewerFormFields getFormFields()
	{
		return viewerFormFields;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjInteractiveElements = new JSONObject();
		viewerFormFields.EncodeJson(jsonObjInteractiveElements);
		jsonObj.put("interactiveElements", jsonObjInteractiveElements);
	}
}
