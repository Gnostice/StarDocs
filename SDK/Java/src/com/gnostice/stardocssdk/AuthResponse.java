package com.gnostice.stardocssdk;

public class AuthResponse
{
	// Fields

	// Ctors
	public AuthResponse(CommonInt.RestAPIAuthTokenSuccessResponse apiResponse)
	{
		setAccessToken(apiResponse.access_token);
		setTokenType(apiResponse.token_type);
		setExpiresIn(apiResponse.expires_in);
	}

	// Properties
	private String accessToken;
	public final String getAccessToken()
	{
		return accessToken;
	}
	public final void setAccessToken(String value)
	{
		accessToken = value;
	}

	private String tokenType;
	public final String getTokenType()
	{
		return tokenType;
	}
	public final void setTokenType(String value)
	{
		tokenType = value;
	}

	private long expiresIn;
	public final long getExpiresIn()
	{
		return expiresIn;
	}
	public final void setExpiresIn(long value)
	{
		expiresIn = value;
	}

	// Methods
	@Override
	public String toString()
	{
		return String.format("AccessToken=%1$s, TokenType=%2$s, ExpiresIn=%3$s", getAccessToken(), getTokenType(), getExpiresIn());
	}

}