package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents how redacted regions needs to be filled.
*/
public class RedactFillSettings
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class with specified outline, 
	*/

	public RedactFillSettings(Outline outline, FillRect fill)
	{
		this(outline, fill, null);
	}

	public RedactFillSettings(Outline outline)
	{
		this(outline, null, null);
	}

	public RedactFillSettings()
	{
		this(null, null, null);
	}

	public RedactFillSettings(Outline outline, FillRect fill, FillText text)
	{
		setOutline((outline != null) ? outline : new Outline());
		setFill((fill != null) ? fill : new FillRect());
		setText((text != null) ? text : new FillText(""));
	}

	// Properties
	/** 
	 Gets how bounding box of redacted area is stroked.
	*/
	private Outline outline;
	public final Outline getOutline()
	{
		return outline;
	}
	private void setOutline(Outline value)
	{
		outline = value;
	}
	
	/** 
	 Gets rectangular area that is filled.
	*/
	private FillRect fill;
	public final FillRect getFill()
	{
		return fill;
	}
	private void setFill(FillRect value)
	{
		fill = value;
	}
	
	/** 
	 Gets or sets text that is rendered in place of the text that
	 is redacted.
	*/
	private FillText text;
	public final FillText getText()
	{
		return text;
	}
	private void setText(FillText value)
	{
		text = value;
	}

	// Methods
	public final void encodeJson(JSONObject jsonObj)
	{
		JSONObject jsonFillSettings = new JSONObject();
		getOutline().encodeJson(jsonFillSettings);
		getFill().encodeJson(jsonFillSettings);
		getText().encodeJson(jsonFillSettings);
		jsonObj.put("fillSettings", jsonFillSettings);
	}
}