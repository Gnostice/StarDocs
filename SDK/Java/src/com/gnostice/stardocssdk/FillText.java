package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents how redacted text is replaced with new text.
*/
public class FillText
{
	// Fields

	// Ctors

	public FillText(String replaceText, FontSelectionMode fontSelectionMode, FontSizingMode fontSizingMode, FontColoringMode fontColoringMode)
	{
		this(replaceText, fontSelectionMode, fontSizingMode, fontColoringMode, null);
	}

	public FillText(String replaceText, FontSelectionMode fontSelectionMode, FontSizingMode fontSizingMode)
	{
		this(replaceText, fontSelectionMode, fontSizingMode, FontColoringMode.Source, null);
	}

	public FillText(String replaceText, FontSelectionMode fontSelectionMode)
	{
		this(replaceText, fontSelectionMode, FontSizingMode.AutoFit, FontColoringMode.Source, null);
	}

	public FillText(String replaceText)
	{
		this(replaceText, FontSelectionMode.UseFont, FontSizingMode.AutoFit, FontColoringMode.Source, null);
	}

	public FillText(String replaceText, FontSelectionMode fontSelectionMode, FontSizingMode _fontSizingMode, FontColoringMode _fontColoringMode, Font font) /*, bool wrap = true,
      bool repeat = false, HAlignmentType hAlign = HAlignmentType.Left, VAlignmentType vAlign = VAlignmentType.TextBaseline*/
	{
		setReplaceText((replaceText != null) ? replaceText : "");
		setFontSelectionMode(fontSelectionMode);
		fontSizingMode = _fontSizingMode;
		fontColoringMode = _fontColoringMode;
		setFont((font != null) ? font : new Font("Arial", 10, new Color((byte)00, (byte)00, (byte)00, (byte)100)));
		//Wrap = wrap;
		//Repeat = repeat;
		//HAlign = hAlign;
		//VAlign = vAlign;
	}

	// Properties

	/** 
	 Gets or sets text that needs to be replace specified existing
	 text occurrences.
	*/
	private String replaceText;
	public final String getReplaceText()
	{
		return replaceText;
	}
	public final void setReplaceText(String value)
	{
		replaceText = value;
	}
	
	/** 
	 Gets or sets how font is selected for the replacement text.
	*/
	private FontSelectionMode fontSelectionMode;
	public final FontSelectionMode getFontSelectionMode()
	{
		return fontSelectionMode;
	}
	public final void setFontSelectionMode(FontSelectionMode value)
	{
		fontSelectionMode = value;
	}
	
	public FontSizingMode fontSizingMode;
	public FontColoringMode fontColoringMode;
	
	/** 
	 Gets font used to render text in the filled area.
	*/
	private Font font;
	public final Font getFont()
	{
		return font;
	}
	private void setFont(Font value)
	{
		font = value;
	}
	
	/** 
	 Gets or sets whether text needs to be wrapped within its
	 bounding box.
	*/
	//public bool Wrap { get; set; }
	//public bool Repeat { get; set; }
	//public HAlignmentType HAlign { get; set; }
	//public VAlignmentType VAlign { get; set; }	// default: TextBaseline

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonText = new JSONObject();
		// Encode Text
		jsonText.put("replaceText", getReplaceText());
		// Encode Font
		if (getFontSelectionMode() == FontSelectionMode.UseFont)
		{
			getFont().encodeJson(jsonText, fontSizingMode, fontColoringMode);
		}
		else
		{
			jsonText.put("font", "source");
		}

		// Encode Alignment
		//jsonStr += ",\"hAlign\":\"" + EnumToString.HAlignmentTypeToString(HAlign) + "\"";
		//jsonStr += ",\"vAlign\":\"" + EnumToString.VAlignmentTypeToString(VAlign) + "\"";
		// Encode Repeat and Wrap
		//jsonStr += ",\"repeat\":" + Repeat.ToString().ToLower();
		//jsonStr += ",\"wrap\":" + Wrap.ToString().ToLower();

		jsonObj.put("text", jsonText);
	}
}