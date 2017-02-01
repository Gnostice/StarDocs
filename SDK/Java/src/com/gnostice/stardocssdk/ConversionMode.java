package com.gnostice.stardocssdk;

/** 
 Defines how the input files are processed to produce the output during conversion to operation.
*/
public enum ConversionMode
{
	/** 
	 Each input file is independently converted to one output file.
	*/
	ConvertToSeparateFiles,
	/** 
	 All input files are combined sequentially to produce a single output file.
	*/
	ConvertToSingleFile,
	/** 
	 The first input file is converted to a one output file and the rest of the input files are attached as-is to the output file.
	*/
	ConvertFirstFileAndAttachRestAsOriginal,
	/** 
	 A new blank output file is created and all input files are attached as-is to the newly created output file.
	*/
	CreateNewFileAndAttachAllAsOriginal;

	public int getValue()
	{
		return this.ordinal();
	}

	public static ConversionMode forValue(int value)
	{
		return values()[value];
	}
}