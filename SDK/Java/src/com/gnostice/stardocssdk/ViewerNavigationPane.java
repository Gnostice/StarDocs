package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ViewerNavigationPane 
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public ViewerNavigationPane()
	{
		this(true, true, true, NavigationPanePosition.Auto, 200);
	}

	public ViewerNavigationPane(boolean visible)
	{
		this(visible, true, true, NavigationPanePosition.Auto, 200);
	}
	
	public ViewerNavigationPane(boolean visible, boolean enableBookmarks)
	{
		this(visible, enableBookmarks, true, NavigationPanePosition.Auto, 200);
	}
	
	public ViewerNavigationPane(boolean visible, boolean enableBookmarks, boolean enableThumbnails)
	{
		this(visible, enableBookmarks, enableThumbnails, NavigationPanePosition.Auto, 200);
	}

	public ViewerNavigationPane(boolean visible, boolean enableBookmarks, boolean enableThumbnails, NavigationPanePosition position)
	{
		this(visible, enableBookmarks, enableThumbnails, position, 200);
	}

	public ViewerNavigationPane(boolean visible, boolean enableBookmarks, boolean enableThumbnails, NavigationPanePosition position, int width)
	{
		this.setVisible(visible);
		this.setEnableBookmarks(enableBookmarks);
		this.setEnableThumbnails(enableThumbnails);
		this.setPosition(position);
		this.setWidth(width);
	}

	// Properties
	/** 
	 Gets or sets whether the navigation pane should be shown.
	*/
	private boolean visible;
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
	private boolean enableBookmarks;
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
	private boolean enableThumbnails;
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
	private NavigationPanePosition position;
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
	private int width;
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
