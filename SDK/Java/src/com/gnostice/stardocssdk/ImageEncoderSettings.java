package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ImageEncoderSettings extends EncoderSettings
{
	// Properties
	private DPI dpi = new DPI();
	private int quality = 80;
	private CanvasSize canvasSize = new CanvasSize();
	private Scaling contentScaling = Scaling.FitWithAspect;
	private Alignment contentAlignment = new Alignment();

	// Ctor
	public ImageEncoderSettings()
	{
	}

	public final DPI getDpi()
	{
		return dpi;
	}
	
	public final int getQuality()
	{
		return quality;
	}
	public final void setQuality(int value)
	{
		quality = value;
	}
	
	public final CanvasSize getCanvasSize()
	{
		return canvasSize;
	}
	
	public final Scaling getContentScaling()
	{
		return contentScaling;
	}

	public final void setContentScaling(Scaling value)
	{
		contentScaling = value;
	}
	
	public final Alignment getContentAlignment()
	{
		return contentAlignment;
	}

	// Methods
	@Override
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonImageEncoderSettings = new JSONObject();
		getDpi().encodeJson(jsonImageEncoderSettings);
		jsonImageEncoderSettings.put("quality", getQuality());
		getCanvasSize().encodeJson(jsonImageEncoderSettings);
		jsonImageEncoderSettings.put("contentScaling", Utils.toCamelCase(getContentScaling().name()));;
		getContentAlignment().encodeJson(jsonImageEncoderSettings);
		jsonObj.put("imageEncoderSettings", jsonImageEncoderSettings);
	}
}