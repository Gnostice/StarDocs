package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerInteractiveElements 
{
	// Properties
	private ViewerFormFields viewerFormFields = new ViewerFormFields();

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerInteractiveElements()
	{
	}

	/** 
	 Gets or sets form filling related settings.
	*/
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
