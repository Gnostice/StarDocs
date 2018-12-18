/* 
 * Gnostice StarDocs
 * Copyright © Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/

'use strict';

/*\
|*|
|*|  Polyfill which enables the passage of arbitrary arguments to the
|*|  callback functions of JavaScript timers (HTML5 standard syntax).
|*|
|*|  https://developer.mozilla.org/en-US/docs/DOM/window.setInterval
|*|
|*|  Syntax:
|*|  var timeoutID = window.setTimeout(func, delay[, param1, param2, ...]);
|*|  var timeoutID = window.setTimeout(code, delay);
|*|  var intervalID = window.setInterval(func, delay[, param1, param2, ...]);
|*|  var intervalID = window.setInterval(code, delay);
|*|
\*/

(function() {
  setTimeout(function(arg1) {
    if (arg1 === 'test') {
      // feature test is passed, no need for polyfill
      return;
    }
    var __nativeST__ = window.setTimeout;
    window.setTimeout = function(vCallback, nDelay /*, argumentToPass1, argumentToPass2, etc. */ ) {
      var aArgs = Array.prototype.slice.call(arguments, 2);
      return __nativeST__(vCallback instanceof Function ? function() {
        vCallback.apply(null, aArgs);
      } : vCallback, nDelay);
    };
  }, 0, 'test');

  var interval = setInterval(function(arg1) {
    clearInterval(interval);
    if (arg1 === 'test') {
      // feature test is passed, no need for polyfill
      return;
    }
    var __nativeSI__ = window.setInterval;
    window.setInterval = function(vCallback, nDelay /*, argumentToPass1, argumentToPass2, etc. */ ) {
      var aArgs = Array.prototype.slice.call(arguments, 2);
      return __nativeSI__(vCallback instanceof Function ? function() {
        vCallback.apply(null, aArgs);
      } : vCallback, nDelay);
    };
  }, 0, 'test');
}())

/* Namespace: Gnostice */
var Gnostice = Gnostice || {};

