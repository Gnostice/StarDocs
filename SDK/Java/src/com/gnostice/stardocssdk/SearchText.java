package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents text search settings.
*/
public class SearchText
{
	// Properties
	private String text;
	private boolean caseSensitive;
	private boolean wholeWord;
	private boolean includeOnlyCapturingGroups;

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

	public SearchText(String text, boolean caseSensitive, boolean wholeWord, boolean includeOnlyCapturingGroups)
	{
		setText(text);
		setCaseSensitive(caseSensitive);
		setWholeWord(wholeWord);
		setIncludeOnlyCapturingGroups(includeOnlyCapturingGroups);
	}

	/** 
	 Gets or sets text that needs to be searched.
	*/
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
	public final boolean getWholeWord()
	{
		return wholeWord;
	}
	public final void setWholeWord(boolean value)
	{
		wholeWord = value;
	}

	/** 
	 Gets or sets whether only capturing groups in the regex should be considered. 
	 This setting is applicable only for searches based on regex.
	*/
	public final boolean getIncludeOnlyCapturingGroups()
	{
		return includeOnlyCapturingGroups;
	}
	public final void setIncludeOnlyCapturingGroups(boolean value)
	{
		includeOnlyCapturingGroups = value;
	}

	// Methods

	public JSONObject toJson() 
	{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("text", getText());
		jsonObj.put("caseSensitive", getCaseSensitive());
		jsonObj.put("wholeWord", getWholeWord());
		jsonObj.put("includeOnlyCapturingGroups", getIncludeOnlyCapturingGroups());
		return jsonObj;
	}
}