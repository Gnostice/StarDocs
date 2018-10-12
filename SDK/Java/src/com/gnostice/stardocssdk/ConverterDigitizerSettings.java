package com.gnostice.stardocssdk;

import java.util.EnumSet;

import org.json.JSONArray;
import org.json.JSONObject;

public class ConverterDigitizerSettings
{
	// Properties
    private DigitizationMode digitizationMode = DigitizationMode.Off;
	private String[] documentLanguages = new String[0];
	private EnumSet<RecognizableElementType> recognizeElements = EnumSet.of(RecognizableElementType.Text);
	private boolean skewCorrection = true;
	private ImageEnhancementSettings imageEnhancementSettings = new ImageEnhancementSettings();

	/** 
	 Gets or sets the digitization mode used by the converter.
	*/
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
	public final ImageEnhancementSettings getImageEnhancementSettings()
	{
		return imageEnhancementSettings;
	}

	// Methods
	public void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonDigitizerSettings = new JSONObject();
		jsonDigitizerSettings.put("digitizationMode", Utils.toCamelCase(digitizationMode.name()));
		if (documentLanguages.length > 0)
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
