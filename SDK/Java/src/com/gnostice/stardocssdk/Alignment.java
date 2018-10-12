package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class Alignment
{
	// Ctor
	public Alignment()
	{
	}

	// Properties
	private HorizontalAlignmentType horizontalAlignmentType = HorizontalAlignmentType.Center;
	private int horizontalOffset = 0;
	private VerticalAlignmentType verticalAlignmentType = VerticalAlignmentType.Center;
	private int verticalOffset = 0;

	/** 
	 Get or set the horizontal alignment of the content with respect to the canvas.
	*/
	public final HorizontalAlignmentType getHorizontalAlignmentType()
	{
		return horizontalAlignmentType;
	}
	public final void setHorizontalAlignmentType(HorizontalAlignmentType value)
	{
		horizontalAlignmentType = value;
	}
	/** 
	 Get or set the horizontal offset measured from the set alignment.
	*/
	public final int getHorizontalOffset()
	{
		return horizontalOffset;
	}
	public final void setHorizontalOffset(int value)
	{
		horizontalOffset = value;
	}
	/** 
	 Get or set the vertical alignment of the content with respect to the canvas.
	*/
	public final VerticalAlignmentType getVerticalAlignmentType()
	{
		return verticalAlignmentType;
	}
	public final void setVerticalAlignmentType(VerticalAlignmentType value)
	{
		verticalAlignmentType = value;
	}
	/** 
	 Get or set the vertical offset measured from the set alignment.
	*/
	public final int getVerticalOffset()
	{
		return verticalOffset;
	}
	public final void setVerticalOffset(int value)
	{
		verticalOffset = value;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonContentAlignment = new JSONObject();
		jsonContentAlignment.put("horizontalAlignment", Utils.toCamelCase(getHorizontalAlignmentType().toString()));
		jsonContentAlignment.put("horizontalOffset", getHorizontalOffset());
		jsonContentAlignment.put("verticalAlignment", Utils.toCamelCase(getVerticalAlignmentType().toString()));
		jsonContentAlignment.put("verticalOffset", getVerticalOffset());
		jsonObj.put("contentAlignment", jsonContentAlignment);
	}
}