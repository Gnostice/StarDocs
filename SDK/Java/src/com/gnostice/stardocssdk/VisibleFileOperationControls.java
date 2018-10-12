package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleFileOperationControls
{
	// Properties
	private boolean open = false;
	private boolean save = false;
	private boolean print = false;
	private boolean download = false;

	// Ctors
	/** 
	 Creates an instance of this class.
	*/
	public VisibleFileOperationControls()
	{
	}

	/** 
	 Gets or sets whether open-new-file button should be shown. 
	 This allows the user to open any file for viewing. Default is false.
	*/
	public final boolean getOpen()
	{
		return open;
	}
	public final void setOpen(boolean value)
	{
		open = value;
	}
	
	/** 
	 Gets or sets whether save button should be shown. 
	 This allows the user to save changes made to the document. Default is false.
	*/
	public final boolean getSave()
	{
		return save;
	}
	public final void setSave(boolean value)
	{
		save = value;
	}
	
	/** 
	 Gets or sets whether print button should be shown. 
	 This allows the user to print the file that is open in the viewer. Default is false.
	*/
	public final boolean getPrint()
	{
		return print;
	}
	public final void setPrint(boolean value)
	{
		print = value;
	}
	
	/** 
	 Gets or sets whether download button should be shown. 
	 This allows the user to download the file that is open in the viewer. Default is false.
	*/
	public final boolean getDownload()
	{
		return download;
	}
	public final void setDownload(boolean value)
	{
		download = value;
	}

	// Methods
	public final void EncodeJson(JSONObject jsonObj)
	{
		JSONObject jsonObjVisibleFileOperationControls = new JSONObject();
		jsonObjVisibleFileOperationControls.put("open", getOpen());
		jsonObjVisibleFileOperationControls.put("save", getSave());
		jsonObjVisibleFileOperationControls.put("print", getPrint());
		jsonObjVisibleFileOperationControls.put("download", getDownload());
		jsonObj.put("visibleFileOperationControls", jsonObjVisibleFileOperationControls);
	}
}