package com.gnostice.stardocssdk;

import java.net.URISyntaxException;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents findings of a call to GetDocumentInfo method.
*/

public class GetDocumentInfoResponse extends DocObject
{
	// Fields

	// Ctors
	public GetDocumentInfoResponse(CommonInt.RestAPIResponseGetDocumentInfo apiResponse) throws URISyntaxException
	{
		super(apiResponse);
		setUnsupportedMimeTypeOrCorrupt(apiResponse.unsupportedMimeTypeOrCorrupt);
		setPasswordProtected(apiResponse.passwordProtected);
		setPasswordCorrect(apiResponse.passwordCorrect);
	}

	// Properties
	private boolean unsupportedMimeTypeOrCorrupt;
	public final boolean getUnsupportedMimeTypeOrCorrupt()
	{
		return unsupportedMimeTypeOrCorrupt;
	}
	private void setUnsupportedMimeTypeOrCorrupt(boolean value)
	{
		unsupportedMimeTypeOrCorrupt = value;
	}
	
	private boolean passwordProtected;
	public final boolean getPasswordProtected()
	{
		return passwordProtected;
	}
	private void setPasswordProtected(boolean value)
	{
		passwordProtected = value;
	}
	
	/** 
	 Gets whether the file could be opened using password(s)
	 supplied earlier.
	*/
	private boolean passwordCorrect;
	public final boolean getPasswordCorrect()
	{
		return passwordCorrect;
	}
	private void setPasswordCorrect(boolean value)
	{
		passwordCorrect = value;
	}

	// Methods
	@Override
	public String toString()
	{
		Object[] objs = new Object[] {super.toString(), getUnsupportedMimeTypeOrCorrupt(), getPasswordProtected(), getPasswordCorrect()};
		return String.format("%1$s, UnsupportedMimeTypeOrCorrupt=%2$s, PasswordProtected=%3$s, PasswordCorrect=%4$s", objs);
	}

}