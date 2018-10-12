package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents how redacted regions needs to be filled.
*/
public class RedactFillSettings
{
	// Properties
	private Outline outline = new Outline();
	private FillRect fill = new FillRect();
	private FillText text = new FillText();

	// Ctors
	/** 
	 Creates an instance of this class with specified outline, 
	*/
	public RedactFillSettings()
	{
	}


	/** 
	 Gets how bounding box of redacted area is stroked.
	*/
	public final Outline getFillOutline()
	{
		return outline;
	}
	
	/** 
	 Gets rectangular area that is filled.
	*/
	public final FillRect getFillRect()
	{
		return fill;
	}
	
	/** 
	 Gets or sets text that is rendered in place of the text that
	 is redacted.
	*/
	public final FillText getFillText()
	{
		return text;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonFillSettings = new JSONObject();
		getFillOutline().encodeJson(jsonFillSettings);
		getFillRect().encodeJson(jsonFillSettings);
		getFillText().encodeJson(jsonFillSettings);
		jsonObj.put("fillSettings", jsonFillSettings);
	}
}