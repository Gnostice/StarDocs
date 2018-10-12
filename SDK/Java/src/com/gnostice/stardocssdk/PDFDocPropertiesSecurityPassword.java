package com.gnostice.stardocssdk;

/* 
 * Gnostice StarDocs v1
 * Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/


public class PDFDocPropertiesSecurityPassword extends DocPropertiesSecurity
{
	// Properties
	private PDFEncryptionLevel PDFEncryptionLevel;
	private PasswordType SuppliedPassword;
	private boolean HasOpenPassword;
	private boolean HasPermissionsPassword;
	private PDFDocPermissions PDFDocPermissions;

	// Ctors
	public PDFDocPropertiesSecurityPassword(CommonInt.RestAPIDocPropertiesSecurity apiResponse)
	{
		// Decode encryption level
		String strEncryptionLevel = apiResponse.encryptionLevel.toLowerCase();
		if (strEncryptionLevel.equals("aes_128bit"))
		{
			setPDFEncryptionLevel(getPDFEncryptionLevel().AES_128bit);
		}
		else if (strEncryptionLevel.equals("rc4_128bit"))
		{
			setPDFEncryptionLevel(getPDFEncryptionLevel().RC4_128bit);
		}
		else if (strEncryptionLevel.equals("rc4_40bit"))
		{
			setPDFEncryptionLevel(getPDFEncryptionLevel().RC4_40bit);
		}
		else if (strEncryptionLevel.equals("none"))
		{
			setPDFEncryptionLevel(getPDFEncryptionLevel().None);
		}
		else
		{
			// Todo: Throw exception
			throw new RuntimeException("Unexpected encryption level");
		}

		// Decode supplied password type
		String strSuppliedPassword = apiResponse.suppliedPassword.toLowerCase();
		if (strSuppliedPassword.equals("open"))
		{
			setSuppliedPassword(PasswordType.Open);
		}
		else if (strSuppliedPassword.equals("permissions"))
		{
			setSuppliedPassword(PasswordType.Permissions);
		}
		else if (strSuppliedPassword.equals("none"))
		{
			setSuppliedPassword(PasswordType.None);
		}
		else
		{
			// Todo: Throw exception
			throw new RuntimeException("Unexpected supplied password type");
		}

		setHasOpenPassword(apiResponse.hasOpenPassword);
		setHasPermissionsPassword(apiResponse.hasPermissionsPassword);
		var permissions = apiResponse.permissions;
		setPDFDocPermissions(new PDFDocPermissions(permissions.allowAccessibility, permissions.allowAssembly, permissions.allowCopy, permissions.allowFormFill, permissions.allowHighResPrint, permissions.allowModifyAnnotations, permissions.allowModifyContents, permissions.allowPrinting));
	}

	public final PDFEncryptionLevel getPDFEncryptionLevel()
	{
		return PDFEncryptionLevel;
	}
	public final void setPDFEncryptionLevel(PDFEncryptionLevel value)
	{
		PDFEncryptionLevel = value;
	}
	
	public final PasswordType getSuppliedPassword()
	{
		return SuppliedPassword;
	}
	public final void setSuppliedPassword(PasswordType value)
	{
		SuppliedPassword = value;
	}

	public final boolean getHasOpenPassword()
	{
		return HasOpenPassword;
	}
	public final void setHasOpenPassword(boolean value)
	{
		HasOpenPassword = value;
	}

	public final boolean getHasPermissionsPassword()
	{
		return HasPermissionsPassword;
	}
	public final void setHasPermissionsPassword(boolean value)
	{
		HasPermissionsPassword = value;
	}

	public final PDFDocPermissions getPDFDocPermissions()
	{
		return PDFDocPermissions;
	}
	public final void setPDFDocPermissions(PDFDocPermissions value)
	{
		PDFDocPermissions = value;
	}

	// Methods
}