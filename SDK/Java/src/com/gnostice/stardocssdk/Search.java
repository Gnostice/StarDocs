package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class Search
{
	// Properties
	private boolean enableQuickSearch = true;
	private boolean quickSearchVisible = true;
	private Color highlightColor = new Color(255, 255, 0, 50);

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public Search()
	{
	}


	// Methods

	/** 
	 Gets or sets whether the all-pages color inversion control is visible.
	*/
	public final boolean getEnableQuickSearch()
	{
		return enableQuickSearch;
	}
	public final void setEnableQuickSearch(boolean value)
	{
		enableQuickSearch = value;
	}

	public boolean isQuickSearchVisible() 
	{
		return quickSearchVisible;
	}

	public void setQuickSearchVisible(boolean quickSearchVisible) 
	{
		this.quickSearchVisible = quickSearchVisible;
	}

	/** 
	 Gets or sets the text search highlight color.
	*/
	public final Color getHighlightColor()
	{
		return highlightColor;
	}
	public final void setHighlightColor(Color value)
	{
		highlightColor = value;
	}

	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjSearch = new JSONObject();
		jsonObjSearch.put("enableQuickSearch", getEnableQuickSearch());
		jsonObjSearch.put("quickSearchVisible", quickSearchVisible);
		jsonObjSearch.put("highlightColor", getHighlightColor().toRGBA());
		jsonObj.put("search", jsonObjSearch);
	}
}