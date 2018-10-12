package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class CanvasSize
{
	// Ctor

	public CanvasSize()
	{
	}

	// Properties
	private SizingMode sizingMode = SizingMode.UseSource;
	private Size size = new Size(PaperSize.A4);
	private int relativeSizeX = 100;
	private int relativeSizeY = 100;

	/** 
	 Get or set the sizing mode.
	*/
	public final SizingMode getSizingMode()
	{
		return sizingMode;
	}
	public final void setSizingMode(SizingMode value)
	{
		sizingMode = value;
	}
	/** 
	 Get or set the canvas size. Applies only when the SizingMode is UseSpecifiedSize.
	*/
	public final Size getSize()
	{
		return size;
	}
	public final void setSize(Size value)
	{
		size = value;
	}

	/** 
	 Get or set the horizontal canvas size relative (%) to the input. Applies only when the SizingMode is UseSpecifiedRelativeSize.
	*/
	public final int getRelativeSizeX()
	{
		return relativeSizeX;
	}
	public final void setRelativeSizeX(int value)
	{
		relativeSizeX = value;
	}
	/** 
	 Get or set the vertical canvas size relative (%) to the input. Applies only when the SizingMode is UseSpecifiedRelativeSize.
	*/
	public final int getRelativeSizeY()
	{
		return relativeSizeY;
	}
	public final void setRelativeSizeY(int value)
	{
		relativeSizeY = value;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonCanvasSize = new JSONObject();
		jsonCanvasSize.put("sizingMode", Utils.toCamelCase(getSizingMode().name()));
		if (getSizingMode() == SizingMode.UseSpecifiedSize)
		{
			getSize().encodeJson(jsonCanvasSize);
			
		}
		else if (getSizingMode() == SizingMode.UseSpecifiedRelativeSize)
		{
			jsonCanvasSize.put("relativeSizeX", getRelativeSizeX());
			jsonCanvasSize.put("relativeSizeY", getRelativeSizeY());
		}
		jsonObj.put("canvasSize", jsonCanvasSize);
	}
}