package com.gnostice.stardocssdk;

import java.util.ArrayList;

import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.exceptions.UnirestException;

public class StarDocsException extends Exception
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static class DocErrorDetails
	{
		// Fields
		// Ctors
		public DocErrorDetails(String url)
		{
			setUrl(url);
		}
		// Properties
		private String Url;
		public final String getUrl()
		{
			return Url;
		}
		private void setUrl(String value)
		{
			Url = value;
		}

		// Methods
		@Override
		public String toString()
		{
			Object[] objs = new Object[] {super.toString(), getUrl()};
			return String.format("%1$s, Url=%2$s", objs);
		}
	}

	// Fields

	// Ctors
	public StarDocsException(int httpStatusCode, StarDocsErrorCode errorCode, String message)
	{
		super(message);
		setHttpStatusCode(httpStatusCode);
		setErrorCode(errorCode);
	}
	public StarDocsException(RuntimeException inner, int httpStatusCode, StarDocsErrorCode errorCode, String message)
	{
		super(message, inner);
		setHttpStatusCode(httpStatusCode);
		setErrorCode(errorCode);
	}
	public StarDocsException(int httpStatusCode, CommonInt.RestAPIFailureResponse apiResponse)
	{
		this(apiResponse);
		setHttpStatusCode(httpStatusCode);
	}

	public StarDocsException(CommonInt.RestAPIFailureResponse apiResponse)
	{
		super(apiResponse.errorMessage);
		setErrorCode(StarDocsErrorCode.forValue(apiResponse.errorCode));
		documents = new ArrayList<DocErrorDetails>();
		if (apiResponse.documents != null)
		{
			for (CommonInt.RestAPIDocumentError doc : apiResponse.documents)
			{
				documents.add(new DocErrorDetails(doc.url));
			}
		}
	}

	public StarDocsException(UnirestException e) 
	{
		super(e.getMessage(), e.getCause());
	}

	// Properties
	private int httpStatusCode;
	public final int getHttpStatusCode()
	{
		return httpStatusCode;
	}
	private final void setHttpStatusCode(int value)
	{
		httpStatusCode = value;
	}
	
	private StarDocsErrorCode errorCode;
	public final StarDocsErrorCode getErrorCode()
	{
		return errorCode;
	}
	private final void setErrorCode(StarDocsErrorCode value)
	{
		errorCode = value;
	}
	
	private ArrayList<DocErrorDetails> documents;
	public final ArrayList<DocErrorDetails> getDocuments()
	{
		return documents;
	}
	

	// Methods
	public static StarDocsException Create(int httpStatusCode, HttpResponse<JsonNode> apiResponse)
	{
		Gson gson = new Gson();
		String responseJSONString = apiResponse.getBody().toString();
		CommonInt.RestAPIFailureResponse parsedErrorResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIFailureResponse.class);
		return new StarDocsException(httpStatusCode, parsedErrorResponse);
	}

	@Override
	public String toString()
	{
		String strDocs = "";
		if (documents != null)
		{
			for (DocErrorDetails doc : documents)
			{
				strDocs += "|" + doc.toString() + "|";
			}
		}
		Object[] objs = new Object[] {super.toString(), getHttpStatusCode(), getErrorCode(), strDocs};
		return String.format("%1$s, HttpStatusCode=%2$s, ErrorCode=%3$s, DocErrors=%4$s", objs);
	}

}