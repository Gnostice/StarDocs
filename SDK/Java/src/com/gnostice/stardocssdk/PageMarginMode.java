package com.gnostice.stardocssdk;

public enum PageMarginMode
{
	Source,
	UsePageMargin;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PageMarginMode forValue(int value)
	{
		return values()[value];
	}
}