package com.gnostice.stardocssdk;

/** 
 Defines pre-defined page ranges. 
*/
public enum PageSubRangeMode
{
		/** 
		 All pages.
		*/
		All,
			/** 
			 Even-numbered pages. 
			*/
		 Even,
			 /** 
				Odd-numbered pages.
			 */
			Odd;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PageSubRangeMode forValue(int value)
	{
		return values()[value];
	}
}