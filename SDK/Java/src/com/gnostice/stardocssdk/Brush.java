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

	public Brush(Color color)
	{
		this(color, BrushPattern.Solid);
	}

	public Brush()
	{
		this(null, BrushPattern.Solid);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: public Brush(Color color = null, BrushPattern brushPattern = BrushPattern.Solid)
	public Brush(Color color, BrushPattern brushPattern)
	{
		setColor((color != null) ? color : new Color((byte)0, (byte)0, (byte)0, (byte)100));
		setBrushPattern(brushPattern);
	}

	/** 
	 Gets or sets color used by the brush.
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
	 Gets or sets pattern used with drawing operations of this
	 brush.
	*/
	private BrushPattern brushPattern;
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