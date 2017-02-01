package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a rectangular area on a page.
*/
public class Rect
{
	// Fields

	// Ctors
	public Rect(int top, int left, int bottom, int right)
	{
		setTop(top);
		setLeft(left);
		setBottom(bottom);
		setRight(right);
	}

	// Properties
	/** 
	 Gets or sets location of the bottom edge of the region on the
	 page.
	*/
	private int Top;
	public final int getTop()
	{
		return Top;
	}
	public final void setTop(int value)
	{
		Top = value;
	}
	/** 
	 Gets or sets location of the bottom edge of the region on the
	 page.
	*/
	private int Bottom;
	public final int getBottom()
	{
		return Bottom;
	}
	public final void setBottom(int value)
	{
		Bottom = value;
	}
	/** 
	 Gets or sets location of the left edge of the region on the
	 page.
	*/
	private int Left;
	public final int getLeft()
	{
		return Left;
	}
	public final void setLeft(int value)
	{
		Left = value;
	}
	/** 
	 Gets or sets location of the right edge of the region on the
	 page.
	*/
	private int Right;
	public final int getRight()
	{
		return Right;
	}
	public final void setRight(int value)
	{
		Right = value;
	}

	// Methods
	public final String EncodeString()
	{
		String str = String.valueOf(getTop()) + "x" + String.valueOf(getLeft()) + "x" + String.valueOf(getBottom()) + "x" + String.valueOf(getRight());
		return str;
	}
}