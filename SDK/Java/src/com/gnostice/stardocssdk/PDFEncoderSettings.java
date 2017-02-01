package com.gnostice.stardocssdk;

import org.json.JSONObject;

	/** 
	 Represents a PDF-creation settings.
	*/
	public class PDFEncoderSettings extends EncoderSettings
	{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class and initializes them with
	 specified font-embedding restrictions.
	 @param fontEmbeddingType How fonts need to be embedded in the document.
	 @param overrideFontEmbeddingRestriction Whether fonts that prohibit embedding can be embedded.
	*/

	public PDFEncoderSettings(PDFPortfolioSettings portfolioSettings, FontEmbeddingType fontEmbeddingType)
	{
		this(portfolioSettings, fontEmbeddingType, false);
	}

	public PDFEncoderSettings(PDFPortfolioSettings portfolioSettings)
	{
		this(portfolioSettings, FontEmbeddingType.Subset, false);
	}

	public PDFEncoderSettings()
	{
		this(null, FontEmbeddingType.Subset, false);
	}

	public PDFEncoderSettings(PDFPortfolioSettings portfolioSettings, FontEmbeddingType _fontEmbeddingType, boolean overrideFontEmbeddingRestriction) //hAlign, vAlign, pageSizingMode, pageSize, pageOrientation, pageMarginMode, pageMargin, scaling
	{
		super();
		setPDFPortfolioSettings(portfolioSettings);
		fontEmbeddingType = _fontEmbeddingType;
		setOverrideFontEmbeddingRestriction(overrideFontEmbeddingRestriction);
	}

	// Properties

	/** 
	 Specifies how fonts are embedded in the document.
	*/
	private FontEmbeddingType fontEmbeddingType;
	public final FontEmbeddingType getFontEmbeddingType()
	{
		return fontEmbeddingType;
	}
	public final void setFontEmbeddingType(FontEmbeddingType value)
	{
		fontEmbeddingType = value;
	}
	
	/** 
	 Gets or sets whether embedding restrictions of included font
	 files need to be ignored.
	*/
	private boolean overrideFontEmbeddingRestriction;
	public final boolean getOverrideFontEmbeddingRestriction()
	{
		return overrideFontEmbeddingRestriction;
	}
	public final void setOverrideFontEmbeddingRestriction(boolean value)
	{
		overrideFontEmbeddingRestriction = value;
	}
	
	/** 
	 Gets or sets PDF portfolio creation settings.
	*/
	private PDFPortfolioSettings pdfPortfolioSettings;
	public final PDFPortfolioSettings getPDFPortfolioSettings()
	{
		return pdfPortfolioSettings;
	}
	public final void setPDFPortfolioSettings(PDFPortfolioSettings value)
	{
		pdfPortfolioSettings = value;
	}

	// Methods
	@Override
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonPdfEncoderSettings = new JSONObject();
		getPDFPortfolioSettings().encodeJson(jsonPdfEncoderSettings);
		jsonPdfEncoderSettings.put("fontEmbedding", Utils.toCamelCase(fontEmbeddingType.name()));
		jsonPdfEncoderSettings.put("overrideFontEmbeddingRestriction", getOverrideFontEmbeddingRestriction());
		jsonObj.put("pdfEncoderSettings", jsonPdfEncoderSettings);
	}
}