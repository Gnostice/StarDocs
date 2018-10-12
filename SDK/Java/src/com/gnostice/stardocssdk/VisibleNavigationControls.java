package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleNavigationControls
{
	// Properties
	private boolean firstPage = true;
	private boolean lastPage = true;
	private boolean prevPage = true;
	private boolean nextPage = true;
	private boolean pageIndicator = true;
	private boolean gotoPage = true;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public VisibleNavigationControls()
	{
	}

	/** 
	 Gets or sets whether the first-page navigation control is visible.
	*/
	public final boolean getFirstPage()
	{
		return firstPage;
	}
	public final void setFirstPage(boolean value)
	{
		firstPage = value;
	}
	
	/** 
	 Gets or sets whether the last-page navigation control is visible.
	*/
	public final boolean getLastPage()
	{
		return lastPage;
	}
	public final void setLastPage(boolean value)
	{
		lastPage = value;
	}
	
	/** 
	 Gets or sets whether the previous-page navigation control is visible.
	*/
	public final boolean getPrevPage()
	{
		return prevPage;
	}
	public final void setPrevPage(boolean value)
	{
		prevPage = value;
	}
	
	/** 
	 Gets or sets whether the next-page navigation control is visible.
	*/
	public final boolean getNextPage()
	{
		return nextPage;
	}
	public final void setNextPage(boolean value)
	{
		nextPage = value;
	}
	
	/** 
	 Gets or sets whether the page-indicator is visible.
	*/
	public final boolean getPageIndicator()
	{
		return pageIndicator;
	}
	public final void setPageIndicator(boolean value)
	{
		pageIndicator = value;
	}
	
	/** 
	 Gets or sets whether the goto-page navigation control is visible.
	*/
	public final boolean getGotoPage()
	{
		return gotoPage;
	}
	public final void setGotoPage(boolean value)
	{
		gotoPage = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonVisibleNavigationControls = new JSONObject();
		jsonVisibleNavigationControls.put("firstPage", getFirstPage());
		jsonVisibleNavigationControls.put("lastPage", getLastPage());
		jsonVisibleNavigationControls.put("prevPage", getPrevPage());
		jsonVisibleNavigationControls.put("nextPage", getNextPage());
		jsonVisibleNavigationControls.put("pageIndicator", getPageIndicator());
		jsonVisibleNavigationControls.put("gotoPage", getGotoPage());
		jsonObj.put("visibleNavigationControls", jsonVisibleNavigationControls);
	}
}