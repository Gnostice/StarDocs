package com.gnostice.stardocssdk;

/** 
 Defines pen styles used for stroking operations.
*/
public enum PenStyle
{
		/** 
		 Solid stroke pattern.
		*/
		Solid,
		/** 
		 Dashed pattern.
		*/
	 Dash,
		 /** 
			Dotted pattern.
		 */
	 Dot,
		 /** 
			Dash-and-dot pattern.
		 */
		DashDot,
			/** 
			 Dash-and-dots pattern.
			*/
		DashDotDot;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PenStyle forValue(int value)
	{
		return values()[value];
	}
}