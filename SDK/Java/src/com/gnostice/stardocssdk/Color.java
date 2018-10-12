package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a color.
 Red, blue, and green component values can have a value from 0
 to 255. Alpha values can be set from 0 to 100.
																										
*/
public class Color
{
	// Fields

	/** 
	 Creates a new instance of this class.
	 
	 @param red Value of the red component.
	 @param green Value of the green component.
	 @param blue Value of the blue component.
	 @param alpha Value of the alpha component.
	 
	 Value of the alpha component can range from 1 to 100. Values
	 for other components can range from 0 to 255.
																										 
	*/

	public Color(int red, int green, int blue)
	{
		this(red, green, blue, (byte)100);
	}

	public Color(int red, int green, int blue, int alpha)
	{
		setRed(red);
		setGreen(green);
		setBlue(blue);
		setAlpha(alpha);
	}

	// Properties
	private int red;
	private int green;
	private int blue;
	private int alpha;
	
	/** 
	 Gets or sets red component value of the color.
	*/
	public final int getRed()
	{
		return red;
	}
	public final void setRed(int value)
	{
		red = value;
	}

	/** 
	 Gets or sets green component value of the color. 
	*/
	public final int getGreen()
	{
		return green;
	}

	public final void setGreen(int value)
	{
		green = value;
	}

	/** 
	 Gets or sets blue component value of the color. 
	*/
	public final int getBlue()
	{
		return blue;
	}
	public final void setBlue(int value)
	{
		blue = value;
	}

	/** 
	 Gets or sets transparency value of the color.
	*/
	public final int getAlpha()
	{
		return alpha;
	}
	public final void setAlpha(int value)
	{
		alpha = value;
	}

	// Methods
	public final String toHexString()
	{
		return toHexString(true);
	}

	public final String toHexString(boolean encodeAlpha)
	{
		// Convert each component to hex string and concatenate them as RRGGBBAA
		String str = "#" + String.format("%02X", getRed()) + String.format("%02X", getGreen()) + String.format("%02X", getBlue());
		if (encodeAlpha)
		{
			str += String.format("%02X", getAlpha());
		}
		return str;
	}

	public final String toRGBA()
	{
		// Encode as RGBA
		String str = "rgba(" + Integer.toString(getRed()) + "," + Integer.toString(getGreen()) + "," + Integer.toString(getBlue());
		double fAlpha = getAlpha() / 100.0;
		str += ("," + Double.toString(fAlpha) + ")");
		return str;
	}
}