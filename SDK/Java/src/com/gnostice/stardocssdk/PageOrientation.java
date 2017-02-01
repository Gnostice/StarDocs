package com.gnostice.stardocssdk;

/** 
 Defines page orientation. 
*/
public enum PageOrientation
{
		/** 
		 Automatic(as specified in the document) or unspecified.
		*/
	Auto,
		/** 
		 Force portrait.
		*/
	 Portrait,
		 /** 
			Force landscape.
		 */
		Landscape;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PageOrientation forValue(int value)
	{
		return values()[value];
	}
}