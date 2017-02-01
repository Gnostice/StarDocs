package com.gnostice.stardocssdk;

/** 
 Defines text size adjustment methods.
*/
public enum FontSizingMode
{
		/** 
		 Resize the text to fit the dimensions of the bounding box.
		*/
	AutoFit,
		/** 
		 Force text to use original font size.
		*/
	 UseFontSize;

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontSizingMode forValue(int value)
	{
		return values()[value];
	}
}