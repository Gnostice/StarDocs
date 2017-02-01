package com.gnostice.stardocssdk;

public enum FontEffect
{
	None; //, Strikethrough=2, DoubleStrikethrough=4

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontEffect forValue(int value)
	{
		return values()[value];
	}
}