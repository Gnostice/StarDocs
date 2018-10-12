package com.gnostice.stardocssdk;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpStatus;

import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.mashape.unirest.request.body.MultipartBody;

public class StorageInt
{
	// Fields
	private StarDocs starDocs = null;

	// Ctors
	public StorageInt(StarDocs starDocs)
	{
		this.starDocs = starDocs;
	}
	// Properties

	// Methods
	public final DocObject upload(java.io.InputStream inStream, String fileName, String password) throws URISyntaxException, StarDocsException
	{
		String url = starDocs.getConnectionInfo().getApiServerUrl() + "/docs";
		MultipartBody request = 
				Unirest
				.post(url)
				.field("fileUpload", inStream, fileName);
		return upload(request, password);
	}

	public final DocObject upload(String fileNameWithPath, String password) throws URISyntaxException, StarDocsException
	{
		String url = starDocs.getConnectionInfo().getApiServerUrl() + "/docs";
		MultipartBody request = 
				Unirest
				.post(url)
				.field("fileUpload", new File(fileNameWithPath));
		return upload(request, password);
	}

	public final DocObject uploadFromURL(String fileURL, String password) throws URISyntaxException, StarDocsException
	{
		// Upload the file
		String url = starDocs.getConnectionInfo().getApiServerUrl() + "/docs";
		MultipartBody request = 
				Unirest
				.post(url)
				.field("fileUrl", fileURL);
		return upload(request, password);
	}

	public final DocObject copyFrom(FileObject file, String password) throws URISyntaxException, IllegalArgumentException, StarDocsException
	{
		if (file.getFileUploaded() == false || file.getFileUrl() == null)
		{
			throw new IllegalArgumentException("File not on server or invalid URL");
		}
		return uploadFromURL(file.getFileUrl().toString(), password);
	}

	private DocObject upload(MultipartBody uploadRequest, String password) throws URISyntaxException, StarDocsException
	{
		// Upload the file
		uploadRequest.getHttpRequest().header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()));
		uploadRequest.field("forceFullPermission", starDocs.getPreferences().getDocPasswordSettings().getForceFullPermission());
		
		// Always use multipart/form-data
		//uploadRequest.getHttpRequest().header("Content-Type", "multipart/form-data");

		if (password != null)
		{
			uploadRequest.field("password", password);
		}
		//uploadRequest.AlwaysMultipartFormData = true;
		HttpResponse<JsonNode> response;
		try 
		{
			response = uploadRequest.asJson();
		} 
		catch (UnirestException e) 
		{
			throw new StarDocsException(e);
		}
		if (response.getStatus() != HttpStatus.SC_OK)
		{
			throw StarDocsException.Create(response.getStatus(), response);
		}
		Gson gson = new Gson();
		String responseJSONString = response.getBody().toString();
		CommonInt.RestAPISuccessResponseCommon parsedResponse = gson.fromJson(responseJSONString, CommonInt.RestAPISuccessResponseCommon.class);
		return new DocObject(parsedResponse.documents[0]);
	}

	public final void download(FileObject file, String outFilePath, boolean overwriteFiles) throws IOException, StarDocsException
	{
		// Download the file
		InputStream inStream = download(file);

		// Save the data to the file
		if (outFilePath == null)
		{
			// Use current directory
			outFilePath = new File(".").getAbsolutePath();
		}

		// Append file name from URI if not set
		if (FilenameUtils.getName(outFilePath).equals(""))
		{
			String fileName = file.getFileNameFromUrl();
			if (file instanceof DocObject)
			{
				fileName = ((DocObject)file).getFileName();
			}
			outFilePath = FilenameUtils.concat(outFilePath, fileName);
		}
		File pathWithFile = new File(outFilePath);
			
		// Check if file exists and shouldn't be overwritten
		if (pathWithFile.exists() && !overwriteFiles)
		{
			String guid = UUID.randomUUID().toString().replace("-", "");
			String ext = FilenameUtils.getExtension(outFilePath);
			outFilePath = FilenameUtils.removeExtension(outFilePath);
			outFilePath += ("_" + guid);
			if (ext.length() > 0)
			{
				outFilePath += (FilenameUtils.EXTENSION_SEPARATOR_STR + ext);
			}
			pathWithFile = new File(outFilePath);
		}
		
		// Save to file (this also creates the path if necessary and finally closes the input stream)
		FileUtils.copyInputStreamToFile(inStream, pathWithFile);
	}

	public final void download(FileObject file, java.io.OutputStream outStream) throws IOException, StarDocsException
	{
		InputStream inputStream = download(file);
		IOUtils.copy(inputStream, outStream);
		inputStream.close();
	}

	public InputStream download(FileObject file) throws StarDocsException
	{
		if (file.getFileUploaded() == false || file.getFileUrl() == null)
		{
			throw new IllegalArgumentException("File not on server or invalid URL");
		}

		// Download the file
		HttpResponse<InputStream> response;
		try 
		{
			response = Unirest
			.get(file.getFileUrl().toString())
			.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
			.asBinary();
		} 
		catch (UnirestException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

		if (response.getStatus() != HttpStatus.SC_OK)
		{
			throw new StarDocsException(response.getStatus(), null, response.getStatusText());
		}

		/*
		if (!response.ContentType.equals("multipart/form-data"))
		{
			throw new StarDocsException(HttpStatus.SC_OK, StarDocsErrorCode.UnexpectedResponse, "Unexpected response type during download");
		}*/

		return response.getBody();
	}

	public final void delete(FileObject file) throws StarDocsException
	{
		HttpResponse<InputStream> response;
		try 
		{
			response = Unirest
			.delete(file.getFileUrl().toString())
			.header("Authorization", String.format("Bearer %1$s", starDocs.getAuthResponse().getAccessToken()))
			.asBinary();
		} 
		catch (UnirestException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}

		int statusCode = response.getStatus(); 
		if (statusCode != HttpStatus.SC_OK && statusCode != HttpStatus.SC_NO_CONTENT)
		{
			String statusText = response.getStatusText();
			throw new StarDocsException(statusCode, null, statusText);
		}
	}
}