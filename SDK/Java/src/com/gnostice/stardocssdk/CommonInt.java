package com.gnostice.stardocssdk;

import java.net.URISyntaxException;
import java.util.ArrayList;

import org.apache.http.client.utils.URIBuilder;
import org.json.JSONArray;
import org.json.JSONObject;

public class CommonInt
{
	/* Classes to contain the deserialized objects from the Rest API response */
	public static class RestAPIDocPropertiesCommon
	{
		public String title;
		public String author;
		public String subject;
		public String keywords;
		public String creator;
		public String producer;
	}

	public static class RestAPIDocExPropertiesPDF
	{
		public boolean hasBookmarks;
		public boolean hasSecurity;
	}

	public static class RestAPIDocumentCommon
	{
		public String url;
		public String mimeType;
		public String fileName;
		public int fileSize;
		public Integer pageCount = null;
		public Long fileExpiry = null;
	}

	public static class RestAPIDocumentGetPropertiesPDF extends RestAPIDocumentCommon
	{
		public RestAPIDocPropertiesCommon properties;
		public RestAPIDocExPropertiesPDF extendedProperties;
	}

	public static class RestAPIDocPermissionsPDF
	{
		public boolean allowAssembly;
		public boolean allowModifyAnnotations;
		public boolean allowCopy;
		public boolean allowModifyContents;
		public boolean allowAccessibility;
		public boolean allowPrinting;
		public boolean allowHighResPrint;
		public boolean allowFormFill;
	}

	public static class RestAPIDocPropertiesSecurity
	{
		public String securityMethod;
		public String encryptionLevel;
		public String suppliedPassword;
		public boolean hasOpenPassword;
		public boolean hasPermissionsPassword;
		public RestAPIDocPermissionsPDF permissions;
	}

	public static class RestAPIDocumentGetPropertiesSecurityPDF extends RestAPIDocumentCommon
	{
		public RestAPIDocPropertiesSecurity extendedPropertiesSecurity;
	}

	public static class RestAPIRect
	{
		public float x;
		public float y;
		public float width;
		public float height;
	}
	
	public static class RestAPIBoundingRect
	{
		public int pageNum;
		public RestAPIRect rect;
	}
	
	public static class RestAPISearchHit
	{
		public String matchText;
		public String foundIn;
		public int startPageNum;
		public String lineContainingText;
		public int indexOfTextInLine;
		public RestAPIBoundingRect[] boundingRects;
	}
	
	public static class RestAPISearchTextResult
	{
		public String text;
		public RestAPISearchHit[] hits;
	}
	
	public static class RestAPISearchTextResponse
	{
		public RestAPISearchTextResult[] results;
	}
	
	public static class RestAPIAuthTokenSuccessResponse
	{
		public String access_token;
		public String token_type;
		public long expires_in;
	}
	public static class RestAPIAuthTokenFailureResponse
	{
		public String error;
		public String error_description;
		public String error_uri;
	}
	public static class RestAPISuccessResponseCommon
	{
		public RestAPIDocumentCommon[] documents;
	}
	
	// Assumed response just to check for error
	public static class RestAPIDocumentError
	{
		public String url;
		public int docStatusCode;
		public String docErrorMessage;
	}
	public static class RestAPIFailureResponse
	{
		public int errorCode;
		public String errorMessage;
		public ArrayList<RestAPIDocumentError> documents;
	}

	public static class RestAPIResponseGetDocumentInfo extends RestAPIDocumentCommon
	{
		public boolean unsupportedMimeTypeOrCorrupt;
		public boolean passwordProtected;
		public boolean passwordCorrect;
	}

	public static class RestAPIResponseGetPropertiesPDF
	{
		public RestAPIDocumentGetPropertiesPDF document;
	}

	public static class RestAPIResponseGetPropertiesSecurityPDF
	{
		public ArrayList<RestAPIDocumentGetPropertiesSecurityPDF> documents;
	}

	public static class RestAPIResponseCreateView
	{
		public String url;
		public long timeToLive;
	}

	// Uploads the local file and/or returns the full document URI
	public static String getDocUrl(StarDocs starDocs, FileObject file) throws URISyntaxException, StarDocsException
	{
		if (file.getFileUploaded())
		{
			return file.getFileUrl().toString();
		}

		// Todo: Deal with stream
		if (file.getStream() != null)
		{
			return starDocs.storage.upload(file.getStream(), file.getStreamFileName()).getFileUrl().toString();
		}

		return starDocs.storage.upload(file.getLocalFilePath()).getFileUrl().toString();
	}

	// Add URL param to URL and returns the modified URL
	public static String addUrlParam(String url, String key, Object value) throws URISyntaxException
	{
		URIBuilder uriBuilder = new URIBuilder(url);
		uriBuilder.setParameter(key, value.toString());
		return uriBuilder.toString();
	}

	public static void encodeJsonDocuments(JSONObject jsonObject, String docUrl, String password)
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		docUrls.add(docUrl);
		ArrayList<String> docPasswords = new ArrayList<String>();
		docPasswords.add(password);
		encodeJsonDocuments(jsonObject, docUrls, docPasswords);
	}

	public static void encodeJsonDocuments(JSONObject jsonObject, ArrayList<String> docUrls, ArrayList<String> passwords)
	{
		encodeJsonDocuments(jsonObject, docUrls, passwords, null);
	}

	public static void encodeJsonDocuments(JSONObject jsonObj, ArrayList<String> docUrls, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges)
	{
		JSONArray jsonArray = new JSONArray();
		for (int index = 0; index < docUrls.size(); ++index)
		{
			JSONObject jsonObjDocument = new JSONObject(); 
			jsonObjDocument.put("url", docUrls.get(index));
			if (passwords != null && index < passwords.size())
			{
				jsonObjDocument.put("password", passwords.get(index));
			}
			if (pageRanges != null && index < pageRanges.size())
			{
				PageRangeSettings pageRangeSettings = pageRanges.get(index);
				if (pageRangeSettings != null)
				{
					pageRangeSettings.encodeJson(jsonObjDocument, "pageRange", false);
				}
			}
			jsonArray.put(jsonObjDocument);
		}
		jsonObj.put("documents", jsonArray);
	}
}