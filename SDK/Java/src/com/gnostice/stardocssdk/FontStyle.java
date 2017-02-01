package com.gnostice.stardocssdk;

/** 
 Defines font styles.
*/
public enum FontStyle
{
	/** 
	 Bold.
	*/
	Bold,
	
	/** 
	 Italic.
	*/
	 Italic,

	 /** 
		Underline.
	 */
	Underline;

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontStyle forValue(int value)
	{
		return values()[value];
	}
}