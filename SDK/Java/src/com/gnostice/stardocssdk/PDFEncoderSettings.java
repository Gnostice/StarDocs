package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents a PDF-creation settings.
*/
public class PDFEncoderSettings extends EncoderSettings
{
	// Properties
	private FontEmbeddingType fontEmbeddingType = FontEmbeddingType.Subset;
	private boolean overrideFontEmbeddingRestriction = false;
	private PDFPortfolioSettings pdfPortfolioSettings = new PDFPortfolioSettings();

	// Ctors
	public PDFEncoderSettings()
	{
	}

	/** 
	 Specifies how fonts are embedded in the document.
	*/
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