package com.gnostice.stardocssdk;

/** 
 Represents how a document is password-protected.
*/
public enum PasswordType
{
	/** 
	 Document is not password-protected.
	*/
	None,
	/** 
	 An empty password is set so that user can open it without
	 entering a password.
	*/
	 Open,
	 /** 
		A user password is set requiring the end-user to enter it.
		(Document-usage restrictions will be applied.)
	 */
		Permissions;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PasswordType forValue(int value)
	{
		return values()[value];
	}
}