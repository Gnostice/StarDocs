package com.gnostice.stardocssdk;

import org.apache.http.HttpStatus;

import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.mashape.unirest.request.HttpRequestWithBody;
import com.mashape.unirest.request.body.MultipartBody;

public class AuthInt
{
	private StarDocs starDocs = null;

	public AuthInt(StarDocs starDocs)
	{
		this.starDocs = starDocs;
	}

	public final AuthResponse loginApp(String entityId) throws StarDocsException
	{
		// Set timeouts
		Unirest.setTimeouts(starDocs.getConnectionInfo().getConnectionTimeout(), starDocs.getConnectionInfo().getServerTimeout());

		String url = starDocs.getConnectionInfo().getApiServerUrl() + "/auth/token";
		HttpRequestWithBody request = 
			Unirest
			.post(url)
			.basicAuth(starDocs.getConnectionInfo().getApiKey(), starDocs.getConnectionInfo().getApiSecret());
		if (entityId != null)
		{
			request = request.queryString("entity_id", entityId);
		}
		MultipartBody requestNext = request.field("grant_type", "client_credentials");
		try 
		{
			Gson gson = new Gson();
			HttpResponse<JsonNode> response = requestNext.asJson();
			String responseJSONString = response.getBody().toString();
			if (response.getStatus() != HttpStatus.SC_OK)
			{
				starDocs.setAuthResponse(null);
				CommonInt.RestAPIAuthTokenFailureResponse parsedErrorResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIAuthTokenFailureResponse.class);
				throw new StarDocsException(response.getStatus(), StarDocsErrorCode.forValue(0), parsedErrorResponse.error + ":" + parsedErrorResponse.error_description + ":" + parsedErrorResponse.error_uri);
			}
			CommonInt.RestAPIAuthTokenSuccessResponse parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPIAuthTokenSuccessResponse.class);
			AuthResponse authResponse = new AuthResponse(parsedResponse);
			starDocs.setAuthResponse(authResponse);
			return authResponse;
		} 
		catch (UnirestException e) 
		{
			throw new StarDocsException(e);
		}
	}

	public final AuthResponse loginUser()
	{
		// Set timeouts
		Unirest.setTimeouts(starDocs.getConnectionInfo().getConnectionTimeout(), starDocs.getConnectionInfo().getServerTimeout());
		throw new UnsupportedOperationException();
	}
}