package com.gnostice.stardocssdk;

/** 
 Defines type of compression used by a TIFF image.
*/
public enum TIFFCompressionType
{
		/** 
		 No compression.
		*/
	None,
		/** 
		 An implementation of LZ77 and Huffman encoding.
		*/
	 Deflate,
		 /** 
			Group 3 Fax - for monochrome images.
		 */
	 CCITT_3,
		 /** 
			Group 4 Fax - for monochrome images.
		 */
	 CCITT_4,
		 /** 
			Group 3 Fax Run-Length Encoding (RLE) - for monochrome
			images.
		 */
		CCITT_RLE,
			/** 
			 JPEG encoding with EXIF metadata - lossy compression.
			*/
		 EXIF_JPEG,
			 /** 
				JPEG encoding.
			 */
			JPEG,
				/** 
				 Lempel–Ziv–Welch (LZW) compression.
				*/
			 LZW,
				 /** 
					Apple PackBits compression.
				 */
	 PackBits,
		 /** 
			Zlib implementation of DEFLATE method.
		 */
		ZLib;

	public int getValue()
	{
		return this.ordinal();
	}

	public static TIFFCompressionType forValue(int value)
	{
		return values()[value];
	}
}