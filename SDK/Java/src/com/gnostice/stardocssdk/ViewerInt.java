package com.gnostice.stardocssdk;

import java.io.InputStream;
import java.net.URISyntaxException;

import org.apache.http.HttpStatus;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

public class ViewerInt
{
	private StarDocs starDocs;

	public ViewerInt(StarDocs starDocs)
	{
		this.starDocs = starDocs;
	}

	/*
	public final ViewResponse CreateView(FileObject file, String password, ViewerSettings viewerSettings)
	{
		return CreateView(file, password, viewerSettings, null);
	}*/

	public final ViewResponse createView(FileObject file, String password, ViewerSettings viewerSettings, Integer timeToLiveSecs) throws StarDocsException, URISyntaxException
	{
		// Get the document url
		String docUrl = CommonInt.getDocUrl(starDocs, file);
		
		JSONObject jsonRequest = new JSONObject();
		CommonInt.encodeJsonDocuments(jsonRequest, docUrl, password);
		if (timeToLiveSecs != null)
		{
			jsonRequest.put("timeToLiveSecs", timeToLiveSecs);
		}
		jsonRequest.put("forceFullPermission", starDocs.getPreferences().getDocPasswordSettings().getForceFullPermission());
		if (viewerSettings != null)
		{
			viewerSettings.EncodeJson(jsonRequest);
		}
		String url = starDocs.getConnectionInfo().getApiServerUrl() + "/viewsessions";
		HttpResponse<JsonNode> response;
		try 
		{
			response = Unirest.post(url)
				.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
				.header("Content-Type", "application/json; charset=utf-8")
				.body(jsonRequest)
				.asJson();
		} 
		catch (UnirestException e) 
		{
			throw new StarDocsException(e);
		}

		if (response.getStatus() != HttpStatus.SC_OK)
		{
			throw StarDocsException.Create(response.getStatus(), response);
		}

		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPIResponseCreateView parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIResponseCreateView.class);
		return new ViewResponse(parsedResponse);
	}

	public final void deleteView(ViewResponse viewResponse) throws StarDocsException
	{
		HttpResponse<InputStream> response;
		try 
		{
			response = Unirest
			.delete(viewResponse.getUrl().toString())
			.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
			.asBinary();
		}
		catch (UnirestException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}

		int statusCode = response.getStatus(); 
		if (statusCode != HttpStatus.SC_OK && statusCode != HttpStatus.SC_NO_CONTENT)
		{
			String statusText = response.getStatusText();
			throw new StarDocsException(statusCode, null, statusText);
		}
	}
}