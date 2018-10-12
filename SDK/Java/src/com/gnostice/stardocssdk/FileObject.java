package com.gnostice.stardocssdk;

import java.io.InputStream;
import java.net.URI;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a local counterpart of a file that can be uploaded
 to the server or download from it.
*/
public class FileObject
{
	// Fields

	/** 
	 Creates a new instance of this class for specified document
	 on the API server.
	*/
	public FileObject(URI fileUrl)
	{
		// Assume file is uploaded
		setStream(null);
		setStreamFileName(null);
		setFileUploaded(true);
		setFileUrl(fileUrl);
		setLocalFilePath(null);
	}

	/** 
	 Creates an instance of this class using specified stream of a
	 \file.
	*/
	public FileObject(InputStream stream, String streamFileName)
	{
		setStream(stream);
		setStreamFileName(streamFileName);
		setFileUploaded(false);
		setFileUrl(null);
		setLocalFilePath(null);
	}

	/** 
	 Creates a new instance of this class using specified pathname
	 of a file.
	*/
	public FileObject(String localFilePath)
	{
		setStream(null);
		setStreamFileName(null);
		setFileUploaded(false);
		setFileUrl(null);
		setLocalFilePath(localFilePath);
	}

	/** 
	 Gets URI of the file on the REST API server.
	*/
	private URI fileUrl;
	public final URI getFileUrl()
	{
		return fileUrl;
	}
	public final void setFileUrl(URI value)
	{
		fileUrl = value;
	}

	/** 
	 Gets local pathname of the file.
	*/
	private String localFilePath;
	public final String getLocalFilePath()
	{
		return localFilePath;
	}
	public final void setLocalFilePath(String value)
	{
		localFilePath = value;
	}

	/** 
	 \Returns original from which the file was read.
	*/
	private String streamFileName;
	public final String getStreamFileName()
	{
		return streamFileName;
	}
	public final void setStreamFileName(String value)
	{
		streamFileName = value;
	}

	/** 
	 Gets contents of the input file as a stream.
	*/
	private InputStream inputStream;
	public final InputStream getStream()
	{
		return inputStream;
	}
	public final void setStream(InputStream value)
	{
		inputStream = value;
	}

	/** 
	 Gets whether the file has been uploaded.
	*/
	private boolean fileUploaded;
	public final boolean getFileUploaded()
	{
		return fileUploaded;
	}
	public final void setFileUploaded(boolean value)
	{
		fileUploaded = value;
	}

	public final String getFileNameFromUrl()
	{
		String localPath = getFileUrl().getPath();
		int lastPos = localPath.lastIndexOf('/');
		return localPath.substring(lastPos + 1);
	}

	@Override
	public String toString()
	{
		Object[] objs = new Object[] {getFileUrl(), getStream(), getStreamFileName(), getLocalFilePath(), getFileUploaded()};
		return String.format("FileUrl=%1$s, Stream=%2$s, StreamFileName=%3$s, LocalFilePath=%4$s, FileUploaded=%5$s", objs);
	}
}