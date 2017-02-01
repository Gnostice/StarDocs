package com.gnostice.stardocssdk;

/** 
 Defines encryption strength levels for PDF documents.
*/
public enum PDFEncryptionLevel
{
	/** 
	 No encryption. 
	*/
	None,
	/** 
	 128-bit AES encryption. 
	*/
	AES_128bit,
	/** 
	 128-bit RC4 encryption.
	*/
	RC4_128bit,
	/** 
	 40-bit RC4 encryption.
	*/
	RC4_40bit;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PDFEncryptionLevel forValue(int value)
	{
		return values()[value];
	}
}