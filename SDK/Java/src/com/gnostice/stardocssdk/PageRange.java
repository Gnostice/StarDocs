package com.gnostice.stardocssdk;

import java.util.*;

/** 
 Represents a page range.
*/
public class PageRange
{
	// Fields
	public String range;

	// Ctors
	/** 
	 Creates an instance of this class with specified page range.
	*/
	public PageRange(String range)
	{
		setRange(range);
	}

	// Properties
	/** 
	 Gets or sets page range.
	*/
	public final String getRange()
	{
		return range;
	}
	public final void setRange(String value)
	{
		range = value.trim();
	}

	// Methods
	/** 
	 Adds a specified page to the page range.
	*/
	public final void addPage(int pageNum)
	{
		if (range.length() > 0)
		{
			range += ",";
		}
		range += String.valueOf(pageNum);
	}

	/** 
	 Adds specified pages to the page range.
	*/
	public final void addPages(ArrayList<Integer> pages)
	{
		if (pages.size() > 0)
		{
			if (range.length() > 0)
			{
				range += ",";
			}
			int pageCount = pages.size();
			for (int index = 0; index < pageCount; ++index)
			{
				int page = pages.get(index);
				range += String.valueOf(page);
				if (index != (pageCount - 1))
				{
					range += ",";
				}
			}
		}
	}

	/** 
	 Adds pages in specified range to &quot;this&quot; page range.
	*/
	public final void addRange(int startPageNum, int endPageNum)
	{
		if (range.length() > 0)
		{
			range += ",";
		}
		range += (String.valueOf(startPageNum) + "-" + String.valueOf(endPageNum));
	}

	/** 
	 Removes all pages from the page range.
	*/
	public final void clear()
	{
		range = "";
	}

}