package com.gnostice.stardocssdk;



/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 \ \ 
*/
public class Preferences
{
	private DocPasswordSettings docPasswordSettings = null;

	/** 
	 Creates an instance of this class with specified password
	 settings.
	 
	 @param docPasswordSettings Password settings.
	*/

	public Preferences()
	{
		this(null);
	}

	public Preferences(DocPasswordSettings docPasswordSettings)
	{
		this.docPasswordSettings = (docPasswordSettings != null) ? docPasswordSettings : new DocPasswordSettings();
	}

	/** 
	 Gets password settings.
	*/
	public final DocPasswordSettings getDocPasswordSettings()
	{
		return docPasswordSettings;
	}
	//public MeasurementUnits MeasurementUnits { get; set; }
}