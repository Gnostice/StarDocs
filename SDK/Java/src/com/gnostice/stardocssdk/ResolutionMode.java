package com.gnostice.stardocssdk;

/** 
 Defines the resolution mode which determines how the DPI should be set.
*/
public enum ResolutionMode
{
	/** 
	 Use the DPI of the input if it can be determined, else a default value of 72 is used.
	*/
	UseSource,
	/** 
	 Use the specified DPI.
	*/
	UseSpecifiedDpi;

	public int getValue()
	{
		return this.ordinal();
	}

	public static ResolutionMode forValue(int value)
	{
		return values()[value];
	}
}