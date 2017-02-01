package com.gnostice.stardocssdk;

import java.util.EnumSet;

import org.json.JSONArray;
import org.json.JSONObject;

public class ConverterDigitizerSettings
{
    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings()
    {
    	this(DigitizationMode.Off, null, EnumSet.of(RecognizableElementType.Text), true, null);
    }

    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings(
      DigitizationMode digitizationMode)
    {
    	this(digitizationMode, null, EnumSet.of(RecognizableElementType.Text), true, null);
    }

    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings(
      DigitizationMode digitizationMode, 
      String[] documentLanguages)
    {
    	this(digitizationMode, documentLanguages, EnumSet.of(RecognizableElementType.Text), true, null);
    }

    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings(
      DigitizationMode digitizationMode, 
      String[] documentLanguages, 
      EnumSet<RecognizableElementType> recognizeElements)
    {
    	this(digitizationMode, documentLanguages, recognizeElements, true, null);
    }

    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings(
      DigitizationMode digitizationMode, 
      String[] documentLanguages, 
      EnumSet<RecognizableElementType> recognizeElements,
      boolean skewCorrection)
    {
    	this(digitizationMode, documentLanguages, recognizeElements, skewCorrection, null);
    }
    /**
     * Creates an instance of this class.
     * @param digitizationMode
     * @param documentLanguages
     * @param recognizeElements
     * @param skewCorrection
     * @param imageEnhancementSettings
     */
    public ConverterDigitizerSettings(
      DigitizationMode digitizationMode, 
      String[] documentLanguages, 
      EnumSet<RecognizableElementType> recognizeElements,
      boolean skewCorrection,
      ImageEnhancementSettings imageEnhancementSettings)
    {
      this.digitizationMode = digitizationMode;
      this.documentLanguages = documentLanguages;
      if (documentLanguages == null)
      {
    	  this.documentLanguages = new String[0];
      }
      this.recognizeElements = recognizeElements;
      this.skewCorrection = skewCorrection;
      this.imageEnhancementSettings = imageEnhancementSettings;
      if (imageEnhancementSettings == null)
      {
    	  this.imageEnhancementSettings = new ImageEnhancementSettings();
      }
    }
    
	/** 
	 Gets or sets the digitization mode used by the converter.
	*/
	private DigitizationMode digitizationMode;
	public final DigitizationMode getDigitizationMode()
	{
		return digitizationMode;
	}
	public final void setDigitizationMode(DigitizationMode value)
	{
		digitizationMode = value;
	}
    
	/** 
	 Gets or sets the array of string used to specify the language of the text 
	 present in the input document. Currently only 'eng' is supported.
	*/
	private String[] documentLanguages;
	public final String[] getDocumentLanguages()
	{
		return documentLanguages;
	}
	public final void setDocumentLanguages(String[] value)
	{
		documentLanguages = value;
	}
	
	/** 
	 Gets or sets the array of string used to specify the language of the text 
	 present in the input document. Currently only 'eng' is supported.
	*/
	private EnumSet<RecognizableElementType> recognizeElements;
	public final EnumSet<RecognizableElementType> getRecognizeElements()
	{
		return recognizeElements;
	}
	public final void setRecognizeElements(EnumSet<RecognizableElementType> value)
	{
		recognizeElements = value;
	}

	/** 
	 Gets or sets whether image skew correction should be performed. 
	*/
	private boolean skewCorrection;
	public final boolean getSkewCorrection()
	{
		return skewCorrection;
	}
	public final void setSkewCorrection(boolean value)
	{
		skewCorrection = value;
	}

	/** 
	 Gets the image enhancement settings.
	*/
	private ImageEnhancementSettings imageEnhancementSettings;
	public final ImageEnhancementSettings getImageEnhancementSettings()
	{
		return imageEnhancementSettings;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonDigitizerSettings = new JSONObject();
		jsonDigitizerSettings.put("digitizationMode", Utils.toCamelCase(digitizationMode.name()));
		if (documentLanguages != null && documentLanguages.length > 0)
		{
			JSONArray jsonArrayDocumentLanguages = new JSONArray();
			for (int index = 0; index < documentLanguages.length; ++index)
			{
				jsonArrayDocumentLanguages.put(documentLanguages[index]);
			}
			jsonDigitizerSettings.put("documentLanguages", jsonArrayDocumentLanguages);
		}
		JSONArray jsonArrayRecognizeElements = new JSONArray();
		if (recognizeElements.contains(RecognizableElementType.Text))
		{
			jsonArrayRecognizeElements.put("text");
		}
		jsonDigitizerSettings.put("recognizeElements", jsonArrayRecognizeElements);
		jsonDigitizerSettings.put("skewCorrection", skewCorrection);
		imageEnhancementSettings.encodeJson(jsonDigitizerSettings);
		jsonObj.put("digitizerSettings", jsonDigitizerSettings);
	}
}
