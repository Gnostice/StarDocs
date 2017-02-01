package com.gnostice.stardocssdk;

public enum FontColoringMode
{
	Source,
	UseFontColor;

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontColoringMode forValue(int value)
	{
		return values()[value];
	}
}