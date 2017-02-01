package com.gnostice.stardocssdk;

/** 
 Defines the sizing mode.
*/
public enum SizingMode
{
	/** 
	 Use the size of the input.
	*/
	UseSource,
	/** 
	 Use the specified size.
	*/
	UseSpecifiedSize,
	/** 
	 Use the specified relative size.
	*/
	UseSpecifiedRelativeSize;

	public int getValue()
	{
		return this.ordinal();
	}

	public static SizingMode forValue(int value)
	{
		return values()[value];
	}
}