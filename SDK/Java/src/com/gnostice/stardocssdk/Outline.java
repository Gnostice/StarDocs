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
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class with specified coloring
	 mode and pen.
	*/

	public Outline(ColoringMode penColoringMode)
	{
		this(penColoringMode, null);
	}

	public Outline()
	{
		this(ColoringMode.None, null);
	}

	public Outline(ColoringMode penColoringMode, Pen pen)
	{
		setPenColoringMode(penColoringMode);
		setPen((pen != null) ? pen : new Pen());
	}

	// Properties

	/** 
	 Gets pen used to stroke the outline.
	*/
	private Pen pen;
	public final Pen getPen()
	{
		return pen;
	}
	private void setPen(Pen value)
	{
		pen = value;
	}
	
	/** 
	 Gets or sets how a pen colors its strokes.
	*/
	private ColoringMode penColoringMode;
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