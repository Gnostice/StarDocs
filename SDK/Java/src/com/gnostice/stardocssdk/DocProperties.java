package com.gnostice.stardocssdk;

import java.util.*;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents document properties.
*/
public class DocProperties
{
	// Properties
	private String title;
	private String author;
	private String subject;
	private ArrayList<String> keywords = new ArrayList<String>();
	private String creator;

	// Ctors
	public DocProperties()
	{
	}

	/** 
	 Gets or sets &quot;title&quot; document property.
	*/
	public final String getTitle()
	{
		return title;
	}
	public final void setTitle(String value)
	{
		title = value;
	}
	
	/** 
	 Gets or sets &quot;author&quot; document property.
	*/
	public final String getAuthor()
	{
		return author;
	}
	public final void setAuthor(String value)
	{
		author = value;
	}
	
	/** 
	 Gets or sets &quot;subject&quot; document property.
	*/
	public final String getSubject()
	{
		return subject;
	}
	public final void setSubject(String value)
	{
		subject = value;
	}
	
	/** 
	 Gets or sets &quot;keywords&quot; document property.
	*/
	public final ArrayList<String> getKeywords()
	{
		return keywords;
	}
	public final void setKeywords(ArrayList<String> value)
	{
		keywords = value;
	}
	
	/** 
	 Gets or sets &quot;creator&quot; document property.
	*/
	public final String getCreator()
	{
		return creator;
	}
	public final void setCreator(String value)
	{
		creator = value;
	}

	// Methods
	@Override
	public String toString()
	{
		return String.format("Title=%1$s, Author=%2$s, Subject=%3$s, Keywords=%4$s, Creator=%5$s", getTitle(), getAuthor(), getSubject(), tangible.DotNetToJavaStringHelper.join(";", getKeywords().toArray(new String[0])), getCreator());
	}

	public final String ToJson()
	{
		String jsonStr = "\"properties\":{";
		jsonStr += "\"title\":\"" + getTitle() + "\"";
		jsonStr += ",\"author\":\"" + getAuthor() + "\"";
		jsonStr += ",\"subject\":\"" + getSubject() + "\"";
		jsonStr += ",\"keywords\":\"" + tangible.DotNetToJavaStringHelper.join(";", getKeywords().toArray(new String[0])) + "\"";
		jsonStr += ",\"creator\":\"" + getCreator() + "\"";
		jsonStr += "}";
		return jsonStr;
	}
}