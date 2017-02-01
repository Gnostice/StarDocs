package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents text search settings.
*/
public class SearchText
{
	// Fields

	// Ctors

	public SearchText(String text)
	{
		this(text, false, false);
	}

	public SearchText(String text, boolean caseSensitive)
	{
		this(text, caseSensitive, false);
	}

	public SearchText(String text, boolean caseSensitive, boolean wholeWord)
	{
		setText(text);
		setCaseSensitive(caseSensitive);
		setWholeWord(wholeWord);
	}

	// Properties
	/** 
	 Gets or sets text that needs to be searched.
	*/
	private String text;
	public final String getText()
	{
		return text;
	}
	public final void setText(String value)
	{
		text = value;
	}
	/** 
	 Gets or sets whether the search is case-sensitive.
	*/
	private boolean caseSensitive;
	public final boolean getCaseSensitive()
	{
		return caseSensitive;
	}
	public final void setCaseSensitive(boolean value)
	{
		caseSensitive = value;
	}
	/** 
	 Gets or sets whether the search is for &quot;whole-word&quot;
	 occurrences.
	*/
	private boolean wholeWord;
	public final boolean getWholeWord()
	{
		return wholeWord;
	}
	public final void setWholeWord(boolean value)
	{
		wholeWord = value;
	}

	// Methods

	public JSONObject toJson() 
	{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("text", getText());
		jsonObj.put("caseSensitive", getCaseSensitive());
		jsonObj.put("wholeWord", getWholeWord());
		return jsonObj;
	}

}