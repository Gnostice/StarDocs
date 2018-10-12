package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerNavigationPane 
{
	// Properties
	private boolean visible = true;
	private boolean enableBookmarks = true;
	private boolean enableThumbnails = true;
	private NavigationPanePosition position = NavigationPanePosition.Auto;
	private int width = 200;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public ViewerNavigationPane()
	{
	}

	/** 
	 Gets or sets whether the navigation pane should be shown.
	*/
	public final boolean getVisible()
	{
		return visible;
	}
	public final void setVisible(boolean value)
	{
		visible = value;
	}
	
	/** 
	 Gets or sets whether bookmark-based navigation should be enabled.
	*/
	public final boolean getEnableBookmarks()
	{
		return enableBookmarks;
	}
	public final void setEnableBookmarks(boolean value)
	{
		enableBookmarks = value;
	}

	/** 
	 Gets or sets whether thumbnail-based navigation should be enabled.
	*/
	public final boolean getEnableThumbnails()
	{
		return enableThumbnails;
	}
	public final void setEnableThumbnails(boolean value)
	{
		enableThumbnails = value;
	}

	/** 
	 Gets or sets the positioning of the navigation pane.
	*/
	public final NavigationPanePosition getPosition()
	{
		return position;
	}
	public final void setPosition(NavigationPanePosition value)
	{
		position = value;
	}

	/** 
	 Gets or sets the width (in pixels) of the navigation pane.
	*/
	public final int getWidth()
	{
		return width;
	}
	public final void setWidth(int value)
	{
		width = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjNavigationPane = new JSONObject();
		jsonObjNavigationPane.put("visible", visible);
		jsonObjNavigationPane.put("enableBookmarks", enableBookmarks);
		jsonObjNavigationPane.put("enableThumbnails", enableThumbnails);
		jsonObjNavigationPane.put("position", Utils.toCamelCase(position.name()));
		jsonObjNavigationPane.put("width", width);
		jsonObj.put("navigationPane", jsonObjNavigationPane);
	}
}
