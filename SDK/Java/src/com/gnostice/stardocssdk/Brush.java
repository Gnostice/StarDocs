package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents brush used for stroking operations.
*/
public class Brush
{
	// Fields

	/** 
	 Creates an instance of this class.
	*/

	public Brush()
	{
	}

	// Properties
	private Color color = new Color((byte)0, (byte)0, (byte)0, (byte)100);
	private BrushPattern brushPattern = BrushPattern.Solid;
	
	/** 
	 Gets or sets color used by the brush.
	*/
	public final Color getColor()
	{
		return color;
	}
	public void setColor(Color value)
	{
		color = value;
	}

	/** 
	 Gets or sets pattern used with drawing operations of this
	 brush.
	*/
	public final BrushPattern getBrushPattern()
	{
		return brushPattern;
	}
	public final void setBrushPattern(BrushPattern value)
	{
		brushPattern = value;
	}

	// Methods

}