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
	// Properties
	private String replaceText = "";
	private FontSelectionMode fontSelectionMode = FontSelectionMode.UseFont;
	public FontSizingMode fontSizingMode = FontSizingMode.AutoFit;
	public FontColoringMode fontColoringMode = FontColoringMode.Source;
	private Font font = new Font("Arial", 10, new Color((byte)00, (byte)00, (byte)00, (byte)100));

	// Ctors
	public FillText()
	{
	}

	/** 
	 Gets or sets text that needs to be replace specified existing
	 text occurrences.
	*/
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
	public final FontSizingMode getFontSizingMode()
	{
		return fontSizingMode;
	}
	public final void setFontSizingMode(FontSizingMode value)
	{
		fontSizingMode = value;
	}

	/** 
	 Gets or sets how font is sized for the replacement text.
	*/
	public final FontSelectionMode getFontSelectionMode()
	{
		return fontSelectionMode;
	}
	public final void setFontSelectionMode(FontSelectionMode value)
	{
		fontSelectionMode = value;
	}
	
	/** 
	 Gets or sets how replacement text is colored.
	*/
	public final FontColoringMode getFontColoringMode()
	{
		return fontColoringMode;
	}
	public final void setFontColoringMode(FontColoringMode value)
	{
		fontColoringMode = value;
	}

	/** 
	 Gets font used to render text in the filled area.
	*/
	public final Font getFont()
	{
		return font;
	}

	/** 
	 Sets the font used to render text in the filled area.
	*/
	public final void setFont(Font value)
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