/* ConnectionInfo */
Gnostice.ConnectionInfo = function(apiServerUrl, apiKey, apiSecret, serverTimeout, docOperationTimeout) {
	this.apiServerVersion = '2.0.0';
	this.apiServerUrl = apiServerUrl || '';
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

	/* URL parts */
	this.urlSegAuthToken = '/auth/token';
	this.urlSegDocs = '/docs';
	this.urlSegDocsOps = '/docs/ops';
	this.urlSegOps = '/ops';
	this.urlSegInfo = '/info';
	this.urlSegSearchText = '/search-text';
	this.urlSegRedactText = '/redact-text';
	this.urlSegMetaTags = '/meta/tags';
	this.urlSegMetaOwner = '/meta/owner';
	this.urlSegMetaFilename = '/meta/filename';
	this.urlSegUsers = '/users';
	this.urlSegViewSessions = '/viewsessions';
	this.urlSegMiscTags = '/misc/tags';
	this.urlSegMiscGroups = '/misc/groups';
	this.urlMiscPhysicalStores = '/misc/physicalstores';
	this.urlMiscDocumenTreeViews = '/misc/documenttreeviews';

	/* Constants */
	this.pollInterval = 1000 * 1;			// 1 second
	this.pollRetryMaxCount = 60 * 10;	// 10 minutes

	/* Internal settings passed when SDK is used in viewer */
	this.documentPassword = null;
	this.setDocumentPassword = function(password) {
		this.documentPassword = password;
	};
	this.viewSessionId = null;
	this.setViewSessionId = function(sessionId) {
		this.viewSessionId = sessionId;
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
		var authTokenUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegAuthToken;
		console.log("In Auth.login: " + username);
		// Use OAuth2 to request access token (grant type: password)
		var self = this;
		var encodedHeader;
		if (window.btoa) {
			encodedHeader = "Basic " + btoa(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret);
		}
		else {	// for IE9
			encodedHeader = "Basic " + jQuery.base64.encode(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret);
		}
		var deferred = $.ajax({
			url: authTokenUrl,
			type: 'POST',
			dataType: 'json',	// Expected
			beforeSend: function(xhr) { 
				xhr.setRequestHeader(
					"Authorization", encodedHeader
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
		var authTokenUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegAuthToken;
		if (entityId != null) {
			authTokenUrl += '?entity_id=' + entityId;
		}
		console.log("In loginApp");
		var self = this;
		var encodedHeader;
		if (window.btoa) {
			encodedHeader = "Basic " + btoa(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret);
		}
		else {	// for IE9
			encodedHeader = "Basic " + jQuery.base64.encode(self.starDocs.connectionInfo.apiKey + ":" + self.starDocs.connectionInfo.apiSecret);
		}
		var deferred = $.ajax({
			url: authTokenUrl,
			type: 'POST',
			dataType: 'json',	// Expected
			beforeSend: function(xhr) { 
				xhr.setRequestHeader(
					"Authorization", encodedHeader
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
	// fileObject - File selected by user taken from <input type="file"> element. See https://developer.mozilla.org/en-US/docs/Web/API/File
	// password - Password if the document is encrypted
	Storage.prototype.upload = function(fileObject, password, uploadFromViewer) {
		// Currently we only support a single file upload at a time
		console.log('Uploading ' + fileObject);
		var formData = new FormData();
		formData.append('fileUpload', fileObject);
		if (password != null) {
			formData.append('password', password);
		}
		formData.append('forceFullPermission', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (uploadFromViewer && this.starDocs.viewSessionId != null) {
			formData.append('viewSessionId', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		}
		var docsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocs;
		var self = this;
		var deferred = this.starDocs.doAjaxWithBody('POST', docsUrl, formData);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Upload file(s) using external URL
	// fileUrl - External URL to file
	// password - Password if the document is encrypted
	Storage.prototype.uploadFromURL = function(fileUrl, password, uploadFromViewer) {
		console.log('Uploading ' + fileUrl);
		var formData = new FormData();
		formData.append('fileURL', fileUrl);
		if (password != null) {
			formData.append('password', password);
		}
		formData.append('forceFullPermission', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (uploadFromViewer && this.starDocs.viewSessionId != null) {
			formData.append('viewSessionId', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		}
		var docsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocs;
		var self = this;
		var deferred = this.starDocs.doAjaxWithBody('POST', docsUrl, formData);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};

	// Make a copy of a file present on StarDocs server
	// docURL - URL of file on StarDocs server
	// password - Password if the document is encrypted
	Storage.prototype.copyFrom = function(docUrl, password) {
		return this.uploadFromURL(docUrl, password);
	};

	// Upload file via a buffer
	// fileBuffer - Buffer containing file data (as byte array - Uint8Array)
	// fileName - Name for the uploaded file
	// password - Password if the document is encrypted
	Storage.prototype.uploadFromBuffer = function(fileBuffer, fileName, password, uploadFromViewer) {
		console.log('Uploading from buffer');
		// Convert from byte array to string
		var binaryStr = '';
		var len = fileBuffer.byteLength;
    for (var i = 0; i < len; i++) {
        binaryStr += String.fromCharCode(fileBuffer[ i ]);
    }
		var formData = new FormData();
		var fileBufferBase64 = jQuery.base64.encode(binaryStr);
		formData.append('fileBuffer', fileBufferBase64);
		if (fileName != null) {
			formData.append('fileName', fileName);
		}
		if (password != null) {
			formData.append('password', password);
		}
		formData.append('forceFullPermission', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (uploadFromViewer && this.starDocs.viewSessionId != null) {
			formData.append('viewSessionId', this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		}
		var docsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocs;
		var self = this;
		var deferred = this.starDocs.doAjaxWithBody('POST', docsUrl, formData);
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

		var docsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocs;
		for (var i=0; i < searchClauseList.length; ++i) {
			if (i === 0) {
				docsUrl += "?";
			}
			docsUrl += searchClauseList[i];
			if (i < searchClauseList.length) {
				docsUrl += "&";
			}
		}
		var deferred = this.starDocs.doAjax('GET', docsUrl);
		
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
	Storage.prototype.download = function(docUrl, download) {
		console.log("Downloading " + docUrl);
		if (typeof download !== 'boolean') {
			download = true;
		}
		if (download) {
			// Download (as in save to computer) is NOT currently possible via AJAX so ask the browser to download instead
			// Since it's not possible to set any headers (Bearer auth), supply the token via url params
			// Return a deferred object that immediately completes successfully
			var fileUrl = docUrl;
			if (this.starDocs.auth.accessToken !== null) {
				fileUrl += '?bearer_token=' + this.starDocs.auth.accessToken;
			}
			console.log ("url: " + fileUrl);
			return $.Deferred().resolve(
				window.open(fileUrl, '_blank')).promise();
		}
		else {
			var self = this;
			var deferred = this.starDocs.doAjax('GET', docUrl, 'text');
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

	// Get a download URL
	Storage.prototype.getDownloadUrl = function(docUrl) {
		var fileUrl = new URI(docUrl);
		if (this.starDocs.auth.accessToken !== null) {
			fileUrl = fileUrl.setQuery('bearer_token', this.starDocs.auth.accessToken);
		}
		else {
			return $.Deferred().reject(401, 'You need to authenticate before calling this method.').promise();
		}
		return $.Deferred().resolve(fileUrl).promise();
	};

	// Delete file
	Storage.prototype.delete = function(docUrl) {
		console.log("Deleting " + docUrl);
		var deferred = this.starDocs.doAjax('DELETE', docUrl);
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
	Storage.prototype.setTags = function(docUrl, tags) {
		console.log("Setting tags on  " + docUrl);
		var self = this;
		var tagsUrl = docUrl + this.starDocs.urlSegMetaTags;
		var body = JSON.stringify({'tags': tags});
		var deferred = this.starDocs.doAjaxWithBody('POST', tagsUrl, body, 'application/json; charset=utf-8');
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
	Storage.prototype.updateOwner = function(docUrl, newOwnerUserNameEmail, resetSharing, retainRights) {
		console.log("Updating owner for " + docUrl);
		var docOwnerUrl = docUrl + this.starDocs.urlSegMetaOwner;
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
		var deferred = this.starDocs.doAjaxWithBody('PUT', docOwnerUrl, body, 'application/json; charset=utf-8');
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
	Storage.prototype.rename = function(docUrl, newFilename) {
		console.log("Updating filename for " + docUrl);
		var docOwnerUrl = docUrl + this.starDocs.urlSegMetaFilename;
		var req = { 'fileName': newFilename };
		var body = JSON.stringify(req);
		var deferred = this.starDocs.doAjaxWithBody('PUT', docOwnerUrl, body, 'application/json; charset=utf-8');
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
		var docsOpsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocsOps + "/merge";
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
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUrl, body, 'application/json; charset=utf-8');
	};
	
	// Split files given a range of pages
	// docUrl - String
	// password - String
	// pageRangeSettings - JS array each item being an object having schema { range: <string>, subRangeMode: <string>, reverseOrder: <boolean> }
	DocOperations.prototype.splitRange = function(docUrl, password, pageRangeSettings) {
		var docsOpsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocsOps + "/split-range";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{'url': docUrl, 'pageRanges':[]}]};
		if (password != null) {
			jsonBody.documents[0].password = passwords;
		}
		if (pageRangeSettings != null) {
			jsonBody.documents[0].pageRanges = pageRangeSettings;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUrl, body, 'application/json; charset=utf-8');
	};

	// Split files at separator (blank) pages
	// docUrl - String
	// password - String
	DocOperations.prototype.splitSeparatorPage = function(docUrl, password) {
		var docsOpsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocsOps + "/split-separator";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{'url': docUrl, 'separatorType': 'emptyPage'}]};
		if (password != null) {
			jsonBody.documents[0].password = passwords;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUrl, body, 'application/json; charset=utf-8');
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
	pdfEncoderSettings - JS object having schema 
		{
			portfolioSettings: 
			{
				creationMode: <string>,
				initialLayout: <string>
			},
			fontEmbedding: <string>,
			overrideFontEmbeddingRestriction: <boolean>
		}
	digitizerSettings - JS object having schema 
		{
			digitizationMode: <string>,
			documentLanguages: 
			[
				<string>, ...
			],
			recognizeElements: 
			[
				<string>, ...
			],
			skewCorrection: <boolean>,
			imageEnhancementSettings: 
			{
				enhancementMode: <string>,
				enhancementTechniques: 
				[
					<string>, ...
				],
				scalingFactor: <float>
			}
		}
	*/
	DocOperations.prototype.convertToPDF = function(conversionMode, docUrls, passwords, pageRangeSettings, pdfEncoderSettings, digitizerSettings) {
		return this.convertToImage("convert-pdf", docUrls, passwords, pageRangeSettings, null, null, conversionMode, pdfEncoderSettings, digitizerSettings);
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
		var docsOpsUrl = docUrl + this.starDocs.urlSegOps + "/encrypt";
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
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUrl, body, 'application/json; charset=utf-8');
	};

	// Search for text in PDF files
	/* 
	docUrl - String
	password - String
	pageRange - String of the form "a,b-d"
	mode - String ('literal' or 'regex')
	text - Array of JS objects having schema { text: <string>, caseSensitive: <boolean>, wholeWord: <boolean> }
	scope - JS object having schema
		{
			pageText: <boolean>,
			pageImages: <boolean>,
			bookmarks: <boolean>,
			bookmarkActions: <boolean>,
			annotations: <boolean>,
			annotationActions: <boolean>,
			documentProperties: <boolean>
		}
	*/
	DocOperations.prototype.searchText = function(docUrl, password, pageRange, mode, text, scope) {
		var docsOpsUrl = new URI(docUrl).segment(this.starDocs.urlSegOps + this.starDocs.urlSegSearchText)
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (password != null) {
			docsOpsUrl = docsOpsUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			docsOpsUrl = docsOpsUrl.setQuery("password", this.starDocs.documentPassword);
		}
		
		if (pageRange != null && pageRange != "") {
			docsOpsUrl = docsOpsUrl.setQuery("page_range", pageRange);
		}
		
		if (mode != null) {
			docsOpsUrl = docsOpsUrl.setQuery("mode", mode);
		}
		
		if (text != null && text instanceof Array) {
			for (var i=0; i < text.length; ++i) {
				var t = text[i];
				if (t.text == null || t.text == "") {
					continue;
				}
				var caseSensitive = (t.caseSensitive === true);
				var wholeWord = (t.wholeWord === true);
				var paramName = "text";
				if (caseSensitive && wholeWord) {
					paramName = "text_case_word";
				}
				else if (caseSensitive && !wholeWord) {
					paramName = "text_case";
				}
				else if (!caseSensitive && wholeWord) {
					paramName = "text_word";
				}
				docsOpsUrl = docsOpsUrl.setQuery(paramName, t.text);
			}
		}

		if (scope != null && typeof scope === 'object') {
			if (scope.pageText === false) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_page_text", false);
			}
			if (scope.pageImages === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_page_images", true);
			}
			if (scope.bookmarks === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_bookmarks", true);
			}
			if (scope.bookmarkActions === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_bookmark_actions", true);
			}
			if (scope.annotations === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_annotations", true);
			}
			if (scope.annotationActions === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_annotation_actions", true);
			}
			if (scope.documentProperties === true) {
				docsOpsUrl = docsOpsUrl.setQuery("scope_document_properties", true);
			}
		}
		
		return this.starDocs.doAjaxAndPoll('GET', docsOpsUrl.toString());
	};

	// Redact text from PDF files
	/* 
	docUrl - String
	password - String
	pageRangeSettings - JS object having schema { range: <string>, subRangeMode: <string> }
	searchMode - String
	searchText - Array of JS objects having schema { text: <string>, caseSensitive: <boolean>, wholeWord: <boolean> }
	removeAssociatedAnnotations - Boolean to indicate whether annotations associated with the redacted text should also be removed. Default is false.
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
	DocOperations.prototype.redactText = function(docUrl, password, pageRangeSettings, searchMode, searchText, removeAssociatedAnnotations, fillSettings, includeAdditionalItems, cleanupSettings) {
		var docsOpsUrl = docUrl + this.starDocs.urlSegOps + this.starDocs.urlRedactText;
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
		if (removeAssociatedAnnotations != null) {
			jsonBody.removeAssociatedAnnotations = removeAssociatedAnnotations;
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
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUrl, body, 'application/json; charset=utf-8');
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
	* @param {boolean} flattenAllFields Some comment
	*/
	DocOperations.prototype.fillForm = function(docUrl, password, fields, flattenAllFields) {
		var docsOpsUrl = docUrl + this.starDocs.urlSegOps + "/fill-form";
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission};
		if (password != null) {
			jsonBody.password = password;
		}
		if (fields != null) {
			jsonBody.fields = fields;
		}
		if (flattenAllFields === true) {
			jsonBody.flattenAllFields = flattenAllFields;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('PUT', docsOpsUrl, body, 'application/json; charset=utf-8');
	};

	// Internal method, do not use!
	DocOperations.prototype.convertToImage = function(urlPart, docUrls, passwords, pageRangeSettings, imageEncoderSettings, tiffCompressionType, conversionMode, pdfEncoderSettings, digitizerSettings) {
		var docsOpsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegDocsOps + "/" + urlPart;
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
		if (digitizerSettings != null) {
			jsonBody.digitizerSettings = digitizerSettings;
		}
		var body = JSON.stringify(jsonBody);
		return this.starDocs.doAjaxWithBodyAndPoll('POST', docsOpsUrl, body, 'application/json; charset=utf-8');
	};

	
	// Get document info
	DocOperations.prototype.getDocInfo = function(docUrl, password) {
		var docInfoUrl = new URI(docUrl).segment(this.starDocs.urlSegInfo)
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (password != null) {
			docInfoUrl = docInfoUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			docInfoUrl = docInfoUrl.setQuery("password", this.starDocs.documentPassword);
		}

		return this.starDocs.doAjaxAndPoll('GET', docInfoUrl.toString());
	};

	// Get bookmarks
	DocOperations.prototype.getDocBookmarks = function(docUrl, password) {
		var docBookmarksUrl = new URI(docUrl).segment("bookmarks")
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (password != null) {
			docBookmarksUrl = docBookmarksUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			docBookmarksUrl = docBookmarksUrl.setQuery("password", this.starDocs.documentPassword);
		}

		return this.starDocs.doAjaxAndPoll('GET', docBookmarksUrl.toString());
	};

	// Get page image
	DocOperations.prototype.getPageImage = function(pageUrl, renderingSettings, password) {
		renderingSettings = renderingSettings || {};
		var pageUrlObj = new URI(pageUrl)
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (renderingSettings.dpi != null) {
			pageUrlObj = pageUrlObj.setQuery("dpi", renderingSettings.dpi)
		}
		if (renderingSettings.renderFormFields != null) {
			pageUrlObj = pageUrlObj.setQuery("render-form-fields", renderingSettings.renderFormFields)
		}
		if (password != null) {
			pageUrlObj = pageUrlObj.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageUrlObj = pageUrlObj.setQuery("password", this.starDocs.documentPassword);
		}

		return this.starDocs.doAjaxAndPoll('GET', pageUrlObj.toString());
	};
	
	// Get page image
	DocOperations.prototype.getPageThumbnail = function(pageUrl, renderingSettings, password) {
		renderingSettings = renderingSettings || {};
		var pageThumbnailUrl = new URI(pageUrl).segment("thumbnail")
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (renderingSettings.dpi != null) {
			pageThumbnailUrl = pageThumbnailUrl.setQuery("dpi", renderingSettings.dpi)
		}
		if (renderingSettings.renderFormFields != null) {
			pageThumbnailUrl = pageThumbnailUrl.setQuery("render-form-fields", renderingSettings.renderFormFields)
		}
		if (password != null) {
			pageThumbnailUrl = pageThumbnailUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageThumbnailUrl = pageThumbnailUrl.setQuery("password", this.starDocs.documentPassword);
		}

		return this.starDocs.doAjaxAndPoll('GET', pageThumbnailUrl.toString());
	};

	// Note: For internal viewer use only!
	// Get list of page image URLs for the given document. This is for use by the viewer for printing the document.
	DocOperations.prototype.getDocumentPrintImageURLs = function(docUrl, password) {
		var docOpsUrl = new URI(docUrl).segment(this.starDocs.urlSegOps).segment("prepare-print-images"); // Append "/ops/prepare-print-images"
		var jsonBody = {'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission};
		if (password != null) {
			jsonBody.password = passwords;
		}
		else if (this.starDocs.documentPassword != null) {
			jsonBody.password = this.starDocs.documentPassword;
		}

		var body = JSON.stringify(jsonBody);
		var returnDeferred = $.Deferred();
		var that = this;
		this.starDocs.doAjaxWithBodyAndPoll('POST', docOpsUrl.toString(), body, 'application/json; charset=utf-8').done(function(response) {
			// Construct page image URLs and return them
			console.log("In getDocumentPrintImageURLs: Pages ready " + response);
			var pageImageUrls = [];
			var largestRenderedPageCount = response.largestRenderedPageCount;
			var pagesUrl = new URI(docUrl).segment('pages');
			for (var pageNum = 1; pageNum <= largestRenderedPageCount; ++pageNum) {
				var pageImageUrl = pagesUrl.toString() + "/" + pageNum + "/image";
				var pageImageDownloadUrl = new URI(pageImageUrl).setQuery('bearer_token', that.starDocs.auth.accessToken).toString();
				pageImageUrls.push(pageImageDownloadUrl);
			}
			returnDeferred.resolve(pageImageUrls);
		})
		.fail(function(status, errorThrown, response) {
			console.log("In getDocumentPrintImageURLs: fail event called");
			returnDeferred.reject(status, errorThrown, response);
		});
		return returnDeferred.promise();
	};

	// Get page form fields
	DocOperations.prototype.getPageFormFields = function(pageUrl, password) {
		var pageFormFieldsUrl = new URI(pageUrl).segment("formfields")
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (password != null) {
			pageFormFieldsUrl = pageFormFieldsUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageFormFieldsUrl = pageFormFieldsUrl.setQuery("password", this.starDocs.documentPassword);
		}
		return this.starDocs.doAjaxAndPoll('GET', pageFormFieldsUrl.toString());
	};

	// Get page text
	DocOperations.prototype.getPageText = function(pageUrl, password) {
		var pageTextUrl = new URI(pageUrl)
			.segment("text")
			.setQuery("force-full-permission", this.starDocs.preferences.docPasswordSettings.forceFullPermission);
		if (password != null) {
			pageTextUrl = pageTextUrl.setQuery("password", password);
		}
		else if (this.starDocs.documentPassword != null) {
			pageTextUrl = pageTextUrl.setQuery("password", this.starDocs.documentPassword);
		}
		
		return this.starDocs.doAjaxAndPoll('GET', pageTextUrl.toString());
	};

	/* User management related APIs */
	var UserMgmt = function(starDocs) {
		this.starDocs = starDocs;
	};
	UserMgmt.prototype.constructor = UserMgmt;
	
	// Get list of users
	UserMgmt.prototype.listUsers = function() {
		var usersUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegUsers;
		var deferred = this.starDocs.doAjax('GET', usersUrl);
		return deferred.then(
			function(response, textStatus, jqXhr) {
				return $.Deferred().resolve(response).promise();
			},
			function(jqXhr, textStatus, errorThrown) {
				return $.Deferred().reject(jqXhr.status, errorThrown, jqXhr.responseJSON).promise();
			}
		);
	};
	
	// Get details of a specific user (given URL)
	// if userUrl is ommitted then details of currently logged-in user is returned
	UserMgmt.prototype.getUserDetails = function(userUrl) {
		userUrl = userUrl || this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegUsers + "/me";
		var deferred = this.starDocs.doAjax('GET', userUrl);
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
		var viewSessionsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegViewSessions;
		viewerSettings = viewerSettings || {};
		password = password || "";
		var body = JSON.stringify({'forceFullPermission': this.starDocs.preferences.docPasswordSettings.forceFullPermission, 'documents': [{ 'url': docUrl, 'password': password }], 'viewerSettings': viewerSettings});
		var deferred = this.starDocs.doAjaxWithBody('POST', viewSessionsUrl, body, 'application/json; charset=utf-8');
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
		var tagsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegMiscTags;
		var deferred = this.starDocs.doAjax('GET', tagsUrl);
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
		var groupsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlSegMiscGroups;
		var deferred = this.starDocs.doAjax('GET', groupsUrl);
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
		var physicalStoresUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlMiscPhysicalStores;
		var deferred = this.starDocs.doAjax('GET', physicalStoresUrl);
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
		var documentTreeViewsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlMiscDocumenTreeViews;
		var deferred = this.starDocs.doAjax('GET', documentTreeViewsUrl);
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
		var documentTreeViewsUrl = this.starDocs.connectionInfo.apiServerUrl + this.starDocs.urlMiscDocumenTreeViews;
		var body = JSON.stringify({'documentTreeView': {'name': name, 'tagKeys': tags}});
		var deferred = this.starDocs.doAjaxWithBody('POST', documentTreeViewsUrl, body, 'application/json; charset=utf-8');
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
	Misc.prototype.editDocumentTreeView = function(documentTreeViewsUrl, name, tags) {
		var body = JSON.stringify({'documentTreeView': {'name': name, 'tagKeys': tags}});
		var deferred = this.starDocs.doAjaxWithBody('PUT', documentTreeViewsUrl, body, 'application/json; charset=utf-8');
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
	Misc.prototype.deleteDocumentTreeView = function(url) {
		console.log("Deleting " + url);
		var deferred = this.starDocs.doAjax('DELETE', url);
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

Gnostice.StarDocs.prototype.doAjax = function(method, url, expectedDataType) {
	var self = this;
	return $.ajax({
		url: url,
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

Gnostice.StarDocs.prototype.doAjaxWithBody = function(method, url, body, bodyContentType, expectedDataType) {
	var self = this;
	return $.ajax({
		url: url,
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

Gnostice.StarDocs.prototype.doAjaxAndPoll = function(method, url, expectedDataType) {
		var deferred = this.doAjax(method, url, expectedDataType);
		var that = this;
		return deferred.then(
			function(response, textStatus, jqXhr) {
				if (jqXhr.status === 200) {
					return $.Deferred().resolve(response).promise();
				}
				else if (jqXhr.status === 202) {
					// Result is not ready so we need to poll
					var newDeferred = $.Deferred();
					var pollUrl = new URI(jqXhr.getResponseHeader("location"));
					if (that.preferences.docPasswordSettings.forceFullPermission) {
						pollUrl = pollUrl.setQuery("force-full-permission", true);
					}
					if (that.documentPassword != null) {
						pollUrl = pollUrl.setQuery("password", that.documentPassword);
					}
					setTimeout(that.doPoll, that.pollInterval, pollUrl.toString(), newDeferred, that, 1);
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

Gnostice.StarDocs.prototype.doAjaxWithBodyAndPoll = function(method, url, body, bodyContentType, expectedDataType) {
		var deferred = this.doAjaxWithBody(method, url, body, bodyContentType, expectedDataType);
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

Gnostice.bindInterFrameFunctions = function(chan, docViewerObj) {

	// WARNING: Deprecated. Use Forms.submitForm instead.
	// submitForm method
	chan.bind("submitForm", function(trans, params) {
		params = params || {};
		docViewerObj.forms.submitForm(params.submitUrl, params.submitMethod, params.includeNoValueFields, params.submitFields, params.isIncludeList)
		.done(function(data, textStatus, jqXHR){
			trans.complete(data);
		})
		.fail(function(jqXhr, textStatus, errorThrown) {
			trans.error(textStatus, errorThrown);
		});
		trans.delayReturn(true);
	});

	// WARNING: Deprecated. Use Forms.resetForm instead.
	// resetForm method
	chan.bind("resetForm", function(context, params) {
		params = params || {};
		return docViewerObj.forms.resetForm(params.resetFields, params.isIncludeList);
	});

	// Clone the properties of the form field excluding few
	var simplifyFormField = function(formField) {
		if (formField == null) {
			return null;
		}
		var retFormField = {};
		var excludeProps = ["_formsModule", "_widget"];
		for (var key in formField) {
			if (formField.hasOwnProperty(key) && !excludeProps.includes(key)) {
				if (key === "radioButtons") {
					retFormField[key] = [];
					for (var i = 0; i < formField[key].length; ++i) {
						retFormField[key].push(simplifyFormField(formField[key][i]));
					}
				}
				else {
					retFormField[key] = formField[key];
				}
			}
		}
		// Also include "value" for all form fields (as string) 
		retFormField["value"] = formField.getValueAsString()
		return retFormField;
	};
	// Method invocation
	chan.bind("invokeFn", function(trans, params) {
		params = params || {};
		var fnName = params.fnName;
		var callerParams = params.params;
		// Synchronous functions
		if (fnName == "Forms.getFormField") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			return simplifyFormField(formField);
		}
		else if (fnName == "Forms.getAllFormFields") {
			var formFields = docViewerObj.forms.getAllFormFields();
			// Separate out the fields based on their type to make it possible to 
			// deserialize into appropriate objects on the server
			var retFormFields = {
				textFormFields: [],
				radioGroupFormFields: [],
				comboBoxFormFields: [],
				listBoxFormFields: [],
				checkBoxFormFields: [],
				submitPushButtonFormFields: [],
				resetPushButtonFormFields: [],
				simplePushButtonFormFields: []
			};
			for (var i = 0; i < formFields.length; ++ i) {
				var simpleFormField = simplifyFormField(formFields[i]);
				switch(simpleFormField.type) {
					case 'text': retFormFields.textFormFields.push(simpleFormField); break;
					case 'radioGroup': retFormFields.radioGroupFormFields.push(simpleFormField); break;
					case 'comboBox': retFormFields.comboBoxFormFields.push(simpleFormField); break;
					case 'listBox': retFormFields.listBoxFormFields.push(simpleFormField); break;
					case 'checkBox': retFormFields.checkBoxFormFields.push(simpleFormField); break;
					case 'submitPushButton': retFormFields.submitPushButtonFormFields.push(simpleFormField); break;
					case 'resetPushButton': retFormFields.resetPushButtonFormFields.push(simpleFormField); break;
					case 'simplePushButton': retFormFields.simplePushButtonFormFields.push(simpleFormField); break;
				}
			}
			return retFormFields;
		}
		else if (fnName == "Forms.getValueAsString") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null) {
				return formField.getValueAsString();
			}
			return null;
		}
		else if (fnName == "Forms.setValueAsString") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null) {
				formField.setValueAsString(callerParams.value);
				return true;
			}
			return false;
		}
		else if (fnName == "Forms.getRadioButtonSelectedIndex") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && formField.type === 'radioGroup') {
				return formField.getSelectedRadioButtonIndex();
			}
			return null;
		}
		else if (fnName == "Forms.setRadioButtonSelectedIndex") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && (formField instanceof gnostice.RadioGroupFormField)) {
				formField.setSelectedRadioButtonIndex(callerParams.selectedIndex);
				return true;
			}
			return false;
		}
		else if (fnName == "Forms.getComboListBoxSelectedItemIndices") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && (formField.type === 'comboBox' || formField.type === 'listBox')) {
				return formField.getSelectedItemIndices();
			}
			return null;
		}
		else if (fnName == "Forms.setComboListBoxSelectedItemIndices") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && (formField instanceof gnostice.ComboBoxFormField || formField instanceof gnostice.ListBoxFormField)) {
				formField.setSelectedItemIndices(callerParams.selectedIndices);
				return true;
			}
			return false;
		}
		else if (fnName == "Forms.setComboBoxValue") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && (formField instanceof gnostice.ComboBoxFormField)) {
				formField.setValue(callerParams.value);
				return true;
			}
			return false;
		}
		else if (fnName == "Forms.getCheckBoxChecked") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && formField.type === 'checkBox') {
				return formField.getChecked();
			}
			return null;
		}
		else if (fnName == "Forms.setCheckBoxChecked") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null && (formField instanceof gnostice.CheckBoxFormField)) {
				formField.setChecked(callerParams.checked);
				return true;
			}
			return false;
		}
		else if (fnName == "Forms.resetForm") {
			return docViewerObj.forms.resetForm(callerParams.resetFields, callerParams.isIncludeList);
		}
		else if (fnName == "Forms.focusForm") {
			return docViewerObj.forms.focusForm();
		}
		else if (fnName == "Forms.setFocus") {
			var formField = docViewerObj.forms.getFormField(callerParams.formFieldName);
			if (formField != null) {
				formField.setFocus();
				return true;
			}
			return false;
		}
		else if (fnName == "View.firstPage") {
			return docViewerObj.firstPage();
		}
		else if (fnName == "View.lastPage") {
			return docViewerObj.lastPage();
		}
		else if (fnName == "View.prevPage") {
			return docViewerObj.prevPage();
		}
		else if (fnName == "View.nextPage") {
			return docViewerObj.nextPage();
		}
		else if (fnName == "View.gotoPage") {
			return docViewerObj.gotoPage(callerParams.pageNum);
		}
		else if (fnName == "View.getPageCount") {
			return docViewerObj.getPageCount();
		}
		else if (fnName == "View.zoomIn") {
			return docViewerObj.zoomIn();
		}
		else if (fnName == "View.zoomOut") {
			return docViewerObj.zoomOut();
		}
		else if (fnName == "View.rotateClockwise") {
			return docViewerObj.rotatePagesClockwise();
		}
		else if (fnName == "View.rotateCounterClockwise") {
			return docViewerObj.rotatePagesCounterClockwise();
		}
		else if (fnName == "View.invertColors") {
			return docViewerObj.invertColors(callerParams.applyInversion);
		}
		else if (fnName == "download") {
			return docViewerObj.download();
		}
		else if (fnName == "downloadAs") {
			return docViewerObj.downloadAs(callerParams.extension);
		}
		else if (fnName == "print") {
			return docViewerObj.print();
		}
		else if (fnName == "uploadDocumentFromUri") {
			return docViewerObj.uploadDocumentFromUri(callerParams.uri);
		}
		else if (fnName == "uploadDocumentFromBuffer") {
			return docViewerObj.uploadDocumentFromBuffer(callerParams.bufferBase64);
		}
		else if (fnName == "save") {
			return docViewerObj.save();
		}
		// Asynchronous functions
		else if (fnName == "Forms.submitForm") {
			var submitMethod = 1;		// Post
			if (callerParams.submitMethod != null && callerParams.submitMethod.toUpperCase() == 'GET') {
				submitMethod = 0;
			}
			docViewerObj.forms.submitForm(callerParams.submitUrl, submitMethod, callerParams.includeNoValueFields, callerParams.submitFields, callerParams.isIncludeList)
			.done(function(data, textStatus, jqXHR){
				trans.complete(data, textStatus);
			})
			.fail(function(jqXhr, textStatus, errorThrown) {
				trans.error(textStatus, errorThrown);
			});
			trans.delayReturn(true);
		}
		else if (fnName == "Forms.addEventListener") {
			console.log("In child frame Forms.addEventListener");
			var eventName = callerParams.eventName;
			var formFieldSpec = callerParams.formFieldSpec;
			var callback = callerParams.eventCb;
			console.log("eventName=" + eventName + ", formFieldSpec=" + formFieldSpec);
			if (eventName != null && callback != null) {
				docViewerObj.forms.addEventListener(eventName, formFieldSpec, function(cbparams) {
					// Remove internal objects since they can't be serialized
					if (cbparams.hasOwnProperty('viewerManager')) {
						delete cbparams.viewerManager;
					}
					if (cbparams.hasOwnProperty("formField")) {
						cbparams.formField = simplifyFormField(cbparams.formField);
					}
					callback(cbparams);
				});
			}
			trans.delayReturn(true);
		}
		else {
			// Unknown function, return error
			trans.error("Unknown function: " + fnName, "");
		}
	});
};