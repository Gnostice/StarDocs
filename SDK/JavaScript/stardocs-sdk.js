/* 
 * Gnostice StarDocs v2
 * Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/

'use strict';

/* Namespace: Gnostice */
var Gnostice = Gnostice || {};

/* ConnectionInfo */
Gnostice.ConnectionInfo = function(apiServerUri, apiKey, apiSecret, serverTimeout, docOperationTimeout) {
	this.apiServerVersion = '2.0.0';
	this.apiServerUri = apiServerUri || '';
	this.apiKey = apiKey;
	this.apiSecret = apiSecret;
	this.serverTimeout = serverTimeout || -1;
	this.docOperationTimeout = docOperationTimeout || -1;
};
Gnostice.ConnectionInfo.prototype.constructor = Gnostice.ConnectionInfo;

/* DocPasswordSettings */
Gnostice.DocPasswordSettings = function(forceFullPermission) {
	this.forceFullPermission = forceFullPermission;
};
Gnostice.DocPasswordSettings.prototype = Gnostice.DocPasswordSettings;

/* Preferences */
Gnostice.Preferences = function(docPasswordSettings) {
	this.docPasswordSettings = docPasswordSettings || new Gnostice.DocPasswordSettings(false);
};
Gnostice.Preferences.prototype.constructor = Gnostice.Preferences;

