package com.gnostice.stardocssdk;

import org.json.JSONObject;

public class VisibleFileOperationControls
{
	// Fields

	// Ctors
	/** 
	 Creates an instance of this class.
	*/

	public VisibleFileOperationControls(boolean open, boolean save, boolean print)
	{
		this(open, save, print, false);
	}

	public VisibleFileOperationControls(boolean open, boolean save)
	{
		this(open, save, false, false);
	}

	public VisibleFileOperationControls(boolean open)
	{
		this(open, false, false, false);
	}

	public VisibleFileOperationControls()
	{
		this(false, false, false, false);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: public VisibleFileOperationControls(bool open = false, bool save = false, bool print = false, bool download = false)
	public VisibleFileOperationControls(boolean open, boolean save, boolean print, boolean download)
	{
		setOpen(open);
		setSave(save);
		setPrint(print);
		setDownload(download);
	}

	// Properties
	/** 
	 Gets or sets whether open-new-file button should be shown. 
	 This allows the user to open any file for viewing. Default is false.
	*/
	private boolean open;
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
	private boolean save;
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
	private boolean print;
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
	private boolean download;
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