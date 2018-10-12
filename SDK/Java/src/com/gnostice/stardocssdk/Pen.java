package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents pen used to stroke shapes.
*/
public class Pen
{
	// Properties
	private Color color;
	private int width;
	private PenStyle style;

	// Ctors
	/** 
	 Creates an instance of this class and initializes it with
	 specified color, style and width.
	*/
	public Pen(Color color, PenStyle penStyle)
	{
		this(color, penStyle, 1);
	}

	public Pen(Color color)
	{
		this(color, PenStyle.Solid, 1);
	}

	public Pen()
	{
		this(null, PenStyle.Solid, 1);
	}

	public Pen(Color color, PenStyle penStyle, int width)
	{
		setColor((color != null) ? color : new Color((byte)0, (byte)0, (byte)0));
		setStyle(penStyle);
		setWidth(width);
	}

	/** 
	 Gets color used by the pen for strokes.
	*/
	public final Color getColor()
	{
		return color;
	}
	private void setColor(Color value)
	{
		color = value;
	}
	
	// Width is always specified in Pixels (for this wrapper) with 96 PPI
	/** 
	 Gets or sets width of the strokes of the pen.
	*/
	public final int getWidth()
	{
		return width;
	}
	public final void setWidth(int value)
	{
		width = value;
	}
	
	/** 
	 Gets or sets stroke pattern used by the pen.
	*/
	public final PenStyle getStyle()
	{
		return style;
	}
	public final void setStyle(PenStyle value)
	{
		style = value;
	}

	// Methods
}