/* StarDocs */
Gnostice.StarDocs = function(connectionInfo, preferences) {
	this.connectionInfo = connectionInfo || new Gnostice.ConnectionInfo();
	this.preferences = preferences || new Gnostice.Preferences();

	/* URI parts */
	this.uriSegAuthToken = '/auth/token';
	this.uriSegDocs = '/docs';
	this.uriSegDocsOps = '/docs/ops';
	this.uriSegOps = '/ops';
	this.uriSegInfo = '/info';
	this.uriSegMetaTags = '/meta/tags';
	this.uriSegMetaOwner = '/meta/owner';
	this.uriSegMetaFilename = '/meta/filename';
	this.uriSegUsers = '/users';
	this.uriSegViewSessions = '/viewsessions';
	this.uriSegMiscTags = '/misc/tags';
	this.uriSegMiscGroups = '/misc/groups';
	this.uriMiscPhysicalStores = '/misc/physicalstores';
	this.uriMiscDocumenTreeViews = '/misc/documenttreeviews';

	/* Constants */
	this.pollInterval = 1000 * 1;			// 1 second
	this.pollRetryMaxCount = 60 * 10;	// 10 minutes

	/* Internal settings passed when SDK is used in viewer */
	this.documentPassword = null;
	this.setDocumentPassword = function(password) {
		this.documentPassword = password;
	};
	
	/* Authentication related APIs */
	var Auth = function(starDocs) {
		this.starDocs = starDocs;
		this.accessToken = null;
		this.loggedInUserName = null;
		// Authentication type used by caller. Currently supported 'password' and 'client_credentials'
		this.grantType = null;
	};
	Auth.prototype.constructor = Auth;
	
	// Login StarDocs user
	Auth.prototype.loginUser = function(username, password) {
		this.loggedInUserName = null;
		this.grantType = null;
		var authTokenUrl = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegAuthToken;
		console.log("In Auth.login: " + username);
		// Use OAuth2 to request access token (grant type: password)
		var self = this;
		var deferred = $.ajax({
			url: authTokenUrl,
			type: 'POST',
			dataType: 'json',	// Expected
			beforeSend: function(xhr) { 
				xhr.setRequestHeader(
					"Authorization", 
					"Basic " + btoa(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret)
				);
			},
			headers: {
				'content-type': 'application/x-www-form-urlencoded',
			},
			data: {
				'grant_type': 'password',
				'username': username,
				'password': password
			},
		});
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (textStatus == 'success') {
					//this.loggedInUserName = jqXhr.;
					self.setAccessToken(response.access_token, 'password');
					return $.Deferred().resolve(response).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				self.setAccessToken(null, null);
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Login app (grant_type: 'client_credentials') 
	Auth.prototype.loginApp = function(entityId) {
		this.loggedInUserName = null;
		this.grantType = null;
		var authTokenUrl = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegAuthToken;
		if (entityId !== null) {
			authTokenUrl += '?entity_id=' + entityId;
		}
		console.log("In loginApp");
		var self = this;
		var deferred = $.ajax({
			url: authTokenUrl,
			type: 'POST',
			dataType: 'json',	// Expected
			beforeSend: function(xhr) { 
				xhr.setRequestHeader(
					"Authorization", 
					"Basic " + btoa(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret)
				);
			},
			headers: {
				'content-type': 'application/x-www-form-urlencoded',
			},
			data: {
				'grant_type': 'client_credentials'
			},
		});
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (textStatus == 'success') {
					//this.loggedInUserName = jqXhr.;
					self.setAccessToken(response.access_token, 'client_credentials');
					return $.Deferred().resolve(response).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				self.setAccessToken(null, null);
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Set access token post successful login (internal use)
	Auth.prototype.setAccessToken = function(accessToken, grantType) {
		this.accessToken = accessToken;
		if (grantType !== null) {
			this.grantType = grantType;
		}
	};
	
	/* Storage related APIs */
	var Storage = function(starDocs) {
		this.starDocs = starDocs;
	};
	Storage.prototype.constructor = Storage;
	
	// Upload file(s)
	// inputElementFileId - id of the <input> element of type 'file'
	// password - Password if the document is encrypted
	Storage.prototype.upload = function(inputElementFileId, password) {
		var fileInput = document.getElementById(inputElementFileId);
		// Currently we only support a single file upload at a time
		var file = fileInput.files[0];
		console.log('Uploading ' + file);
		var formData = new FormData();
		formData.append('fileUpload', file);
		if (password != null) {
			formData.append('password', password);
		}
		formData.append('forceFullPermission', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		var docsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocs;
		var self = this;
		var deferred = this.starDocs.doAjaxWithBody('POST', docsUri, formData);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// List file(s)
	// whichFiles = "all"/"owned"/"sharedWithMe"
	// includeDetails = ['tags', 'rights', 'thumbnail']
	Storage.prototype.listFiles = function(whichFiles, includeDetails, queryString) {
		var self = this;
		var searchClauseList = [];
		
		whichFiles = "all" || whichFiles;
		whichFiles = whichFiles.toLowerCase();
		searchClauseList.push("sub_set=" + whichFiles);

		if ($.isArray(queryString))
		{
			Array.prototype.push.apply(searchClauseList, queryString);
		}
		else if (queryString != null)
		{
			searchClauseList.push(queryString);
		}
		
		var includeDetailsStr = "";
		if ($.isArray(includeDetails))
		{
			includeDetailsStr = includeDetails.join();
		}
		else
		{
			includeDetailsStr = includeDetails || "";
		}
		searchClauseList.push("include_details=" + includeDetailsStr);

		var docsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocs;
		for (var i=0; i < searchClauseList.length; ++i) {
			if (i === 0) {
				docsUri += "?";
			}
			docsUri += searchClauseList[i];
			if (i < searchClauseList.length) {
				docsUri += "&";
			}
		}
		var deferred = this.starDocs.doAjax('GET', docsUri);
		
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};
	
	// Download file
	Storage.prototype.download = function(docUri, download) {
		console.log("Downloading " + docUri);
		if (typeof download !== 'boolean') {
			download = true;
		}
		if (download) {
			// Download (as in save to computer) is NOT currently possible via AJAX so ask the browser to download instead
			// Since it's not possible to set any headers (Bearer auth), supply the token via url params
			// Return a deferred object that immediately completes successfully
			var fileUri = docUri;
			if (this.starDocs.auth.accessToken !== null) {
				fileUri += '?bearer_token=' + this.starDocs.auth.accessToken;
			}
			console.log ("uri: " + fileUri);
			return $.Deferred().resolve(
				window.open(fileUri, '_blank')).promise();
		}
		else {
			var self = this;
			var deferred = this.starDocs.doAjax('GET', docUri, 'text');
			return deferred.then(
				function(response, textStatus, jqXhr) {
					return $.Deferred().resolve(jqXhr.responseText).promise();
				},
				function(jqXhr, textStatus, errorThrown) {
					return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
				}
			);
		}
	};

	// Delete file
	Storage.prototype.delete = function(docUri) {
		console.log("Deleting " + docUri);
		var deferred = this.starDocs.doAjax('DELETE', docUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve().promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Set tags to a document
	Storage.prototype.setTags = function(docUri, tags) {
		console.log("Setting tags on  " + docUri);
		var self = this;
		var tagsUri = docUri + this.starDocs.uriSegMetaTags;
		var body = JSON.stringify({'tags': tags});
		var deferred = this.starDocs.doAjaxWithBody('POST', tagsUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve().promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Transfer ownership
	Storage.prototype.updateOwner = function(docUri, newOwnerUserNameEmail, resetSharing, retainRights) {
		console.log("Updating owner for " + docUri);
		var docOwnerUri = docUri + this.starDocs.uriSegMetaOwner;
		var req = { 'user': { 'userNameEmail': newOwnerUserNameEmail } };
		if (resetSharing !== null)
		{
			req['resetSharing'] = resetSharing;
		}
		if (retainRights !== null)
		{
			req['retainRights'] = retainRights;
		}
		var body = JSON.stringify(req);
		var deferred = this.starDocs.doAjaxWithBody('PUT', docOwnerUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve().promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Rename a file
	Storage.prototype.rename = function(docUri, newFilename) {
		console.log("Updating filename for " + docUri);
		var docOwnerUri = docUri + this.starDocs.uriSegMetaFilename;
		var req = { 'fileName': newFilename };
		var body = JSON.stringify(req);
		var deferred = this.starDocs.doAjaxWithBody('PUT', docOwnerUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (textStatus == 'success') {
					return $.Deferred().resolve().promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	/* Document operation related APIs */
	var DocOperations = function(starDocs) {
		this.starDocs = starDocs;
	};
	DocOperations.prototype.constructor = DocOperations;
	
	// Merge files
	// docUrls - Array of strings
	// passwords - Array of strings 
	// pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	DocOperations.prototype.merge = function(docUrls, passwords, pageRangeSettings) {
		var docsOpsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocsOps + "/merge";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents':[]};
		for (var i = 0; i < docUrls.length;++i)
		{
			var jsonDocument = {'url': docUrls[i]};
			if (passwords != null)
			{
				jsonDocument.password = passwords[i];
			}
			if (pageRangeSettings != null)
			{
				//var jsonPageRangeSetting = this.starDocs.parsePageRangeSettings(pageRangeSettings[i]);
				//jsonDocument['pageRangeSettings'] = jsonPageRangeSetting;
				jsonDocument.pageRange = pageRangeSettings[i];
			}
			jsonBody.documents.push(jsonDocument);
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUri, body, 'application/json; charset=utf-8');
	};
	
	// Split files given a range of pages
	// docUrl - String
	// password - String
	// pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	DocOperations.prototype.splitRange = function(docUrl, password, pageRangeSettings) {
		var docsOpsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocsOps + "/split-range";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{'url': docUrl, 'pageRanges':[]}]};
		if (password != null) {
			jsonBody.documents[0].password = passwords;
		}
		if (pageRangeSettings != null) {
			jsonBody.documents[0].pageRanges = pageRangeSettings;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	// Split files at separator (blank) pages
	// docUrl - String
	// password - String
	DocOperations.prototype.splitSeparatorPage = function(docUrl, password) {
		var docsOpsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocsOps + "/split-separator";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{'url': docUrl, 'separatorType': 'emptyPage'}]};
		if (password != null) {
			jsonBody.documents[0].password = passwords;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	// Convert files
	/*
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	*/
	DocOperations.prototype.convertToBMP = function(docUrls, passwords, pageRangeSettings, imageEncoderSettings) {
		return this.convertToImage("convert-bmp", docUrls, passwords, pageRangeSettings, imageEncoderSettings);
	};

	/*
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	*/
	DocOperations.prototype.convertToGIF = function(docUrls, passwords, pageRangeSettings, imageEncoderSettings) {
		return this.convertToImage("convert-gif", docUrls, passwords, pageRangeSettings, imageEncoderSettings);
	};

	/*
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	*/
	DocOperations.prototype.convertToJPEG = function(docUrls, passwords, pageRangeSettings, imageEncoderSettings) {
		return this.convertToImage("convert-jpeg", docUrls, passwords, pageRangeSettings, imageEncoderSettings);
	};

	/*
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	*/
	DocOperations.prototype.convertToPNG = function(docUrls, passwords, pageRangeSettings, imageEncoderSettings) {
		return this.convertToImage("convert-png", docUrls, passwords, pageRangeSettings, imageEncoderSettings);
	};

	/*
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	tiffCompressionType - String
	*/
	DocOperations.prototype.convertToTIFF = function(docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType) {
		return this.convertToImage("convert-tiff", docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType);
	};

	/*
	conversionMode - String
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	tiffCompressionType - String
	*/
	DocOperations.prototype.convertToMTIFF = function(conversionMode, docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType) {
		return this.convertToImage("convert-mtiff", docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType, conversionMode);
	};

	/*
	conversionMode - String
	docUrls - Array of strings
	passwords - Array of strings 
	pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	imageEncoderSettings - JS object having schema 
		{
			imageEncoderSettings: 
			{
				dpi: 
				{
					resolutionMode: <string>, 
					x: <int>, 
					y: <int> 
				}, 
				quality: <int>, 
				canvasSize: 
				{
					sizingMode: <string>,
					size: <string>,
					relativeSizeX: <int>,
					relativeSizeY: 0
				},
				contentScaling: <string>,
				contentAlignment: 
				{
					horizontalAlignment: <string>,
					horizontalOffset: <int>,
					verticalAlignment: <string>,
					verticalOffset: <int>
				}
			}	
		}
	tiffCompressionType - String
	*/
	DocOperations.prototype.convertToPDF = function(conversionMode, docUrls, passwords, pageRangeSettings, pdfEncoderSettings) {
		return this.convertToImage("convert-pdf", docUrls, passwords, pageRangeSettings, null, null, conversionMode, pdfEncoderSettings);
	};

	// Encrypt PDF files
	/* 
	docUrl - String
	password - String
	encryptionLevel - String
	newOpenPassword - String
	newPermissionsPassword - String
	newPermissions - JS object having schema
	  {
			allowAccessibility: <boolean>,
			allowAssembly: <boolean>,
			allowCopy: <boolean>,
			allowFormFill: <boolean>,
			allowHighResPrint: <boolean>,
			allowModifyAnnotations: <boolean>,
			allowModifyContents: <boolean>,
			allowPrinting: <boolean>
		}
	*/
	DocOperations.prototype.encrypt = function(docUrl, password, encryptionLevel, newOpenPassword, newPermissionsPassword, newPermissions) {
		var docsOpsUri = docUrl + this.starDocs.uriSegOps + "/encrypt";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission};
		if (password != null) {
			jsonBody.password = passwords;
		}
		if (encryptionLevel != null) {
			jsonBody.encryptionLevel = encryptionLevel;
		}
		if (newOpenPassword != null) {
			jsonBody.newOpenPassword = newOpenPassword;
		}
		if (newPermissionsPassword != null) {
			jsonBody.newPermissionsPassword = newPermissionsPassword;
		}
		if (newPermissions != null) {
			jsonBody.newPermissions = newPermissions;
		}
		
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	// Redact text from PDF files
	/* 
	docUrl - String
	password - String
	pageRangeSettings - JS object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	searchMode - String
	searchText - Array of JS objects having schema { text: <string, caseSensitive: <boolean>, wholeWord: <boolean> }
	fillSettings - JS object having schema
		{
			outline: 
				{
					color: <string>,
					width: <int>,
					style: <string>
				},
			fill: 
				{
					color: <string>,
					pattern: <string>,
					text: 
						{
							replaceText: <string>,
							font: 
								{
									name: <string>,
									size: <string>,
									color: <string>,
									style: 
										{
											bold: <boolean>,
											italic: <boolean>,
											underline: <boolean>
										}
								}
						}
				}
		}
	includeAdditionalItems - JS object having schema
		{
			bookmarks: <boolean>,
			bookmarkActions: <boolean>,
			annotations: <boolean>,
			annotationActions: <boolean>,
			documentProperties: <boolean>
		}
  cleanupSettings - JS object having schema
		{
			removeEmptyBookmarks: <boolean>,
			removeEmptyBookmarkActions: <boolean>,
			removeEmptyAnnotations: <boolean>,
			removeEmptyAnnotationActions: <boolean>,
			removeAffectedLinkActions: <boolean>
		}
	*/
	DocOperations.prototype.redactText = function(docUrl, password, pageRangeSettings, searchMode, searchText, fillSettings, includeAdditionalItems, cleanupSettings) {
		var docsOpsUri = docUrl + this.starDocs.uriSegOps + "/redact-text";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission};
		if (password != null) {
			jsonBody.password = passwords;
		}
		if (pageRangeSettings != null) {
			jsonBody.pageRange = pageRangeSettings;
		}
		if (searchMode != null) {
			jsonBody.searchMode = searchMode;
		}
		if (searchText != null) {
			jsonBody.searchText = searchText;
		}
		if (fillSettings != null) {
			jsonBody.fillSettings = fillSettings;
		}
		if (includeAdditionalItems != null) {
			jsonBody.includeAdditionalItems = includeAdditionalItems;
		}
		if (cleanupSettings != null) {
			jsonBody.cleanupSettings = cleanupSettings;
		}
		
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	/*
	* fillForm
	* @class The purpose of this function is to fill a PDF form
	* @param {string} docUrl URL of the document on the server
	* @param {string} password Some comment
	* @param {array} fields JS array having schema
	* [
	*		{
	*			fieldName: <string>,
	*			fieldValue: <string>,
	*			flattenField: <boolean>
	*		},
	*		...
	*	]
	*/
	DocOperations.prototype.fillForm = function(docUrl, password, fields) {
		var docsOpsUri = docUrl + this.starDocs.uriSegOps + "/fill-form";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission};
		if (password != null) {
			jsonBody.password = passwords;
		}
		if (fields != null) {
			jsonBody.fields = fields;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	// Internal method, do not use!
	DocOperations.prototype.convertToImage = function(urlPart, docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType, conversionMode, pdfEncoderSettings) {
		var docsOpsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegDocsOps + "/" + urlPart;
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents':[]};
		for (var i = 0; i < docUrls.length; ++i) {
			var jsonDocument = {'url': docUrls[i]};
			if (passwords != null) {
				jsonDocument.password = passwords[i];
			}
			if (pageRangeSettings != null) {
				jsonDocument.pageRange = pageRangeSettings[i];
			}
			jsonBody.documents.push(jsonDocument);
		}
		if (imageEncoderSettings != null) {
			jsonBody.imageEncoderSettings = imageEncoderSettings;
		}
		// Applicable only for TIFF and MTIFF
		if (tiffCompressionType != null) {
			jsonBody.tiffCompressionType = tiffCompressionType;
		}
		// Applicable only for MTIFF
		if (conversionMode != null) {
			jsonBody.conversionMode = conversionMode;
		}
		// Applicable only for PDF
		if (pdfEncoderSettings != null) {
			jsonBody.pdfEncoderSettings = pdfEncoderSettings;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUri, body, 'application/json; charset=utf-8');
	};

	// Get document info
	DocOperations.prototype.getDocInfo = function(docUrl, password) {
		docUrl = docUrl + this.starDocs.uriSegInfo;
		docUrl = docUrl + "?force-full-permission=" + this.starDocs.preferences.docPasswordSettings.forceFullPermission;
		if (password != null) {
			docUrl = docUrl + "&password=" + encodeURIComponent(password);
		}
		else if (this.starDocs.documentPassword != null) {
			docUrl = docUrl + "&password=" + encodeURIComponent(this.starDocs.documentPassword);
		}

		var deferred = this.starDocs.doAjax('GET', docUrl);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 200) {
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					// Page is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = jqXhr.getResponseHeader("location");
					pollUrl = pollUrl + "?force-full-permission=" + that.starDocs.preferences.docPasswordSettings.forceFullPermission;
					if (that.starDocs.documentPassword != null) {
						pollUrl = pollUrl + "&password=" + encodeURIComponent(that.starDocs.documentPassword);
					}
					setTimeout(that.starDocs.doPoll, that.starDocs.pollInterval, pollUrl, newDeferred, that.starDocs, 1);
					return newDeferred.promise();
				}
				else {
					// Unexpected response
					return $.Deferred().reject(jqXhr.status, textStatus, jqXhr.responseJSON).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};
	
	// Get page image
	DocOperations.prototype.getPageImage = function(pageUrl, dpi, password) {
		pageUrl = pageUrl + "?dpi=" + dpi;
		pageUrl = pageUrl + "&force-full-permission=" + this.starDocs.preferences.docPasswordSettings.forceFullPermission;
		if (password != null) {
			pageUrl = pageUrl + "&password=" + encodeURIComponent(password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageUrl = pageUrl + "&password=" + encodeURIComponent(this.starDocs.documentPassword);
		}
		var deferred = this.starDocs.doAjax('GET', pageUrl);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 200) {
					console.log("In getPageImage: Page ready " + response);
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					console.log("In getPageImage: Page not ready, need to poll");
					// Page is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = jqXhr.getResponseHeader("location");
					pollUrl = pollUrl + "?force-full-permission=" + that.starDocs.preferences.docPasswordSettings.forceFullPermission;
					if (that.starDocs.documentPassword != null) {
						pollUrl = pollUrl + "&password=" + encodeURIComponent(that.starDocs.documentPassword);
					}
					setTimeout(that.starDocs.doPoll, that.starDocs.pollInterval, pollUrl, newDeferred, that.starDocs, 1);
					return newDeferred.promise();
				}
				else {
					// Unexpected response
					return $.Deferred().reject(jqXhr.status, textStatus, jqXhr.responseJSON).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				console.log("In getPageImage: fail event called");
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Get page form fields
	DocOperations.prototype.getPageFormFields = function(pageUrl, password) {
		var pageTextUrl = pageUrl + "/formfields";
		pageTextUrl = pageTextUrl + "?force-full-permission=" + this.starDocs.preferences.docPasswordSettings.forceFullPermission;
		if (password != null) {
			pageTextUrl = pageTextUrl + "&password=" + encodeURIComponent(password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageTextUrl = pageTextUrl + "&password=" + encodeURIComponent(this.starDocs.documentPassword);
		}
		var deferred = this.starDocs.doAjax('GET', pageTextUrl);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 200) {
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					// Page is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = jqXhr.getResponseHeader("location");
					pollUrl = pollUrl + "?force-full-permission=" + that.starDocs.preferences.docPasswordSettings.forceFullPermission;
					if (that.starDocs.documentPassword != null) {
						pollUrl = pollUrl + "&password=" + encodeURIComponent(that.starDocs.documentPassword);
					}
					setTimeout(that.starDocs.doPoll, that.starDocs.pollInterval, pollUrl, newDeferred, that.starDocs, 1);
					return newDeferred.promise();
				}
				else {
					// Unexpected response
					return $.Deferred().reject(jqXhr.status, textStatus, jqXhr.responseJSON).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Get page text
	DocOperations.prototype.getPageText = function(pageUrl, password) {
		var pageTextUrl = pageUrl + "/text";
		pageTextUrl = pageTextUrl + "?force-full-permission=" + this.starDocs.preferences.docPasswordSettings.forceFullPermission;
		if (password != null) {
			pageTextUrl = pageTextUrl + "&password=" + encodeURIComponent(password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageTextUrl = pageTextUrl + "&password=" + encodeURIComponent(this.starDocs.documentPassword);
		}
		var deferred = this.starDocs.doAjax('GET', pageTextUrl);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 200) {
					console.log("In getPageText: Page text ready " + response);
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					console.log("In getPageText: Page text not ready, need to poll");
					// Page is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = jqXhr.getResponseHeader("location");
					pollUrl = pollUrl + "?force-full-permission=" + that.starDocs.preferences.docPasswordSettings.forceFullPermission;
					if (that.starDocs.documentPassword != null) {
						pollUrl = pollUrl + "&password=" + encodeURIComponent(that.starDocs.documentPassword);
					}
					setTimeout(that.starDocs.doPoll, that.starDocs.pollInterval, pollUrl, newDeferred, that.starDocs, 1);
					return newDeferred.promise();
				}
				else {
					// Unexpected response
					return $.Deferred().reject(jqXhr.status, textStatus, jqXhr.responseJSON).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				console.log("In getPageText: fail event called");
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	/* User management related APIs */
	var UserMgmt = function(starDocs) {
		this.starDocs = starDocs;
	};
	UserMgmt.prototype.constructor = UserMgmt;
	
	// Get list of users
	UserMgmt.prototype.listUsers = function() {
		var usersUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegUsers;
		var deferred = this.starDocs.doAjax('GET', usersUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};
	
	// Get details of a specific user (given URI)
	// if userUri is ommitted then details of currently logged-in user is returned
	UserMgmt.prototype.getUserDetails = function(userUri) {
		userUri = userUri || this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegUsers + "/me";
		var deferred = this.starDocs.doAjax('GET', userUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	/* Viewer related APIs */
	var Viewer = function(starDocs) {
		this.starDocs = starDocs;
	};
	Viewer.prototype.constructor = Viewer;

	// Viewer: createView
	Viewer.prototype.createView = function(docUrl, password, viewerSettings) {
		console.log("Creating viewer for doc " + docUrl);
		var self = this;
		var viewSessionsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegViewSessions;
		viewerSettings = viewerSettings || {};
		password = password || "";
		var body = JSON.stringify({'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{ 'url': docUrl, 'password': password }], 'viewerSettings': viewerSettings});
		var deferred = this.starDocs.doAjaxWithBody('POST', viewSessionsUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	/* Misc APIs */
	var Misc = function(starDocs) {
		this.starDocs = starDocs;
	};
	Misc.prototype.constructor = Misc;

	// Misc: getLookupTags
	Misc.prototype.getLookupTags = function() {
		var tagsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegMiscTags;
		var deferred = this.starDocs.doAjax('GET', tagsUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: listGroups
	Misc.prototype.listGroups = function() {
		var groupsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriSegMiscGroups;
		var deferred = this.starDocs.doAjax('GET', groupsUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: listPhysicalStores
	Misc.prototype.listPhysicalStores = function() {
		var physicalStoresUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriMiscPhysicalStores;
		var deferred = this.starDocs.doAjax('GET', physicalStoresUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: listDocumentTreeViews
	Misc.prototype.listDocumentTreeViews = function() {
		var documentTreeViewsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriMiscDocumenTreeViews;
		var deferred = this.starDocs.doAjax('GET', documentTreeViewsUri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: createDocumentTreeView
	Misc.prototype.createDocumentTreeView = function(name, tags) {
		var documentTreeViewsUri = this.starDocs.connectionInfo.apiServerUri + this.starDocs.uriMiscDocumenTreeViews;
		var body = JSON.stringify({'documentTreeView': {'name': name, 'tagKeys': tags}});
		var deferred = this.starDocs.doAjaxWithBody('POST', documentTreeViewsUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: editDocumentTreeView
	Misc.prototype.editDocumentTreeView = function(documentTreeViewsUri, name, tags) {
		var body = JSON.stringify({'documentTreeView': {'name': name, 'tagKeys': tags}});
		var deferred = this.starDocs.doAjaxWithBody('PUT', documentTreeViewsUri, body, 'application/json; charset=utf-8');
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve().promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Misc: deleteDocumentTreeView
	Misc.prototype.deleteDocumentTreeView = function(uri) {
		console.log("Deleting " + uri);
		var deferred = this.starDocs.doAjax('DELETE', uri);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve().promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Instantiate inner objects
	this.auth = new Auth(this);
	this.storage = new Storage(this);
	this.docOperations = new DocOperations(this);
	this.userMgmt = new UserMgmt(this);
	this.viewer = new Viewer(this);
	this.misc = new Misc(this);
};

Gnostice.StarDocs.prototype.constructor = Gnostice.StarDocs;

// Private methods
Gnostice.StarDocs.prototype.assertUserLogin = function() {
	if (this.auth.accessToken === null /*|| this.auth.loggedInUserName == null*/) {
		throw new Error('Authentication required');
	}
};

Gnostice.StarDocs.prototype.doAjax = function(method, uri, expectedDataType) {
	var self = this;
	return $.ajax({
		url: uri,
		type: method,
		dataType: expectedDataType || 'json',	// Expected
		beforeSend: function(xhr) {
			if (self.auth.grantType !== null && self.auth.accessToken !== null) {
				xhr.setRequestHeader(
					"Authorization", 
					"Bearer " + self.auth.accessToken
				);
			}
		},
		// Options to tell jQuery not to process data
		contentType: false,
		cache: false,
		processData: false
	});
};

Gnostice.StarDocs.prototype.doAjaxWithBody = function(method, uri, body, bodyContentType, expectedDataType) {
	var self = this;
	return $.ajax({
		url: uri,
		type: method,
		dataType: expectedDataType || 'json',	// Expected
		beforeSend: function(xhr) {
			if (self.auth.grantType !== null && self.auth.accessToken !== null) {
				xhr.setRequestHeader(
					"Authorization", 
					"Bearer " + self.auth.accessToken
				);
			}
		},
		data: body,
		// Options to tell jQuery not to process data
		contentType: bodyContentType || false,
		cache: false,
		processData: false
	});
};

Gnostice.StarDocs.prototype.doAjaxWithBodyAndPoll = function(method, uri, body, bodyContentType, expectedDataType) {
		var deferred = this.doAjaxWithBody(method, uri, body, bodyContentType, expectedDataType);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 201) {
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					// Result is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = jqXhr.getResponseHeader("location");
					pollUrl = pollUrl + "?force-full-permission=" + that.preferences.docPasswordSettings.forceFullPermission;
					if (that.documentPassword != null) {
						pollUrl = pollUrl + "&password=" + encodeURIComponent(that.documentPassword);
					}
					setTimeout(that.doPoll, that.pollInterval, pollUrl, newDeferred, that, 1);
					return newDeferred.promise();
				}
				else {
					// Unexpected response
					return $.Deferred().reject(jqXhr.status, textStatus, jqXhr.responseJSON).promise();
				}
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
};

Gnostice.StarDocs.prototype.doPoll = function(pollUrl, deferred, starDocs, pollRetryCount) {
	console.log("In doPoll: Polling " + pollUrl);

	var deferredRequest = starDocs.doAjax('GET', pollUrl);
	return deferredRequest.then(
		function(response, textStatus, jqXhr) {
			if (jqXhr.status === 200 || jqXhr.status === 201) {
				console.log("In doPoll: done " + pollUrl);
				deferred.resolve(response);
			}
			else if (jqXhr.status === 202) {
				// Output not yet ready so continue to poll
				console.log("In doPoll: output not yet ready ");
				++pollRetryCount;
				if (pollRetryCount >= starDocs.pollRetryMaxCount) {
					// Server taking too long
					console.log("In doPoll: Retry count exceeded ");
					deferred.reject(200, 'OK', 0, 'Exceeded poll retry count.');
					return;
				}
				setTimeout(starDocs.doPoll, starDocs.pollInterval, pollUrl, deferred, starDocs, pollRetryCount);
			}
			else {
				// Unexpected response
				console.log("In doPoll: Unexpected status code " + jqXhr.status);
				deferred.reject(jqXhr.status, textStatus, jqXhr.responseJSON);
			}
		},
		function(jqXhr, textStatus, errorThrown) {
			console.log("In doPoll: error textStatus=" + textStatus + ", errorThrown=" + errorThrown);
			return deferred.reject(jqXhr.status, errorThrown, jqXhr.responseJSON);
		}
	);
};

Gnostice.StarDocs.prototype.parsePageRangeSettings = function(pageRangeSetting) {
	var ret = {'range': ""};
	if (pageRangeSetting.length < 1)
	{
		return ret;
	}
	var tpos = pageRangeSetting.indexOf("|");
	if (tpos == -1)
	{
		ret['range'] = pageRangeSetting;
		return ret;
	}
	ret['range'] = pageRangeSetting.substring(0, tpos);
	var tpos1 = pageRangeSetting.indexOf("|", tpos + 1);
	if (tpos1 == -1)
	{
		ret['subRangeMode'] = pageRangeSetting.substring(tpos + 1);
		return ret;
	}
	ret['subRangeMode'] = pageRangeSetting.substring(tpos + 1, tpos1);
	ret['reverseOrder'] = pageRangeSetting.substring(tpos1 + 1).toLowerCase() === "true";
	return ret;
};