package com.gnostice.stardocssdk;

/** 
 Represents pattern used to fill a shape.
*/
public enum BrushPattern
{
	Solid,
	ForwardDiagonal,
	BackwardDiagonal,
	Cross,
	DiagonalCross,
	Horizontal,
	Vertical;

	public int getValue()
	{
		return this.ordinal();
	}

	public static BrushPattern forValue(int value)
	{
		return values()[value];
	}
}