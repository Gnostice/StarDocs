package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class DPI
{
	// Ctor

	public DPI(ResolutionMode resolutionMode, int x)
	{
		this(resolutionMode, x, 72);
	}

	public DPI(ResolutionMode resolutionMode)
	{
		this(resolutionMode, 72, 72);
	}

	public DPI()
	{
		this(ResolutionMode.UseSource, 72, 72);
	}

	public DPI(ResolutionMode resolutionMode, int x, int y)
	{
		setResolutionMode(resolutionMode);
		setX(x);
		setY(y);
	}

	// Properties
	/** 
	 Get or set the resolution mode.
	*/
	private ResolutionMode resolutionMode;
	public final ResolutionMode getResolutionMode()
	{
		return resolutionMode;
	}
	public final void setResolutionMode(ResolutionMode value)
	{
		resolutionMode = value;
	}
	
	/** 
	 Get or set the horizontal DPI. Default is 72.
	*/
	private int x;
	public final int getX()
	{
		return x;
	}
	public final void setX(int value)
	{
		x = value;
	}
	
	/** 
	 Get or set the vertical DPI. Default is 72.
	*/
	private int y;
	public final int getY()
	{
		return y;
	}
	public final void setY(int value)
	{
		y = value;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonDpi = new JSONObject();
		jsonDpi.put("resolutionMode", Utils.toCamelCase(getResolutionMode().name()));;
		jsonDpi.put("x", getX());
		jsonDpi.put("y", getY());
		jsonObj.put("dpi", jsonDpi);
	}

	public final String ToJson()
	{
		String jsonStr = "\"dpi\": { \"resolutionMode\": \"" + Utils.toCamelCase(getResolutionMode().name()) + "\"";
		jsonStr += ",\"x\": " + getX();
		jsonStr += ",\"y\": " + getY();
		jsonStr += "}";
		return jsonStr;
	}
}