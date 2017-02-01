package com.gnostice.stardocssdk;

/** 
 Defines font-embedding options.
*/
public enum FontEmbeddingType
{
	/** 
	 No embedding.
	*/
	None,
	/** 
	 Subset embedding. 
	*/
	 Subset,
	 /** 
		Full embedding. 
	 */
		Full;

	public int getValue()
	{
		return this.ordinal();
	}

	public static FontEmbeddingType forValue(int value)
	{
		return values()[value];
	}
}