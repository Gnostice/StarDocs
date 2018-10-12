package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents dimensions of a document page.
*/
public class Size
{
	// Properties
	private PaperSize paperSize;
	private float width;
	private float height;
	private Units units;

	// Ctors
	/** 
	 Creates an instance of this class.
	 @param paperSize Predefined paper size.
	 @param width (Optional) Page width.
	 @param height (Optional) Page height.  
	*/

	public Size(PaperSize paperSize, float width, float height)
	{
		this(paperSize, width, height, Units.Millimeters);
	}

	public Size(PaperSize paperSize, float width)
	{
		this(paperSize, width, 0, Units.Millimeters);
	}

	public Size(PaperSize paperSize)
	{
		this(paperSize, 0, 0, Units.Millimeters);
	}

	public Size(PaperSize paperSize, float width, float height, Units units)
	{
		setPaperSize(paperSize);
		setWidth(width);
		setHeight(height);
		setUnits(units);
	}

	/** 
	 Gets or sets pre-defined size for the page.
	*/
	public final PaperSize getPaperSize()
	{
		return paperSize;
	}
	public final void setPaperSize(PaperSize value)
	{
		paperSize = value;
	}
	
	/** 
	 Gets or sets height of the page.
	*/
	public final float getWidth()
	{
		return width;
	}
	public final void setWidth(float value)
	{
		width = value;
	}
	
	/** 
	 Gets or sets height of the page.
	*/
	public final float getHeight()
	{
		return height;
	}
	public final void setHeight(float value)
	{
		height = value;
	}
	
	/** 
	 Gets or sets units of width and height.
	*/
	public final Units getUnits()
	{
		return units;
	}
	public final void setUnits(Units value)
	{
		units = value;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		switch (getPaperSize())
		{
			case Custom:
				jsonObj.put("size",  String.valueOf(getWidth()) + ";" + String.valueOf(getHeight()) + ";" + Utils.toCamelCase(getUnits().name()));
				break;
			default:
				jsonObj.put("size",  Utils.toCamelCase(getPaperSize().name()));
				break;
		}
	}
}