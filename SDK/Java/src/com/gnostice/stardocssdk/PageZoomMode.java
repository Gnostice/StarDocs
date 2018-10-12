package com.gnostice.stardocssdk;

public enum PageZoomMode 
{
    FitWidth,
    FitHeight,
    ActualSize,
    FitPage;
	
	public int getValue()
	{
		return this.ordinal();
	}

	public static PageZoomMode forValue(int value)
	{
		return values()[value];
	}
}
