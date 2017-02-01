package com.gnostice.stardocssdk;

import java.net.URI;
import java.net.URISyntaxException;



/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** 
 Represents a document that has been uploaded or created on
 the server.
*/
public class DocObject extends FileObject
{
	// Fields

	// Ctors
	public DocObject(CommonInt.RestAPIDocumentCommon apiResponse) throws URISyntaxException
	{
		super(new URI(apiResponse.url));
		setFileName(apiResponse.fileName);
		setFileSize(apiResponse.fileSize);
		setFileExpiry(apiResponse.fileExpiry);
		setPageCount(apiResponse.pageCount);
		setMimeType(ParseMimeType(apiResponse.mimeType));
	}

	private String fileName;
	public final String getFileName()
	{
		return fileName;
	}
	private void setFileName(String value)
	{
		fileName = value;
	}

	/** 
	 Gets size of the document in bytes.
	*/
	private long fileSize;
	public final long getFileSize()
	{
		return fileSize;
	}
	private void setFileSize(long value)
	{
		fileSize = value;
	}

	/** 
	 Gets the expiry time of the document. Null if no expiry time is set.
	*/
	private Long fileExpiry = null;
	public final Long getFileExpiry()
	{
		return fileExpiry;
	}
	private void setFileExpiry(Long value)
	{
		fileExpiry = value;
	}

	/** 
	 Gets number of pages in the document. Note that this value will not be set (null) for Upload response.
	*/
	private Integer pageCount = null;
	public final Integer getPageCount()
	{
		return pageCount;
	}
	private void setPageCount(Integer value)
	{
		pageCount = value;
	}

	/** 
	 Gets content type or MIME type of the document. Note that this value will not be set (MimeType.Unknown) for Upload response.
	*/
	private MimeType mimeType;
	public final MimeType getMimeType()
	{
		return mimeType;
	}
	private void setMimeType(MimeType value)
	{
		mimeType = value;
	}

	@Override
	public String toString()
	{
		Object[] objs = new Object[] {super.toString(), getFileName(), getFileSize(), getFileExpiry(), getPageCount(), getMimeType().name()};
		return String.format("%1$s, Name=%2$s, FileSize=%3$s, FileExpiry=%4$s, PageCount=%5$s, MimeType=%6$s", objs);
	}

	public static MimeType ParseMimeType(String mimeTypeStr)
	{
		MimeType mimeType = MimeType.Unrecognizable;
		if (mimeTypeStr == null)
		{
			return mimeType;
		}
		if (mimeTypeStr.equals("application/pdf"))
		{
			mimeType = MimeType.application_pdf;
		}
		else if (mimeTypeStr.equals("image/bmp"))
		{
			mimeType = MimeType.image_bmp;
		}
		else if (mimeTypeStr.equals("image/gif"))
		{
			mimeType = MimeType.image_gif;
		}
		else if (mimeTypeStr.equals("image/jpeg"))
		{
			mimeType = MimeType.image_jpeg;
		}
		else if (mimeTypeStr.equals("image/png"))
		{
			mimeType = MimeType.image_png;
		}
		else if (mimeTypeStr.equals("image/tiff"))
		{
			mimeType = MimeType.image_tiff;
		}
		else if (mimeTypeStr.equals("application/msword"))
		{
			mimeType = MimeType.application_msword;
		}
		else if (mimeTypeStr.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document"))
		{
			mimeType = MimeType.application_vnd_openxmlformats_officedocument_wordprocessingml_document;
		}
		return mimeType;
	}

}