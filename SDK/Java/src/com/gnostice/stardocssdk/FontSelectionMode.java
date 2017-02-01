package com.gnostice.stardocssdk;

public enum FontSelectionMode
{

		// Source,
		UseFont;

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontSelectionMode forValue(int value)
	{
		return values()[value];
	}
}