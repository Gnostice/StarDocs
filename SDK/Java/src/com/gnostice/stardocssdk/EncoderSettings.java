package com.gnostice.stardocssdk;

import org.json.JSONObject;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/**
 Represents base type for encoder settings.
*/
public abstract class EncoderSettings
{
	// Fields

	// Ctor
	protected EncoderSettings()
	{
	}

	// Methods
	public abstract void encodeJson(JSONObject jsonObj);
}