package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class ImageEncoderSettings extends EncoderSettings
{
	// Properties
	private DPI dpi;
	public final DPI getDpi()
	{
		return dpi;
	}
	public final void setDpi(DPI value)
	{
		dpi = value;
	}
	
	private int quality;
	public final int getQuality()
	{
		return quality;
	}
	public final void setQuality(int value)
	{
		quality = value;
	}
	
	private CanvasSize canvasSize;
	public final CanvasSize getCanvasSize()
	{
		return canvasSize;
	}
	public final void setCanvasSize(CanvasSize value)
	{
		canvasSize = value;
	}
	
	private Scaling contentScaling;
	public final Scaling getContentScaling()
	{
		return contentScaling;
	}
	private void setContentScaling(Scaling value)
	{
		contentScaling = value;
	}
	
	private Alignment contentAlignment;
	public final Alignment getContentAlignment()
	{
		return contentAlignment;
	}
	public final void setContentAlignment(Alignment value)
	{
		contentAlignment = value;
	}

	// Ctor
	public ImageEncoderSettings(DPI dpi, int quality, CanvasSize canvasSize, Scaling contentScaling)
	{
		this(dpi, quality, canvasSize, contentScaling, null);
	}

	public ImageEncoderSettings(DPI dpi, int quality, CanvasSize canvasSize)
	{
		this(dpi, quality, canvasSize, Scaling.FitWithAspect, null);
	}

	public ImageEncoderSettings(DPI dpi, int quality)
	{
		this(dpi, quality, null, Scaling.FitWithAspect, null);
	}

	public ImageEncoderSettings(DPI dpi)
	{
		this(dpi, 80, null, Scaling.FitWithAspect, null);
	}

	public ImageEncoderSettings()
	{
		this(null, 80, null, Scaling.FitWithAspect, null);
	}

	public ImageEncoderSettings(DPI dpi, int quality, CanvasSize canvasSize, Scaling contentScaling, Alignment contentAlignment)
	{
		setDpi((dpi != null) ? dpi : new DPI());
		setQuality(quality);
		setCanvasSize((canvasSize != null) ? canvasSize : new CanvasSize());
		setContentScaling(contentScaling);
		setContentAlignment((contentAlignment != null) ? contentAlignment : new Alignment());
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