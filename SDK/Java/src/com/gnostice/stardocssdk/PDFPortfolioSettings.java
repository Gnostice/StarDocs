package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a PDF portfolio settings.
*/
public class PDFPortfolioSettings
{
	// Properties
	private PDFPortfolioCreationMode pdfPortfolioCreationMode;
	private PDFPortfolioInitialLayout pdfPortfolioInitialLayout;

	// Ctors
	public PDFPortfolioSettings()
	{
		this(PDFPortfolioCreationMode.WhenInputIsPortfolio, PDFPortfolioInitialLayout.Details);
	}

	public PDFPortfolioSettings(PDFPortfolioCreationMode pdfPortfolioCreationMode, PDFPortfolioInitialLayout portfolioInitialLayout)
	{
		setPDFPortfolioCreationMode(pdfPortfolioCreationMode);
		setPDFPortfolioInitialLayout(portfolioInitialLayout);
	}

	/** 
	 Specifies when a PDF should be created as a portfolio.
	*/
	public final PDFPortfolioCreationMode getPDFPortfolioCreationMode()
	{
		return pdfPortfolioCreationMode;
	}
	public final void setPDFPortfolioCreationMode(PDFPortfolioCreationMode value)
	{
		pdfPortfolioCreationMode = value;
	}
	
	/** 
	 Specifies the initial view of the PDF portfolio.
	*/
	public final PDFPortfolioInitialLayout getPDFPortfolioInitialLayout()
	{
		return pdfPortfolioInitialLayout;
	}
	public final void setPDFPortfolioInitialLayout(PDFPortfolioInitialLayout value)
	{
		pdfPortfolioInitialLayout = value;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonPortfolioSettings = new JSONObject();
		jsonPortfolioSettings.put("creationMode", Utils.toCamelCase(getPDFPortfolioCreationMode().name()));
		jsonPortfolioSettings.put("initialLayout", Utils.toCamelCase(getPDFPortfolioInitialLayout().name()));
		jsonObj.put("portfolioSettings", jsonPortfolioSettings);
	}
}