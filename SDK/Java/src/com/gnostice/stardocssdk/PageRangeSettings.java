package com.gnostice.stardocssdk;

import org.json.JSONObject;


/** 
 Represents of page ranges need to be interpreted.
*/
public class PageRangeSettings
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	 
	 @param pageRangeStr Pages that need to be included.
	 @param pageSubRangeMode Pre\-defined page range. By default, set to all pages.
	 @param pageOrdering Pre\-defined page range. By default, set to normal (going from first to last).
	*/

	public PageRangeSettings(String pageRangeStr, PageSubRangeMode pageSubRangeMode)
	{
		this(pageRangeStr, pageSubRangeMode, false);
	}

	public PageRangeSettings(String pageRangeStr)
	{
		this(pageRangeStr, PageSubRangeMode.All, false);
	}

	public PageRangeSettings(String pageRangeStr, PageSubRangeMode pageSubRangeMode, boolean reverseOrder)
	{
		this.setPageRange(new PageRange((pageRangeStr != null) ? pageRangeStr : ""));
		this.setPageSubRangeMode(pageSubRangeMode);
		this.setReverseOrder(reverseOrder);
	}

	/** 
	 Creates an instance of this class.
	 @param pageRange Pages that need to be included.
	 @param pageSubRangeMode Predefined page range. By default, set to all pages.
	 @param pageOrdering Predefined page range. By default, set to normal (going from first to last).          
	*/

	public PageRangeSettings(PageRange pageRange, PageSubRangeMode pageSubRangeMode)
	{
		this(pageRange, pageSubRangeMode, false);
	}

	public PageRangeSettings(PageRange pageRange)
	{
		this(pageRange, PageSubRangeMode.All, false);
	}

	public PageRangeSettings(PageRange pageRange, PageSubRangeMode pageSubRangeMode, boolean reverseOrder)
	{
		this.setPageRange((pageRange != null) ? pageRange : new PageRange(""));
		this.setPageSubRangeMode(pageSubRangeMode);
		this.setReverseOrder(reverseOrder);
	}

	// Properties

	/** 
	 Gets or sets pages in the page range.
	*/
	private PageRange pageRange;
	public final PageRange getPageRange()
	{
		return pageRange;
	}
	private void setPageRange(PageRange value)
	{
		pageRange = value;
	}
	
	/** 
	 Gets or sets pre-defined page ranges.
	*/
	private PageSubRangeMode pageSubRangeMode;
	public final PageSubRangeMode getPageSubRangeMode()
	{
		return pageSubRangeMode;
	}
	public final void setPageSubRangeMode(PageSubRangeMode value)
	{
		pageSubRangeMode = value;
	}
	
	/** 
	 Gets or sets whether page ordering is reversed.
	*/
	private boolean reverseOrder;
	public final boolean getReverseOrder()
	{
		return reverseOrder;
	}
	public final void setReverseOrder(boolean value)
	{
		reverseOrder = value;
	}

	// Methods

	public JSONObject toJson(boolean excludeOrdering) 
	{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("range", getPageRange().getRange());
		jsonObj.put("subRangeMode", Utils.toCamelCase(getPageSubRangeMode().name()));
		if (!excludeOrdering)
		{
			jsonObj.put("reverseOrder", getReverseOrder());
		}
		return jsonObj;
	}

	public void encodeJson(JSONObject jsonObj, String key, boolean excludeOrdering) 
	{
		JSONObject jsonPageRangeSettings = new JSONObject();
		jsonPageRangeSettings.put("range", getPageRange().getRange());
		jsonPageRangeSettings.put("subRangeMode", Utils.toCamelCase(getPageSubRangeMode().name()));
		if (!excludeOrdering)
		{
			jsonPageRangeSettings.put("reverseOrder", getReverseOrder());
		}
		jsonObj.put(key,  jsonPageRangeSettings);
	}
}