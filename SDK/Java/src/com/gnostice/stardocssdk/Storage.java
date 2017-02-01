package com.gnostice.stardocssdk;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;

public class Storage
{
	// Fields
	public StorageInt storageInt;

	// Ctors
	public Storage(StarDocs starDocs)
	{
		storageInt = new StorageInt(starDocs);
	}

	// Properties

	// Methods

	public final DocObject upload(String fileNameWithPath) throws URISyntaxException, StarDocsException
	{
		return upload(fileNameWithPath, null);
	}

	public final DocObject upload(String fileNameWithPath, String password) throws URISyntaxException, StarDocsException
	{
		return storageInt.upload(fileNameWithPath, password);
	}

	public final DocObject upload(InputStream stream, String fileName) throws URISyntaxException, StarDocsException
	{
		return upload(stream, fileName, null);
	}

	public final DocObject upload(InputStream stream, String fileName, String password) throws URISyntaxException, StarDocsException
	{
		return storageInt.upload(stream, fileName, password);
	}

	public final DocObject uploadFromURL(String fileURL) throws URISyntaxException, StarDocsException
	{
		return uploadFromURL(fileURL, null);
	}

	public final DocObject uploadFromURL(String fileURL, String password) throws URISyntaxException, StarDocsException
	{
		return storageInt.uploadFromURL(fileURL, password);
	}

	public final DocObject copyFrom(FileObject file) throws IllegalArgumentException, URISyntaxException, StarDocsException
	{
		return copyFrom(file, null);
	}

	public final DocObject copyFrom(FileObject file, String password) throws IllegalArgumentException, URISyntaxException, StarDocsException
	{
		return storageInt.copyFrom(file, password);
	}

	public final void download(FileObject file, String fileNameWithPath) throws IOException, StarDocsException
	{
		download(file, fileNameWithPath, false);
	}

	public final void download(FileObject file, String fileNameWithPath, boolean overwriteFiles) throws IOException, StarDocsException
	{
		storageInt.download(file, fileNameWithPath, overwriteFiles);
	}

	public final void download(FileObject file, OutputStream outStream) throws IOException, StarDocsException
	{
		storageInt.download(file, outStream);
	}

	public final void delete(FileObject file) throws StarDocsException
	{
		storageInt.delete(file);
	}
}