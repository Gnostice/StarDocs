package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Defines exception status codes.
*/
public enum StarDocsErrorCode
{
	/** 
	 A general error. See error message for details.
	*/
	GeneralError(1000),

	/** 
	 Something is wrong with the incoming request. Error message may contain details.
	*/
	BadRequest(1010),

	/** 
	 Something is wrong with the specified document. It may either be corrupted or StarDocs is unable to process it.
	*/
	BadDocument(1011),

	/** 
	 The document is protected by a password and either no passowrd is 
	 supplied or the supplied password is incorrect.
	*/
	PasswordRequired(1020),

	/** 
	 The document is in a format which is not currently supported for 
	 the requested operation.
	*/
	UnsupportedDocumentFormat(1030),

	/** 
	 The caller does not have sufficient rights on the document to 
	 perform the requested operation. 
	*/
	InsufficientRights(1040),

	/** 
	 The specified job cannot be found on the server.
	*/
	UnknownJob(1050),

	/** 
	 The specified document does not exist on the server.
	*/
	UnknownDocument(1051),

	/** 
	 The specified page does not exist.
	*/
	UnknownPage(1052),

	/** 
	 The specified user does not exist.
	*/
	UnknownUser(1053),

	/** 
	 The supplied API key is not valid.
	*/
	InvalidApiKey(1054),

	/** 
	 The document is in a format which is not currently supported for the requested operation.
	*/
	UnsupportedOperationForFormat(1060),

	/** 
	 The document storage quota is exhausted for the license (account).
	*/
	ExhaustedStorageQuotaForLicense(1070),

	/** 
	 The document storage quota is exhausted for the user.
	*/
	ExhaustedStorageQuotaForUser(1071),

	/** 
	 The document storage quota is exhausted for the app.
	*/
	ExhaustedStorageQuotaForApp(1072),

	/** 
	 The uploaded size is over the limit for the license (account).
	*/
	UploadSizeOverlimitForLicense(1080),

	/** 
	 The uploaded size is over the limit for the user.
	*/
	UploadSizeOverlimitForUser(1081),

	/** 
	 The uploaded size is over the limit for the app.
	*/
	UploadSizeOverlimitForApp(1082),

	/** 
	 The usage quota (number of pages) is exhausted for the app. 
	*/
	ExhaustedUsageQuotaForApp(1090),

	/** 
	 The usage quota (number of pages) is exhausted for the license (account). 
	 Please wait for the next subscription cycle or upgrade to the next tier.
	*/
	ExhaustedUsageQuotaForLicense(1091),

	/** 
	 The subscripton amount is unpaid and has therefore been suspended. 
	 Please check and make payment to enable operations.
	*/
	SubscriptionPaymentFailure(1092),

	/** 
	 The time-limited trial period has ended. 
	 Please purchase a paid license.
	*/
	SubscriptionTrialLicenseExpired(1100),

	/** 
	 There is something wrong with our server and we hate it if you see this. 
	 Please let us know so we can squash this bug immediately!
	*/
	InternalError(2000),

	/** 
	 The server has sent an unexpected response.
	 Please let us know so we can squash this bug immediately!
	*/
	UnexpectedResponse(10000),

	/** 
	 Operation has timed-out.
	 Try increasing the timeout value.
	 Please let us know if you continue to see.
	*/
	OperationTimedOut(10001);

	private int intValue;
	private static java.util.HashMap<Integer, StarDocsErrorCode> mappings;
	private static java.util.HashMap<Integer, StarDocsErrorCode> getMappings()
	{
		if (mappings == null)
		{
			synchronized (StarDocsErrorCode.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, StarDocsErrorCode>();
				}
			}
		}
		return mappings;
	}

	private StarDocsErrorCode(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static StarDocsErrorCode forValue(int value)
	{
		return getMappings().get(value);
	}
}