package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class SearchControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public SearchControls(boolean enableQuickSearch)
	{
		this(enableQuickSearch, null);
	}

	public SearchControls()
	{
		this(true, null);
	}

	public SearchControls(boolean enableQuickSearch, Color highlightColor)
	{
		setEnableQuickSearch(enableQuickSearch);
		setHighlightColor((highlightColor != null) ? highlightColor : new Color((byte)255, (byte)255, (byte)0));
	}

	// Properties
	/** 
	 Gets or sets whether the all-pages color inversion control is visible.
	*/
	private boolean enableQuickSearch;
	public final boolean getEnableQuickSearch()
	{
		return enableQuickSearch;
	}
	public final void setEnableQuickSearch(boolean value)
	{
		enableQuickSearch = value;
	}

	/** 
	 Gets or sets the text search highlight color.
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
		JSONObject jsonObjSearchControls = new JSONObject();
		jsonObjSearchControls.put("enableQuickSearch", getEnableQuickSearch());
		jsonObjSearchControls.put("highlightColor", getHighlightColor().toHexString(false));
		jsonObj.put("searchControls", jsonObjSearchControls);
	}
}