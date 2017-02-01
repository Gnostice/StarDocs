package com.gnostice.stardocssdk;

/** 
 Defines how content needs to be resized.
*/
public enum Scaling
{
	/** 
	 Content is resized down with the same aspect ratio to fit
	 within the margins.
	*/
	FitWithAspect,
	/** 
	 Content is resized to fit the margins.
	*/
	Stretch,
	/** 
	 Content overflowing its margins are cropped out.
	*/
	Crop;

	public int getValue()
	{
		return this.ordinal();
	}

	public static Scaling forValue(int value)
	{
		return values()[value];
	}
}