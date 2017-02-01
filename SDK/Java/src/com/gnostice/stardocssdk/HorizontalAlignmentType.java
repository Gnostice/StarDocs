package com.gnostice.stardocssdk;

/** 
 Defines horizontal alignment options. 
*/
public enum HorizontalAlignmentType
{
		/** 
		 Aligned to both left edges. 
		*/
		Left,
		/** 
		 Aligned to both right edges.
		*/
	 Right,
		 /** 
			Aligned to both left and right edges. 
		 */
		Center;

	public int getValue()
	{
		return this.ordinal();
	}

	public static HorizontalAlignmentType forValue(int value)
	{
		return values()[value];
	}
}