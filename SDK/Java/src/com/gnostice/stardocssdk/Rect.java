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
	// Properties
	private float top;
	private float left;
	private float bottom;
	private float right;

	// Ctors
	public Rect(float top, float left, float bottom, float right)
	{
		setTop(top);
		setLeft(left);
		setBottom(bottom);
		setRight(right);
	}

	/** 
	 Gets or sets location of the bottom edge of the region on the
	 page.
	*/
	public final float getTop()
	{
		return top;
	}
	public final void setTop(float value)
	{
		top = value;
	}
	
	/** 
	 Gets or sets location of the bottom edge of the region on the
	 page.
	*/
	public final float getBottom()
	{
		return bottom;
	}
	public final void setBottom(float value)
	{
		bottom = value;
	}

	/** 
	 Gets or sets location of the left edge of the region on the
	 page.
	*/
	public final float getLeft()
	{
		return left;
	}
	public final void setLeft(float value)
	{
		left = value;
	}

	/** 
	 Gets or sets location of the right edge of the region on the
	 page.
	*/
	public final float getRight()
	{
		return right;
	}
	public final void setRight(float value)
	{
		right = value;
	}

	/** 
	 Gets width of the region on the page.
	*/
	public final float getWidth()
	{
		return right - left;
	}

	/** 
	 Gets height of the region on the page.
	*/
	public final float getHeight()
	{
		return bottom - top;
	}

	// Methods
	public final String EncodeString()
	{
		String str = String.valueOf(getTop()) + "x" + String.valueOf(getLeft()) + "x" + String.valueOf(getBottom()) + "x" + String.valueOf(getRight());
		return str;
	}

	@Override
	public String toString()
	{
		String res = "top=" + top + ", left=" + left + ", width=" + getWidth() + ", height=" + getHeight();
		return res;
	}
}