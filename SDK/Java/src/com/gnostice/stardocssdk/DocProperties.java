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
	// Fields

	// Ctors
	/** 
	 Creates a new instance of this class with specified title,
	 author, subject, keywords (in a list), and creator document
	 properties.
	*/

	public DocProperties(String title, String author, String subject, java.util.ArrayList<String> keywords)
	{
		this(title, author, subject, keywords, null);
	}

	public DocProperties(String title, String author, String subject)
	{
		this(title, author, subject, (String)null, null);
	}

	public DocProperties(String title, String author)
	{
		this(title, author, null, (String)null, null);
	}

	public DocProperties(String title)
	{
		this(title, null, null, (String)null, null);
	}

	public DocProperties()
	{
		this(null, null, null, (String)null, null);
	}

	public DocProperties(String title, String author, String subject, ArrayList<String> keywords, String creator)
	{
		setTitle(title);
		setAuthor(author);
		setSubject(subject);
		setKeywords((keywords != null) ? keywords : new ArrayList<String>());
		setCreator(creator);
	}

	/** 
	 Creates a new instance of this class with specified title,
	 author, subject, keywords (in a string), and creator
	 document properties.
	*/

	public DocProperties(String title, String author, String subject, String keywords)
	{
		this(title, author, subject, keywords, null);
	}


	public DocProperties(String title, String author, String subject, String keywords, String creator)
	{
		setTitle(title);
		setAuthor(author);
		setSubject(subject);
		if (keywords != null)
		{
			// Tokenize
			String[] keywordArray = keywords.split("[;]", -1);
			setKeywords(new ArrayList<String>(keywordArray));
		}
		else
		{
			setKeywords(new ArrayList<String>());
		}
		setCreator(creator);
	}

	// Properties
	/** 
	 Gets or sets &quot;title&quot; document property.
	*/
	private String title;
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
	private String author;
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
	private String subject;
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
	private ArrayList<String> keywords;
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
	private String creator;
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