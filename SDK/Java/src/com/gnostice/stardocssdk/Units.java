package com.gnostice.stardocssdk;

/** 
 Defines the units.
*/
public enum Units
{
	Millimeters,
	Centimeters,
	Inches,
	Picas,
	Pixels,
	Points,
	Twips;

	public int getValue()
	{
		return this.ordinal();
	}

	public static Units forValue(int value)
	{
		return values()[value];
	}
}