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

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: public Preferences(DocPasswordSettings docPasswordSettings = null)
	public Preferences(DocPasswordSettings docPasswordSettings)
	{
		this.docPasswordSettings = (docPasswordSettings != null) ? docPasswordSettings : new DocPasswordSettings(false);
	}

	/** 
	 Gets password settings.
	*/
	public final DocPasswordSettings getDocPassword()
	{
		return docPasswordSettings;
	}
	//public MeasurementUnits MeasurementUnits { get; set; }
}