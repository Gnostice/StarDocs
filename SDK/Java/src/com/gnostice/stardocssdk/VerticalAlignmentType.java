package com.gnostice.stardocssdk;

/** 
 Defines vertical alignment options.
*/
public enum VerticalAlignmentType
{
		/** 
		 Aligned to top and bottom edges. 
		*/
	 Center,
	 /** 
		Aligned to top edge.
	 */
		Top,
		/** 
		 Aligned to the bottom edges. 
		*/
		Bottom;

	public int getValue()
	{
		return this.ordinal();
	}

	public static VerticalAlignmentType forValue(int value)
	{
		return values()[value];
	}
}