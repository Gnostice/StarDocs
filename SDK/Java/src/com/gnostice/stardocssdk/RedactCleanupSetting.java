package com.gnostice.stardocssdk;

/** 
 Defines cleanup actions to be carried out after text redaction.
*/
public enum RedactCleanupSetting
{
	/** 
	 Whether empty bookmarks should be deleted after redact. Default is true. 
	*/
	RemoveEmptyBookmarks,
	/** 
	 Whether empty bookmark actions should be deleted after redact. Default is true. 
	*/
	RemoveEmptyBookmarkActions,
	/** 
	 Whether empty annotations should be deleted after redact. Default is true. 
	*/
	RemoveEmptyAnnotations,
	/** 
	 Whether empty annotation actions should be deleted after redact. Default is true. 
	*/
	RemoveEmptyAnnotationActions,
	/** 
	 Whether touched link actions should be deleted after redact. Default is true. 
	*/
	RemoveAffectedLinkActions;
}