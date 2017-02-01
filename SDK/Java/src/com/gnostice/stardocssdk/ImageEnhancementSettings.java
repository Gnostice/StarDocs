package com.gnostice.stardocssdk;

import org.json.JSONArray;
import org.json.JSONObject;

public class ImageEnhancementSettings
{
	/**
    Creates an instance of this class.
    */
    public ImageEnhancementSettings()
    {
    	this(ImageEnhancementMode.Off, null, 1);
    }

    /**
    Creates an instance of this class.
    */
    public ImageEnhancementSettings(ImageEnhancementMode imageEnhancementMode)
    {
    	this(imageEnhancementMode, null, 1);
    }

	/**
    Creates an instance of this class.
    */
    public ImageEnhancementSettings(ImageEnhancementMode imageEnhancementMode,
      ImageEnhancementTechnique[] imageEnhancementTechniques, float scalingFactor)
    {
      this.imageEnhancementMode = imageEnhancementMode;
      this.imageEnhancementTechniques = imageEnhancementTechniques;
      if (imageEnhancementTechniques == null)
      {
        this.imageEnhancementTechniques = new ImageEnhancementTechnique[0];
      }
      this.scalingFactor = scalingFactor;
    }
    
	/** 
    Gets or sets the image enhancement mode used by the digitizer.
	*/
	private ImageEnhancementMode imageEnhancementMode;
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
	private ImageEnhancementTechnique[] imageEnhancementTechniques;
	public final ImageEnhancementTechnique[] getImageEnhancementTechnique()
	{
		return imageEnhancementTechniques;
	}
	public final void setImageEnhancementTechnique(ImageEnhancementTechnique[] value)
	{
		imageEnhancementTechniques = value;
	}

	/** 
    Gets or sets the scaling factor used for the Scaling image enhancement technique.
	*/
	private float scalingFactor;
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
		for (int index = 0; index < imageEnhancementTechniques.length; ++index)
		{
			jsonArrayEnhancementTechniques.put(Utils.toCamelCase(imageEnhancementTechniques[index].name()));
		}
		jsonImageEnhancementSettings.put("enhancementTechniques", jsonArrayEnhancementTechniques);
		jsonImageEnhancementSettings.put("scalingFactor", scalingFactor);
		jsonObj.put("imageEnhancementSettings", jsonImageEnhancementSettings);
	}
}
