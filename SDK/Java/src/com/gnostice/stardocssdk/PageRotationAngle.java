package com.gnostice.stardocssdk;

public enum PageRotationAngle 
{
    Zero,
    Clockwise90,
    Clockwise180,
    Clockwise270,
    CounterClockwise90,
    CounterClockwise180,
    CounterClockwise270;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PageRotationAngle forValue(int value)
	{
		return values()[value];
	}
}
