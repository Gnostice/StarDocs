package com.gnostice.stardocssdk;

import java.util.*;

/** 
 Represents document information properties.
*/
public class PDFDocProperties extends DocProperties
{
	// Fields
	private String producer;
	private boolean hasExPropertySecurity;

	// Ctors
	/** 
	 Creates an instance of this class with specified document
	 information properties.
	 
	 @param title Text that needs to set as the 'title' document information property.
	 @param author Text that needs to set as the 'author' document informationproperty.
	 @param subject Text that needs to set as the 'subject' document information property.
	 @param keywords Text that needs to set as the 'keywords' document information property.
	 @param creator Text that needs to set as the 'creator' document information property.
	 @param producer Text that needs to set as the 'producer' document information property.
	 @param hasExPropertySecurity Whether the document is encrypted.     
	*/

	public PDFDocProperties(String title, String author, String subject, java.util.ArrayList<String> keywords, String creator, String producer)
	{
		this(title, author, subject, keywords, creator, producer, false);
	}

	public PDFDocProperties(String title, String author, String subject, java.util.ArrayList<String> keywords, String creator)
	{
		this(title, author, subject, keywords, creator, null, false);
	}

	public PDFDocProperties(String title, String author, String subject, java.util.ArrayList<String> keywords)
	{
		this(title, author, subject, keywords, null, null, false);
	}

	public PDFDocProperties(String title, String author, String subject)
	{
		this(title, author, subject, null, null, null, false);
	}

	public PDFDocProperties(String title, String author)
	{
		this(title, author, null, null, null, null, false);
	}

	public PDFDocProperties(String title)
	{
		this(title, null, null, null, null, null, false);
	}

	public PDFDocProperties()
	{
		this(null, null, null, null, null, null, false);
	}

	public PDFDocProperties(String title, String author, String subject, ArrayList<String> keywords, String creator, String producer, boolean hasExPropertySecurity)
	{
		super(title, author, subject, keywords, creator);
		this.producer = producer;
		this.hasExPropertySecurity = hasExPropertySecurity;
	}

	// Properties
	/** 
	 Gets name of application identified as the &quot;producer&quot;
	 of the document.
	*/
	public final String getProducer()
	{
		return producer;
	}
	/** 
	 Gets whether the document is encrypted.
	*/
	public final boolean getHasExPropertySecurity()
	{
		return hasExPropertySecurity;
	}

	// Methods
	@Override
	public String toString()
	{
		Object[] objs = new Object[] {super.toString(), producer, hasExPropertySecurity};
		return String.format("%1$s, Producer=%2$s, HasExPropertySecurity=%3$s", objs);
	}

}