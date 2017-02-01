package com.gnostice.stardocssdk;



/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents password requirements.
*/
public class DocPasswordSettings
{
	private boolean forceFullPermission;

	/** 
	 Creates an instance of this class.
	 
	 @param forceFullPermission Whether all document usage
																		 permissions need to be
																		 turned on.        
	*/

	public DocPasswordSettings()
	{
		this(false);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: public DocPasswordSettings(bool forceFullPermission = false)
	public DocPasswordSettings(boolean forceFullPermission)
	{
		this.forceFullPermission = forceFullPermission;
	}

	/** 
	 Gets or sets whether all document usage permissions need to
	 be turned on.
	*/
	public final boolean getForceFullPermission()
	{
		return forceFullPermission;
	}
	public final void setForceFullPermission(boolean value)
	{
		this.forceFullPermission = value;
	}
}