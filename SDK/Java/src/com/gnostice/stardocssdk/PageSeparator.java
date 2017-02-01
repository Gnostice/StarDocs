package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class PageSeparator
{
	// Fields
	private PageSeparatorType pageSeparatorType;

	// Ctors
	public PageSeparator(PageSeparatorType pageSeparatorType)
	{
		this.pageSeparatorType = pageSeparatorType;
	}

	// Properties
	public final PageSeparatorType getPageSeparatorType()
	{
		return pageSeparatorType;
	}
	public final void setPageSeparatorType(PageSeparatorType value)
	{
		pageSeparatorType = value;
	}

	// Methods

	public void EncodeJson(JSONObject jsonObj) 
	{
		jsonObj.put("separatorType", Utils.toCamelCase(pageSeparatorType.name()));
	}
}