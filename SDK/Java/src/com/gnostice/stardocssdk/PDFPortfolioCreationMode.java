package com.gnostice.stardocssdk;

/** 
 Defines PDF portfolio creation options
*/
public enum PDFPortfolioCreationMode
{
	/** 
	 Portfolio creation is turned off.
	*/
	Off,
	/** 
	 PDF is created as a portfolio regardless of whether there are any attachments to add.
	*/
	Always,
	/** 
	 PDF is created as a portfolio only if the input PDF is already a portfolio.
	*/
	WhenInputIsPortfolio,
	/** 
	 PDF is created as a portfolio only when the resulting PDF contains attachments (originally present or newly added during conversion).
	*/
	OnlyWhenAttachmentsExist;

	public int getValue()
	{
		return this.ordinal();
	}

	public static PDFPortfolioCreationMode forValue(int value)
	{
		return values()[value];
	}
}