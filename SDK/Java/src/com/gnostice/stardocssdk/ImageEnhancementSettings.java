package com.gnostice.stardocssdk;

import org.json.JSONArray;
import org.json.JSONObject;

public class ImageEnhancementSettings
{
	private ImageEnhancementMode imageEnhancementMode = ImageEnhancementMode.Off;
	private ImageEnhancementTechnique[] imageEnhancementTechniques = null;
	private float scalingFactor = 1;

	/**
    Creates an instance of this class.
    */
    public ImageEnhancementSettings()
    {
    }

	/** 
    Gets or sets the image enhancement mode used by the digitizer.
	*/
	public final ImageEnhancementMode getImageEnhancementMode()
	{
		return imageEnhancementMode;
	}
	public final void setImageEnhancementMode(ImageEnhancementMode value)
	{
		imageEnhancementMode = value;
	}

	/** 
    Gets or sets the image enhancement techniques used by the digitizer.
	*/
	public final ImageEnhancementTechnique[] getImageEnhancementTechniques()
	{
		return imageEnhancementTechniques;
	}
	public final void setImageEnhancementTechniques(ImageEnhancementTechnique[] value)
	{
		imageEnhancementTechniques = value;
	}

	/** 
    Gets or sets the scaling factor used for the Scaling image enhancement technique.
	*/
	public final float getScalingFactor()
	{
		return scalingFactor;
	}
	public final void setScalingFactor(float value)
	{
		scalingFactor = value;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonImageEnhancementSettings = new JSONObject();
		jsonImageEnhancementSettings.put("enhancementMode", Utils.toCamelCase(getImageEnhancementMode().name()));
		JSONArray jsonArrayEnhancementTechniques = new JSONArray();
		if (imageEnhancementTechniques != null)
		{
			for (int index = 0; index < imageEnhancementTechniques.length; ++index)
			{
				jsonArrayEnhancementTechniques.put(Utils.toCamelCase(imageEnhancementTechniques[index].name()));
			}
		}
		jsonImageEnhancementSettings.put("enhancementTechniques", jsonArrayEnhancementTechniques);
		jsonImageEnhancementSettings.put("scalingFactor", scalingFactor);
		jsonObj.put("imageEnhancementSettings", jsonImageEnhancementSettings);
	}
}
