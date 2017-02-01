package com.gnostice.stardocssdk;

/** 
 Defines text search types.
*/
public enum TextSearchMode
{
		/** 
		 Literal search.
		*/
	Literal,
		/** 
		 Regular expression search.
		*/
		Regex;

	public int getValue()
	{
		return this.ordinal();
	}

	public static TextSearchMode forValue(int value)
	{
		return values()[value];
	}
}