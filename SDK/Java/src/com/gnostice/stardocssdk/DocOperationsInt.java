package com.gnostice.stardocssdk;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.Iterator;

import org.apache.commons.lang3.time.StopWatch;
import org.apache.http.HttpStatus;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.mashape.unirest.request.GetRequest;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/

public class DocOperationsInt
{
	// Fields
	private StarDocs starDocs = null;

	// Ctors
	public DocOperationsInt(StarDocs starDocs)
	{
		this.starDocs = starDocs;
	}

	// Properties

	// Methods

	public final GetDocumentInfoResponse getDocumentInfo(FileObject file, String password) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		// Issue get doc info request
		String url = docUrl + "/info";
		if (password != null)
		{
			url = CommonInt.addUrlParam(url, "password", password);
		}
		
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "get", null);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPIResponseGetDocumentInfo parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIResponseGetDocumentInfo.class);
		return new GetDocumentInfoResponse(parsedResponse);
	}

	/*
	public final GetPropertiesResponse getProperties(FileObject file, String password)
	{
		return GetProperties(file, password, null);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: internal GetPropertiesResponse GetProperties(FileObject file, string password = null)
	public final GetPropertiesResponse getProperties(FileObject file, String password)
	{
		// If async, look for cancellation
		if (tokenHolder != null)
		{
			tokenHolder.CancellationToken.ThrowIfCancellationRequested();
		}
		String docUrl = CommonInt.GetDocUrl(starDocs, file);
		// If async, look for cancellation
		if (tokenHolder != null)
		{
			// Todo: Delete the uploaded file?
			tokenHolder.CancellationToken.ThrowIfCancellationRequested();
		}
		// Issue request
		String url = docUrl + "/properties";
		if (password != null)
		{
			url = CommonInt.AddUrlParam(url, "password", password);
		}

		IRestResponse response = IssueRequestAndPoll(url, Method.GET, null);
		// ToDo: Deserialize based on MimeType
		JsonDeserializer deSerializer = new JsonDeserializer();
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
		var parsedResponse = deSerializer.<CommonInt.RestAPIResponseGetPropertiesPDF>Deserialize(response);
		return new GetPropertiesResponse(parsedResponse);
	}


	public final DocObject setProperties(FileObject file, String password, DocProperties properties)
	{
		return SetProperties(file, password, properties, null);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: internal DocObject SetProperties(FileObject file, string password, DocProperties properties = null)
	public final DocObject setProperties(FileObject file, String password, DocProperties properties)
	{
		// If async, look for cancellation
		if (tokenHolder != null)
		{
			tokenHolder.CancellationToken.ThrowIfCancellationRequested();
		}
		String docUrl = CommonInt.GetDocUrl(starDocs, file);
		// If async, look for cancellation
		if (tokenHolder != null)
		{
			// Todo: Delete the uploaded file?
			tokenHolder.CancellationToken.ThrowIfCancellationRequested();
		}
		// Issue request
		String url = docUrl + "/properties";
		String jsonStr = "{" + properties.ToJson();
		if (starDocs.Preferences.DocPassword.ForceFullPermission)
		{
			jsonStr += ",\"forceFullPermission\":true";
		}
		if (password != null)
		{
			jsonStr += ",\"password\":\"" + password + "\"";
		}
		jsonStr += "}";

		IRestResponse response = IssueRequestAndPoll(url, Method.PUT, jsonStr);
		JsonDeserializer deSerializer = new JsonDeserializer();
//C# TO JAVA CONVERTER TODO TASK: There is no equivalent to implicit typing in Java:
		var parsedResponse = deSerializer.<CommonInt.RestAPISuccessResponseCommon>Deserialize(response);
		return new DocObject(parsedResponse.documents[0]);
	}
	*/

	/*
	internal GetPropertiesSecurityResponse getPropertiesSecurity(FileObject file, string password = null)
	{
	  // If async, look for cancellation
	  if (tokenHolder != null)
	  {
	    tokenHolder.CancellationToken.ThrowIfCancellationRequested();
	  }
	  string docUri = CommonInt.GetDocUrl(starDocs, file);
	  // If async, look for cancellation
	  if (tokenHolder != null)
	  {
	    // Todo: Delete the uploaded file?
	    tokenHolder.CancellationToken.ThrowIfCancellationRequested();
	  }
	  // Issue request
	  string jsonStr = "{\"operation\":\"getPropertiesExtended\",\"extendedProperty\":\"security\",\"documents\":[{\"uri\":\"" + docUri + "\"";
	  if (password != null)
	  {
	    jsonStr += ",\"password\":\"" + password + "\"";
	  }
	  jsonStr += "}]}";

	  var response = IssueRequestAndPoll(jsonStr);
	  JsonDeserializer deSerializer = new JsonDeserializer();
	  var parsedResponse = deSerializer.Deserialize<CommonInt.RestAPIResponseGetPropertiesSecurityPDF>(response);
	  var ret = new GetPropertiesSecurityResponse(parsedResponse);
	  return ret;
	}
	*/

	public final DocObject merge(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		for (FileObject file : files)
		{
			docUrls.add(CommonInt.getDocUrl(starDocs, file));
		}

		// Issue request
		JSONObject jsonRequest = new JSONObject(); 
		CommonInt.encodeJsonDocuments(jsonRequest, docUrls, passwords, pageRanges);

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/merge";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		return new DocObject(parsedResponse.documents[0]);
	}

	public final ArrayList<DocObject> splitByPageRange(FileObject file, String password, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		// Issue split by page range request
		JSONObject jsonDocument = new JSONObject();
		jsonDocument.put("url", docUrl);
		if (password != null)
		{
			jsonDocument.put("password", password);
		}
		if (pageRanges != null)
		{
			encodeJsonPageRanges(jsonDocument, pageRanges);
		}
		JSONArray jsonDocuments = new JSONArray();
		jsonDocuments.put(jsonDocument);
		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("documents", jsonDocuments);
		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/split-range";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	public final ArrayList<DocObject> splitBySeparatorPage(FileObject file, String password, PageSeparator pageSeparator) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		// Issue split by page range request
		JSONObject jsonDocument = new JSONObject();
		jsonDocument.put("url", docUrl);
		if (password != null)
		{
			jsonDocument.put("password", password);
		}

		if (pageSeparator == null)
		{
			pageSeparator = new PageSeparator(PageSeparatorType.EmptyPage);
		}
		pageSeparator.EncodeJson(jsonDocument);

		JSONArray jsonDocuments = new JSONArray();
		jsonDocuments.put(jsonDocument);
		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("documents", jsonDocuments);

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/split-separator";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	public final DocObject encrypt(FileObject file, String password, PDFEncryptionLevel pdfEncryptionLevel, String newOpenPassword, String newPermissionsPassword, DocPermissions newPermissions) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("encryptionLevel",  pdfEncryptionLevel.name());

		jsonRequest.put("password", password);
		jsonRequest.put("newOpenPassword", newOpenPassword);
		jsonRequest.put("newPermissionsPassword", newPermissionsPassword);

		if (newPermissions != null)
		{
			// Encode request based on type of parameter
			if (newPermissions.getClass() == PDFDocPermissions.class)
			{
				PDFDocPermissions newPermissionsPdf = (PDFDocPermissions)newPermissions;
				newPermissionsPdf.EncodeJson(jsonRequest, "newPermissions");
			}
		}
		String url = docUrl + "/ops/encrypt";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "put", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		return new DocObject(parsedResponse.documents[0]);
	}
	
	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, boolean removeAssociatedAnnotations, 
			RedactFillSettings fillSettings, EnumSet<DocumentItem> includeAdditionalItems, EnumSet<RedactCleanupSetting> cleanupSettings) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		// Issue redact text request
		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("searchMode", Utils.toCamelCase(textSearchMode.name()));
		jsonRequest.put("password", password);
		if (pageRange != null)
		{
			pageRange.encodeJson(jsonRequest, "pageRange", true);
		}

		encodeJsonSearchText(jsonRequest, searchText);
		jsonRequest.put("removeAssociatedAnnotations", removeAssociatedAnnotations);
		if (fillSettings != null)
		{
			fillSettings.encodeJson(jsonRequest);
		}
		// Encode includeAdditionalItems
		JSONObject jsonIncludeAdditionalItems = new JSONObject();
		jsonIncludeAdditionalItems.put("bookmarks", includeAdditionalItems.contains(DocumentItem.Bookmarks));
		jsonIncludeAdditionalItems.put("bookmarkActions", includeAdditionalItems.contains(DocumentItem.BookmarkActions));
		jsonIncludeAdditionalItems.put("annotations", includeAdditionalItems.contains(DocumentItem.Annotations));
		jsonIncludeAdditionalItems.put("annotationActions", includeAdditionalItems.contains(DocumentItem.AnnotationActions));
		jsonIncludeAdditionalItems.put("documentProperties", includeAdditionalItems.contains(DocumentItem.DocumentProperties));
		jsonRequest.put("includeAdditionalItems", jsonIncludeAdditionalItems);
		// Encode cleanupSettings
		JSONObject jsonCleanupSettings = new JSONObject();
		jsonCleanupSettings.put("removeEmptyBookmarks", cleanupSettings.contains(RedactCleanupSetting.RemoveEmptyBookmarks));
		jsonCleanupSettings.put("removeEmptyBookmarkActions", cleanupSettings.contains(RedactCleanupSetting.RemoveEmptyBookmarkActions));
		jsonCleanupSettings.put("removeEmptyAnnotations", cleanupSettings.contains(RedactCleanupSetting.RemoveEmptyAnnotations));
		jsonCleanupSettings.put("removeEmptyAnnotationActions", cleanupSettings.contains(RedactCleanupSetting.RemoveEmptyAnnotationActions));
		jsonCleanupSettings.put("removeAffectedLinkActions", cleanupSettings.contains(RedactCleanupSetting.RemoveAffectedLinkActions));
		jsonRequest.put("cleanupSettings", jsonCleanupSettings);

		String url = docUrl + "/ops/redact-text";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "put", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		return new DocObject(parsedResponse.documents[0]);
	}

	public final DocObject fillForm(FileObject file, String password, ArrayList<PDFFormFieldFillData> formFields, boolean flattenAllFields) throws URISyntaxException, StarDocsException
	{
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		// Issue form fill request
		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("password", password);
		if (formFields != null)
		{
			encodeJsonFormFieldFillData(jsonRequest, formFields);
		}
		jsonRequest.put("flattenAllFields", flattenAllFields);

		String url = docUrl + "/ops/fill-form";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "put", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		return new DocObject(parsedResponse.documents[0]);
	}

	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings, TIFFCompressionType tiffCompressionType) throws URISyntaxException, StarDocsException
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		for (FileObject file : files)
		{
			docUrls.add(CommonInt.getDocUrl(starDocs, file));
		}

		// Issue convert request
		JSONObject jsonRequest = new JSONObject();
		CommonInt.encodeJsonDocuments(jsonRequest, docUrls, passwords, pageRanges);
		if (imageEncoderSettings != null)
		{
			imageEncoderSettings.encodeJson(jsonRequest);
		}
		jsonRequest.put("tiffCompressionType", Utils.toCamelCase(tiffCompressionType.name()));

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/convert-tiff";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings, TIFFCompressionType tiffCompressionType, MTIFFConversionMode conversionMode) throws URISyntaxException, StarDocsException
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		for (FileObject file : files)
		{
			docUrls.add(CommonInt.getDocUrl(starDocs, file));
		}

		// Issue convert request
		JSONObject jsonRequest = new JSONObject();
		CommonInt.encodeJsonDocuments(jsonRequest, docUrls, passwords, pageRanges);
		if (imageEncoderSettings != null)
		{
			imageEncoderSettings.encodeJson(jsonRequest);
		}
		jsonRequest.put("tiffCompressionType", Utils.toCamelCase(tiffCompressionType.name()));
		jsonRequest.put("conversionMode", Utils.toCamelCase(conversionMode.name()));

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/convert-mtiff";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	public final ArrayList<DocObject> convertToJPEG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToImage("convert-jpeg", files, passwords, pageRanges, imageEncoderSettings);
	}

	public final ArrayList<DocObject> convertToGIF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToImage("convert-gif", files, passwords, pageRanges, imageEncoderSettings);
	}

	public final ArrayList<DocObject> convertToBMP(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToImage("convert-bmp", files, passwords, pageRanges, imageEncoderSettings);
	}

	public final ArrayList<DocObject> convertToPNG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToImage("convert-png", files, passwords, pageRanges, imageEncoderSettings);
	}

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			PDFEncoderSettings pdfEncoderSettings, ConversionMode conversionMode,
			ConverterDigitizerSettings digitizerSettings) throws URISyntaxException, StarDocsException
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		for (FileObject file : files)
		{
			docUrls.add(CommonInt.getDocUrl(starDocs, file));
		}

		// Issue convert request
		JSONObject jsonRequest = new JSONObject();
		CommonInt.encodeJsonDocuments(jsonRequest, docUrls, passwords, pageRanges);
		if (pdfEncoderSettings != null)
		{
			pdfEncoderSettings.encodeJson(jsonRequest);
		}
		jsonRequest.put("conversionMode", Utils.toCamelCase(conversionMode.name()));
		if (digitizerSettings != null)
		{
			digitizerSettings.encodeJson(jsonRequest);
		}

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/convert-pdf";
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	public final ArrayList<DocObject> convertToImage(String urlPart, ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		ArrayList<String> docUrls = new ArrayList<String>();
		for (FileObject file : files)
		{
			docUrls.add(CommonInt.getDocUrl(starDocs, file));
		}

		// Issue convert request
		JSONObject jsonRequest = new JSONObject();
		CommonInt.encodeJsonDocuments(jsonRequest, docUrls, passwords, pageRanges);
		if (imageEncoderSettings != null)
		{
			imageEncoderSettings.encodeJson(jsonRequest);
		}

		String url = starDocs.getConnectionInfo().getApiServerUrl().toString() + "/docs/ops/" + urlPart;
		HttpResponse<JsonNode> response = IssueRequestAndPoll(url, "post", jsonRequest);
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		ArrayList<DocObject> ret = new ArrayList<DocObject>();
		for (CommonInt.RestAPIDocumentCommon doc : parsedResponse.documents)
		{
			DocObject docObj = new DocObject(doc);
			ret.add(docObj);
		}
		return ret;
	}

	private void encodeJsonSearchText(JSONObject jsonObj, ArrayList<SearchText> searchTextList)
	{
		if (searchTextList == null)
		{
			return;
		}

		JSONArray jsonSearchTextList = new JSONArray();
		Iterator<SearchText> iter = searchTextList.iterator();
		while (iter.hasNext())
		{
			SearchText searchText = iter.next();
			jsonSearchTextList.put(searchText.toJson());
		}
		jsonObj.put("searchText", jsonSearchTextList);
	}

	private void encodeJsonPageRanges(JSONObject jsonObj, ArrayList<PageRangeSettings> pageRangeSettingsList)
	{
		if (pageRangeSettingsList == null)
		{
			return;
		}

		JSONArray pageRanges = new JSONArray();
		Iterator<PageRangeSettings> iter = pageRangeSettingsList.iterator();
		while (iter.hasNext())
		{
			PageRangeSettings pageRangeSettings = iter.next();
			pageRanges.put(pageRangeSettings.toJson(false));
		}
		jsonObj.put("pageRanges", pageRanges);
	}
	
	private void encodeJsonFormFieldFillData(JSONObject jsonObj, ArrayList<PDFFormFieldFillData> formFields)
	{
		JSONArray jsonFields = new JSONArray();
		Iterator<PDFFormFieldFillData> iter = formFields.iterator();
		while (iter.hasNext())
		{
			PDFFormFieldFillData formField = iter.next();
			JSONObject jsonField = new JSONObject();
			jsonField.put("fieldName", formField.getFieldName());
			jsonField.put("fieldValue", formField.getFieldValue());
			jsonField.put("flattenField", formField.getFlattenField());
		}
		jsonObj.put("fields", jsonFields);
	}

	private HttpResponse<JsonNode> IssueRequestAndPoll(String url, String httpMethod, JSONObject jsonRequest) throws URISyntaxException, StarDocsException 
	{
		Boolean forceFullPermission = starDocs.getPreferences().getDocPassword().getForceFullPermission();
		HttpResponse<JsonNode> response;
		try
		{
			if (httpMethod.equalsIgnoreCase("post"))
			{
				jsonRequest.put("forceFullPermission", forceFullPermission);
				response = Unirest.post(url)
						.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
						.header("Content-Type", "application/json; charset=utf-8")
						.body(jsonRequest)
						.asJson();
			}
			else if (httpMethod.equalsIgnoreCase("put"))
			{
				jsonRequest.put("forceFullPermission", forceFullPermission);
				response = Unirest.put(url)
						.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
						.header("Content-Type", "application/json; charset=utf-8")
						.body(jsonRequest)
						.asJson();
			}
			else
			{
				url = CommonInt.addUrlParam(url, "force-full-permission", forceFullPermission);
				response = Unirest.get(url)
						.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
						.asJson();
			}
			int httpStatus = response.getStatus(); 
			if (httpStatus == HttpStatus.SC_OK || httpStatus == HttpStatus.SC_CREATED)
			{
				// Poll not required, return response
				return response;
			}
			else if (httpStatus != HttpStatus.SC_ACCEPTED)
			{
				Gson gson = new Gson();
				String responseJSONString = response.getBody().toString();
				CommonInt.RestAPIFailureResponse parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIFailureResponse.class);
				throw new StarDocsException(httpStatus, parsedResponse);
			}

			// Get the job URI and start polling for completion
			String fullJobUri = response.getHeaders().getFirst("Location");
			fullJobUri = CommonInt.addUrlParam(fullJobUri, "force-full-permission", forceFullPermission);
			GetRequest pollRequest = Unirest.get(fullJobUri)
					.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()));

			long sleepTime = starDocs.getConnectionInfo().getPollInterval();
			long docOperationTimeout = starDocs.getConnectionInfo().getDocOperationTimeout();
			StopWatch stopWatch = new StopWatch();
			while (true)
			{
				Thread.sleep(sleepTime);
				response = pollRequest.asJson();

				httpStatus = response.getStatus(); 
				if (httpStatus == HttpStatus.SC_OK || httpStatus == HttpStatus.SC_CREATED)
				{
					// Return the JSON response
					return response;
				}
				else if (httpStatus != HttpStatus.SC_ACCEPTED)
				{
					Gson gson = new Gson();
					String responseJSONString = response.getBody().toString();
					CommonInt.RestAPIFailureResponse parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIFailureResponse.class);
					throw new StarDocsException(httpStatus, parsedResponse);
				}

				// Check if operation is taking too long
				if (docOperationTimeout > 0)
				{
					long elapsedTimeSecs = stopWatch.getNanoTime() / 1000;
					if (elapsedTimeSecs > docOperationTimeout)
					{
						throw new StarDocsException(0, StarDocsErrorCode.OperationTimedOut, "The server is taking too long. Try increasing the timeout value.");
					}
				}
			}
		} 
		catch (UnirestException e) 
		{
			throw new StarDocsException(e);
		} 
		catch (InterruptedException e) 
		{
			throw new StarDocsException(0, StarDocsErrorCode.OperationTimedOut, "Sleep interrupted.");
		}
	}

}