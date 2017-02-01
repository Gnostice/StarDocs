package com.gnostice.stardocssdk;

import com.mashape.unirest.http.Unirest;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2014 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


/** Contains main classes of StarDocsSDK.
*/

public class StarDocs
{
	// Fields
	private ConnectionInfo connectionInfo;
	private Preferences preferences;
	
	// Public fields (cleaner this way than doing a get...)
	public Auth auth;
	public Storage storage;
	public Viewer viewer;
	public DocOperations docOperations;

	// Ctors

	public StarDocs(ConnectionInfo connectionInfo)
	{
		this(connectionInfo, null);
	}

	public StarDocs(ConnectionInfo connectionInfo, Preferences preferences)
	{
		this.connectionInfo = connectionInfo;
		this.preferences = (preferences != null) ? preferences : new Preferences();

		// Instantiate service groups
		auth = new Auth(this);
		storage = new Storage(this);
		viewer = new Viewer(this);
		docOperations = new DocOperations(this);
		
		// Set timeouts
		Unirest.setTimeouts(connectionInfo.getConnectionTimeout(), connectionInfo.getServerTimeout());
	}

	// Properties
	/** 
	 Gets or sets connection information.
	*/
	public final ConnectionInfo getConnectionInfo()
	{
		return connectionInfo;
	}

	public final Preferences getPreferences()
	{
		return preferences;
	}

	private AuthResponse AuthResponse;
	public final AuthResponse getAuthResponse()
	{
		return AuthResponse;
	}
	public final void setAuthResponse(AuthResponse value)
	{
		AuthResponse = value;
	}
	// Service groups

	// Todo: Add Users, Workflow, ...
	/*
	myWorkFlow = Workflow.New();
	myWorkFlow.Add("Upload", fileWithPath);
	myWorkFlow.Add(upload2);
	myWorkFlow.Merge(doc1, doc2);
	myWorkFlow.Add(sign, doc3);
	myWorkFlow.Add(email);
	*/

	// Methods
}