package com.gnostice.stardocssdk;

public class ViewResponse
{
	// Fields
	private String url;
	private long timeToLive;

	// Ctors
	public ViewResponse(CommonInt.RestAPIResponseCreateView apiResponse)
	{
		url = apiResponse.url;
		timeToLive = apiResponse.timeToLive;
	}

	// Properties
	public final String getUrl()
	{
		return url;
	}

	public final long getTimeToLive()
	{
		return timeToLive;
	}

	// Methods
	@Override
	public String toString()
	{
		Object[] objs = new Object[] {url, timeToLive};
		return String.format("Url=%1$s, TimeToLive=%2$s", objs);
	}
}