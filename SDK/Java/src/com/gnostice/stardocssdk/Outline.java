package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents how the bounding box of a region on a page is
 stroked.
*/
public class Outline
{
	// Properties
	private Pen pen = new Pen();
	private ColoringMode penColoringMode = ColoringMode.None;

	// Ctors
	/** 
	 Creates an instance of this class with specified coloring
	 mode and pen.
	*/
	public Outline()
	{
	}

	/** 
	 Gets pen used to stroke the outline.
	*/
	public final Pen getPen()
	{
		return pen;
	}
	
	/** 
	 Gets or sets how a pen colors its strokes.
	*/
	public final ColoringMode getPenColoringMode()
	{
		return penColoringMode;
	}
	public final void setPenColoringMode(ColoringMode value)
	{
		penColoringMode = value;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonOutline = new JSONObject();
		if (getPenColoringMode() == ColoringMode.UseColor)
		{
			jsonOutline.put("color", getPen().getColor().toHexString());
		}
		else
		{
			jsonOutline.put("color", "none");
		}
		jsonOutline.put("width", getPen().getWidth());
		// Encode PenStyle
		jsonOutline.put("style", Utils.toCamelCase(getPen().getStyle().name()));
		jsonObj.put("outline", jsonOutline);
	}
}