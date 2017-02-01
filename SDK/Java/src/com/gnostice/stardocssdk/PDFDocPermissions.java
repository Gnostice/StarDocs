package com.gnostice.stardocssdk;

import org.json.JSONObject;

/** 
 Represents end-user restrictions for a PDF document.
*/
public class PDFDocPermissions extends DocPermissions
{
	// Fields

	// Ctors
	/** 
	 Creates a new instance of this class with specified
	 permissions.
	 @param allowAccessibility Whether end-user can extract text and graphics meant for use with applications such as those providing accessibility to people with disabilities. 
	 @param allowAssembly Whether end-users can assemble The document, including the ability to insert, rotate, or delete pages and create bookmarks or thumbnail images.
	 @param allowCopy Whether end-users can copy and extract all text and graphics (but not including those permitted by allowAccessibility).
	 @param allowFormFill Whether end-users can fill in existing form fields (including signature fields).
	 @param allowHighResPrint Whether the end-user can print the document in high resolution.
	 @param allowModifyAnnotations Whether the end-user can add and modify text annotations, fill in existing interactive form fields, and (if allowModifyContents is enabled) create new or modify existing Interactive form fields including signature fields. 
	 @param allowModifyContents Whether the end-user can modify the document in ways not including those allowed by allowModifyAnnotations, allowFormFill, and allowAssembly.
	 @param allowPrinting Whether the end-user can print the document. 
	*/

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy, boolean allowFormFill, boolean allowHighResPrint, boolean allowModifyAnnotations, boolean allowModifyContents)
	{
		this(allowAccessibility, allowAssembly, allowCopy, allowFormFill, allowHighResPrint, allowModifyAnnotations, allowModifyContents, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy, boolean allowFormFill, boolean allowHighResPrint, boolean allowModifyAnnotations)
	{
		this(allowAccessibility, allowAssembly, allowCopy, allowFormFill, allowHighResPrint, allowModifyAnnotations, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy, boolean allowFormFill, boolean allowHighResPrint)
	{
		this(allowAccessibility, allowAssembly, allowCopy, allowFormFill, allowHighResPrint, false, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy, boolean allowFormFill)
	{
		this(allowAccessibility, allowAssembly, allowCopy, allowFormFill, false, false, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy)
	{
		this(allowAccessibility, allowAssembly, allowCopy, false, false, false, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly)
	{
		this(allowAccessibility, allowAssembly, false, false, false, false, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility)
	{
		this(allowAccessibility, false, false, false, false, false, false, false);
	}

	public PDFDocPermissions()
	{
		this(false, false, false, false, false, false, false, false);
	}

	public PDFDocPermissions(boolean allowAccessibility, boolean allowAssembly, boolean allowCopy, boolean allowFormFill, boolean allowHighResPrint, boolean allowModifyAnnotations, boolean allowModifyContents, boolean allowPrinting)
	{
		super();
		setAllowAccessibility(allowAccessibility);
		setAllowAssembly(allowAssembly);
		setAllowCopy(allowCopy);
		setAllowFormFill(allowFormFill);
		setAllowHighResPrint(allowHighResPrint);
		setAllowModifyAnnotations(allowModifyAnnotations);
		setAllowModifyContents(allowModifyContents);
		setAllowPrinting(allowPrinting);
	}

	// Properties
	/** 
	 Gets or sets whether end-user can extract text and graphics
	 meant for use with applications such as those providing
	 accessibility to people with disabilities.
	*/
	private boolean allowAccessibility;
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
	private boolean allowAssembly;
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
	private boolean allowCopy;
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
	private boolean allowFormFill;
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
	private boolean allowHighResPrint;
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
	private boolean allowModifyAnnotations;
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
	private boolean allowModifyContents;
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
	private boolean allowPrinting;
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