package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerInitialView 
{
	// Properties
	private PageZoomMode zoomMode = PageZoomMode.FitWidth;
	private PageRotationAngle rotationAngle = PageRotationAngle.Zero;
	private boolean colorInversionApplied = false;
	private boolean navigationPaneOpened = false;

	// Ctors
	public ViewerInitialView()
	{
	}

	// Methods
	public PageZoomMode getZoomMode() 
	{
		return zoomMode;
	}

	public void setZoomMode(PageZoomMode zoomMode) 
	{
		this.zoomMode = zoomMode;
	}

	public PageRotationAngle getRotationAngle() 
	{
		return rotationAngle;
	}

	public void setRotationAngle(PageRotationAngle rotationAngle) 
	{
		this.rotationAngle = rotationAngle;
	}

	public boolean isColorInversionApplied() 
	{
		return colorInversionApplied;
	}

	public void setColorInversionApplied(boolean colorInversionApplied) 
	{
		this.colorInversionApplied = colorInversionApplied;
	}

	public boolean isNavigationPaneOpened() 
	{
		return navigationPaneOpened;
	}

	public void setNavigationPaneOpened(boolean navigationPaneOpened) 
	{
		this.navigationPaneOpened = navigationPaneOpened;
	}

	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjFormFields = new JSONObject();
		jsonObjFormFields.put("zoomMode", Utils.toCamelCase(zoomMode.name()));
		jsonObjFormFields.put("rotation", Utils.toCamelCase(rotationAngle.name()));
		jsonObjFormFields.put("colorInversionApplied", colorInversionApplied);
		jsonObjFormFields.put("navigationPaneOpened", navigationPaneOpened);
		jsonObj.put("formFields", jsonObjFormFields);
	}
}
