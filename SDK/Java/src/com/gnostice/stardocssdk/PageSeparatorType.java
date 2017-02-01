package com.gnostice.stardocssdk;

public enum PageSeparatorType
{
	EmptyPage;
	// CustomPage

	public int getValue()
	{
		return this.ordinal();
	}

	public static PageSeparatorType forValue(int value)
	{
		return values()[value];
	}
}