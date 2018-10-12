package com.gnostice.stardocssdk;

import java.util.*;

/** 
 Represents document information properties.
*/
public class PDFDocProperties extends DocProperties
{
	// Fields
	private String producer;
	private boolean hasExPropertySecurity = false;

	// Ctors
	public PDFDocProperties()
	{
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