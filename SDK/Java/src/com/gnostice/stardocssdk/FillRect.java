package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents how a rectangular area is filled.
*/
public class FillRect
{
	// Fields
	private ColoringMode brushColoringMode = ColoringMode.None;
	private Brush brush = new Brush();

	// Ctors
	public FillRect()
	{
	}

	// Properties
	/** 
	 Gets or sets brush settings for filling the rectangle.
	*/
	public final ColoringMode getBrushColoringMode()
	{
		return brushColoringMode;
	}
	public final void setBrushColoringMode(ColoringMode value)
	{
		brushColoringMode = value;
	}
	
	/** 
	 Gets brush used to fill the rectangle.
	*/
	public final Brush getBrush()
	{
		return brush;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonFill = new JSONObject();
		// Encode Color
		if (getBrushColoringMode() == ColoringMode.UseColor)
		{
			jsonFill.put("color", getBrush().getColor().toHexString());
		}
		else
		{
			jsonFill.put("color", "none");
		}
		// Encode Pattern
		jsonFill.put("pattern", Utils.toCamelCase(getBrush().getBrushPattern().name()));
		jsonObj.put("fill", jsonFill);
	}
}