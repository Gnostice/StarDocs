package com.gnostice.stardocssdk;

/** 
 Defines how the input files are processed to produce the output during conversion to multi-page TIFF format.
*/
public enum MTIFFConversionMode
{
	/** 
	 Each input file is independently converted to one multi-page TIFF file.
	*/
	ConvertToSeparateFiles,
	/** 
	 All input files are combined sequentially to produce a single multi-page TIFF file.
	*/
	ConvertToSingleFile;

	public int getValue()
	{
		return this.ordinal();
	}

	public static MTIFFConversionMode forValue(int value)
	{
		return values()[value];
	}
}