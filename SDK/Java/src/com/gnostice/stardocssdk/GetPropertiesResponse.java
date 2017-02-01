package com.gnostice.stardocssdk;

import java.util.*;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


public class GetPropertiesResponse extends DocObject
{
	// Fields
	private DocProperties docProperties;

	// Ctors
	public GetPropertiesResponse(CommonInt.RestAPIResponseGetPropertiesPDF apiResponse)
	{
		super(apiResponse.document);
		CommonInt.RestAPIDocPropertiesCommon commonProps = apiResponse.document.properties;
		CommonInt.RestAPIDocExPropertiesPDF exProps = apiResponse.document.extendedProperties;

		// Parse the semi-colon-seperated keywords into a list
		ArrayList<String> keywords = new ArrayList<String>(commonProps.keywords.split("[;]", -1));
		docProperties = new PDFDocProperties(commonProps.title, commonProps.author, commonProps.subject, keywords, commonProps.creator, commonProps.producer, exProps.hasBookmarks);
	}


	// Properties
	public final DocProperties getDocProperties()
	{
		return docProperties;
	}

	// Methods
	@Override
	public String toString()
	{
		Object[] objs = new Object[] {super.toString(), docProperties.toString()};
		return String.format("%1$s, DocProperties=%2$s", objs);
	}

}