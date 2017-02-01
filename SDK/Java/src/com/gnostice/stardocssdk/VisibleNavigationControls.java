package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleNavigationControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleNavigationControls(boolean firstPage, boolean lastPage, boolean prevPage, boolean nextPage, boolean pageIndicator)
	{
		this(firstPage, lastPage, prevPage, nextPage, pageIndicator, true);
	}

	public VisibleNavigationControls(boolean firstPage, boolean lastPage, boolean prevPage, boolean nextPage)
	{
		this(firstPage, lastPage, prevPage, nextPage, true, true);
	}

	public VisibleNavigationControls(boolean firstPage, boolean lastPage, boolean prevPage)
	{
		this(firstPage, lastPage, prevPage, true, true, true);
	}

	public VisibleNavigationControls(boolean firstPage, boolean lastPage)
	{
		this(firstPage, lastPage, true, true, true, true);
	}

	public VisibleNavigationControls(boolean firstPage)
	{
		this(firstPage, true, true, true, true, true);
	}

	public VisibleNavigationControls()
	{
		this(true, true, true, true, true, true);
	}

	public VisibleNavigationControls(boolean firstPage, boolean lastPage, boolean prevPage, boolean nextPage, boolean pageIndicator, boolean gotoPage)
	{
		setFirstPage(firstPage);
		setLastPage(lastPage);
		setPrevPage(prevPage);
		setNextPage(nextPage);
		setPageIndicator(pageIndicator);
		setGotoPage(gotoPage);
	}

	// Properties
	/** 
	 Gets or sets whether the first-page navigation control is visible.
	*/
	private boolean firstPage;
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
	private boolean lastPage;
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
	private boolean prevPage;
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
	private boolean nextPage;
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
	private boolean pageIndicator;
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
	private boolean gotoPage;
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