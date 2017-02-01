package com.gnostice.stardocssdk;

/** 
 Defines how strokes are colored.
*/
public enum ColoringMode
{
	None,
	UseColor;

	public int getValue()
	{
		return this.ordinal();
	}

	public static ColoringMode forValue(int value)
	{
		return values()[value];
	}
}