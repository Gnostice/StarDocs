package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents end-user restrictions for a PDF document.
*/
public class PDFDocPermissions extends DocPermissions
{
	// Properties
	private boolean allowAccessibility = false;
	private boolean allowAssembly = false;
	private boolean allowCopy = false;
	private boolean allowFormFill = false;
	private boolean allowHighResPrint = false;
	private boolean allowModifyAnnotations = false;
	private boolean allowModifyContents = false;
	private boolean allowPrinting = false;

	// Ctors
	public PDFDocPermissions()
	{
	}

	/** 
	 Gets or sets whether end-user can extract text and graphics
	 meant for use with applications such as those providing
	 accessibility to people with disabilities.
	*/
	public final boolean getAllowAccessibility()
	{
		return allowAccessibility;
	}
	public final void setAllowAccessibility(boolean value)
	{
		allowAccessibility = value;
	}
	
	/** 
	 Gets or sets whether end-users can &quot;assemble&quot; the
	 document, including the ability to insert, rotate, or delete
	 pages and create bookmarks or thumbnail images.
	*/
	public final boolean getAllowAssembly()
	{
		return allowAssembly;
	}
	public final void setAllowAssembly(boolean value)
	{
		allowAssembly = value;
	}
	
	/** 
	 Gets or sets whether end-users can copy and extract all text
	 and graphics (but not including those permitted by <see cref="Gnostice.StarDocsSDK.PDFDocPermissions.AllowAccessibility" text="AllowAccessibility" />.
	*/
	public final boolean getAllowCopy()
	{
		return allowCopy;
	}
	public final void setAllowCopy(boolean value)
	{
		allowCopy = value;
	}
	
	/** 
	 Gets or sets whether end-users can fill in existing form
	 fields (including signature fields).
	*/
	public final boolean getAllowFormFill()
	{
		return allowFormFill;
	}
	public final void setAllowFormFill(boolean value)
	{
		allowFormFill = value;
	}
	
	/** 
	 Gets or sets whether the end-user can print the document in
	 high resolution.
	*/
	public final boolean getAllowHighResPrint()
	{
		return allowHighResPrint;
	}
	public final void setAllowHighResPrint(boolean value)
	{
		allowHighResPrint = value;
	}

	/** 
	 Gets or sets whether the end-user can add and modify text
	 annotations, fill in existing interactive form fields, and
	 (if <see cref="Gnostice.StarDocsSDK.PDFDocPermissions.AllowModifyContents" text="AllowModifyContents" />
	 is enabled) create new or modify existing interactive form
	 fields including signature fields.
	*/
	public final boolean getAllowModifyAnnotations()
	{
		return allowModifyAnnotations;
	}
	public final void setAllowModifyAnnotations(boolean value)
	{
		allowModifyAnnotations = value;
	}
	/** 
	 Gets or sets whether the end-user can modify the document in
	 ways not including those allowed by AllowModifyAnnotations,
	 AllowFormFill, and AllowAssembly.
	*/
	public final boolean getAllowModifyContents()
	{
		return allowModifyContents;
	}
	public final void setAllowModifyContents(boolean value)
	{
		allowModifyContents = value;
	}
	/** 
	 Gets or sets whether the end-user can print the document.
	*/
	public final boolean getAllowPrinting()
	{
		return allowPrinting;
	}
	public final void setAllowPrinting(boolean value)
	{
		allowPrinting = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj, String key)
	{
		JSONObject jsonPermissions = new JSONObject();
		jsonPermissions.put("allowAccessibility", getAllowAccessibility());
		jsonPermissions.put("allowAssembly", getAllowAssembly());
		jsonPermissions.put("allowCopy", getAllowCopy());
		jsonPermissions.put("allowFormFill", getAllowFormFill());
		jsonPermissions.put("allowHighResPrint", getAllowHighResPrint());
		jsonPermissions.put("allowModifyAnnotations", getAllowModifyAnnotations());
		jsonPermissions.put("allowModifyContents", getAllowModifyContents());
		jsonPermissions.put("allowPrinting", getAllowPrinting());
		jsonObj.put(key, jsonPermissions);
	}
}