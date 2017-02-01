package com.gnostice.stardocssdk;

/** 
Defines viewer navigation pane position.
*/
public enum NavigationPanePosition 
{
    Fixed,
    Float,
    Auto;
	
	public int getValue()
	{
		return this.ordinal();
	}

	public static NavigationPanePosition forValue(int value)
	{
		return values()[value];
	}

}
