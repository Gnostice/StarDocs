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
public class GetPropertiesSecurityResponse extends DocObject
{
	// Fields

	// Ctors
	public GetPropertiesSecurityResponse(CommonInt.RestAPIResponseGetPropertiesSecurityPDF apiResponse)
	{
		super(apiResponse.documents[0]);
		CommonInt.RestAPIDocPropertiesSecurity exPropsSecurity = apiResponse.documents[0].extendedPropertiesSecurity;

		setDocPropertiesSecurity(new PDFDocPropertiesSecurityPassword(exPropsSecurity));
	}

	// Properties
	private DocPropertiesSecurity DocPropertiesSecurity;
	public final DocPropertiesSecurity getDocPropertiesSecurity()
	{
		return DocPropertiesSecurity;
	}
	public final void setDocPropertiesSecurity(DocPropertiesSecurity value)
	{
		DocPropertiesSecurity = value;
	}

	// Methods
}