package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class CanvasSize
{
	// Ctor
	public CanvasSize(SizingMode sizingMode, Size size, int relativeSizeX)
	{
		this(sizingMode, size, relativeSizeX, 100);
	}

	public CanvasSize(SizingMode sizingMode, Size size)
	{
		this(sizingMode, size, 100, 100);
	}

	public CanvasSize(SizingMode sizingMode)
	{
		this(sizingMode, null, 100, 100);
	}

	public CanvasSize()
	{
		this(SizingMode.UseSource, null, 100, 100);
	}

	public CanvasSize(SizingMode sizingMode, Size size, int relativeSizeX, int relativeSizeY)
	{
		setSizingMode(sizingMode);
		setSize((size != null) ? size : new Size(PaperSize.A4));
		setRelativeSizeX(relativeSizeX);
		setRelativeSizeY(relativeSizeY);
	}

	// Properties
	/** 
	 Get or set the sizing mode.
	*/
	private SizingMode sizingMode;
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
	private Size size;
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
	private int relativeSizeX;
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
	private int relativeSizeY;
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