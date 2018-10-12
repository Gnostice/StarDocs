package com.gnostice.stardocssdk;

import java.net.URI;
import java.net.URISyntaxException;

import com.mashape.unirest.http.Unirest;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/

/** 
 Represents connection information to the REST server.
*/
public class ConnectionInfo
{
	//private String apiServerVersion;
	private URI apiServerUrl;
	private String apiKey;
	private String apiSecret;
	private long connectionTimeout = 10 * 1000;
	private long serverTimeout = 10 * 60 * 1000;
	private long docOperationTimeout = -1;
	private long pollInterval = 1000;

	/** 
	 Gets or sets information required to connect with the REST API server.
	 @param apiServerUrl Address on the server where the REST API can be accessed.
	 @param apiKey Key used to access the REST API.
	 @param apiSecret API key password.
	 @param serverTimeout Timeout for receiving response from the REST API server.
	 @param docOperationTimeout Timeout for document operations.     
	*/
	public ConnectionInfo()
	{
		try 
		{
			apiServerUrl = new URI("");
		} 
		catch (URISyntaxException e) 
		{
			// Can never happen
		}
	}

	/** 
	 Gets or sets address on the server where the REST API can be accessed.
	*/
	public final URI getApiServerUrl()
	{
		return apiServerUrl;
	}
	public final void setApiServerUrl(URI value)
	{
		this.apiServerUrl = value;
	}
	/** 
	 Gets or sets key used to access the REST API.
	*/
	public final String getApiKey()
	{
		return apiKey;
	}
	public final void setApiKey(String value)
	{
		this.apiKey = value;
	}
	/** 
	 Gets or sets API key password.
	*/
	public final String getApiSecret()
	{
		return apiSecret;
	}
	public final void setApiSecret(String value)
	{
		this.apiSecret = value;
	}

	/** 
	 Gets or sets timeout (in milliseconds) for receiving response from the REST API server.
	*/
	public final long getServerTimeout()
	{
		return serverTimeout;
	}
	public final void setServerTimeout(long value)
	{
		this.serverTimeout = value;
		// Set timeouts
		Unirest.setTimeouts(this.getConnectionTimeout(), this.getServerTimeout());
	}

	/** 
	 Gets or set timeout (in milliseconds) for document operations.
	*/
	public final long getDocOperationTimeout()
	{
		return docOperationTimeout;
	}
	public final void setDocOperationTimeout(long value)
	{
		this.docOperationTimeout = value;
	}

	/** 
	 Gets or sets polling interval (in milliseconds) for document operations.
	*/
	public final long getPollInterval()
	{
		return pollInterval;
	}
	public final void setPollInterval(long value)
	{
		pollInterval = value;
	}

	public final long getConnectionTimeout()
	{
		return connectionTimeout;
	}
}