package com.gnostice.stardocssdk;

/** 
 Defines page sizes.
*/
public enum PaperSize
{
	/** 
	 A2 paper size.
	*/
	A2,
	/** 
	 A3 paper size.
	*/
	A3,
	/** 
	 A4 paper size.
	*/
	A4,
	/** 
	 A5 paper size.
	*/
	A5,
	/** 
	 A6 paper size.
	*/
	A6,
	/** 
	 Custom paper size.
	*/
	Custom;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PaperSize forValue(int value)
	{
		return values()[value];
	}
}