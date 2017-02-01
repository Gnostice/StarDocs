package com.gnostice.stardocssdk;

public class Auth
{
	// Fields
	public AuthInt authInt;

	// Ctors
	public Auth(StarDocs starDocs)
	{
		authInt = new AuthInt(starDocs);
	}

	// Properties

	// Methods
	/*
	public AuthResponse loginUser()
	{
	  return authInt.loginUser();
	}
	*/


	public final AuthResponse loginApp() throws StarDocsException
	{
		return loginApp(null);
	}

	public final AuthResponse loginApp(String entityId) throws StarDocsException
	{
		return authInt.loginApp(entityId);
	}
}