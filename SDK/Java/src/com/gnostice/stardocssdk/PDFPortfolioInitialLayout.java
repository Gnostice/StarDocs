package com.gnostice.stardocssdk;

/** 
 Defines the initial layout view of the PDF portfolio.
*/
public enum PDFPortfolioInitialLayout
{
	/** 
	 Details view.
	*/
	Details,
	/** 
	 Tile view.
	*/
	Tile,
	/** 
	 Hidden.
	*/
	Hidden;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PDFPortfolioInitialLayout forValue(int value)
	{
		return values()[value];
	}
}