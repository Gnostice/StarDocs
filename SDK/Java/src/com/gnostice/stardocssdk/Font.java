package com.gnostice.stardocssdk;

import java.util.EnumSet;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a font.
*/
public class Font
{
	// Fields

	/** 
	 Creates a new instance of this class using specified name,
	 size, and style of this font.
	*/

	public Font(String name, int size, Color color, EnumSet<FontStyle> style)
	{
		this(name, size, color, style, FontEffect.None);
	}

	public Font(String name, int size, Color color)
	{
		this(name, size, color, EnumSet.noneOf(FontStyle.class), FontEffect.None);
	}

	public Font(String name, int size, Color color, EnumSet<FontStyle> style, FontEffect effect)
	{
		setName(name);
		setStyle(style);
		setSize(size);
		setColor((color != null) ? color : new Color((byte)0, (byte)0, (byte)0, (byte)100));
		setEffect(effect);
	}

	/** 
	 Gets or sets name for the font.
	*/
	private String name;
	public final String getName()
	{
		return name;
	}
	public final void setName(String value)
	{
		name = value;
	}
	
	/** 
	 Gets or sets text style used by the font.
	*/
	private EnumSet<FontStyle> style;
	public final EnumSet<FontStyle> getStyle()
	{
		return style;
	}
	public final void setStyle(EnumSet<FontStyle> value)
	{
		style = value;
	}
	
	/** 
	 Gets or sets size of the text.
	*/
	private int size;
	public final int getSize()
	{
		return size;
	}
	public final void setSize(int value)
	{
		size = value;
	}
	
	/** 
	 Gets color used to write text with this font.
	*/
	private Color color;
	public final Color getColor()
	{
		return color;
	}
	private void setColor(Color value)
	{
		color = value;
	}
	
	/** 
	 Gets text effects for this font.
	*/
	private FontEffect effect;
	public final FontEffect getEffect()
	{
		return effect;
	}
	public final void setEffect(FontEffect value)
	{
		effect = value;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj, FontSizingMode fontSizingMode, FontColoringMode fontColoringMode)
	{
		JSONObject jsonFont = new JSONObject();
		// Encode Name
		jsonFont.put("name", getName());
		// Encode Style
		JSONObject jsonFontStyle = new JSONObject();
		jsonFontStyle.put("bold", getStyle().contains(FontStyle.Bold));
		jsonFontStyle.put("italic", getStyle().contains(FontStyle.Italic));
		jsonFontStyle.put("underline", getStyle().contains(FontStyle.Underline));
		jsonFont.put("style", jsonFontStyle);
		// Encode Size
		if (fontSizingMode == FontSizingMode.UseFontSize)
		{
			jsonFont.put("size", getSize());
		}
		else
		{
			jsonFont.put("size", "autoFit");
		}
		// Encode Color
		if (fontColoringMode == FontColoringMode.UseFontColor)
		{
			jsonFont.put("color", getColor().toHexString());
		}
		else
		{
			jsonFont.put("color", "source");
		}
		// Encode Effects
		// ToDo
		jsonObj.put("font", jsonFont);
	}
}