package com.gnostice.stardocssdk;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.EnumSet;

/** 
 Represents a document-processing operation.
*/
public class DocOperations
{
	// Fields
	public DocOperationsInt docOperationsInt;

	// Ctors
	public DocOperations(StarDocs starDocs)
	{
		docOperationsInt = new DocOperationsInt(starDocs);
	}

	/** 
	 Get document information. This API returns meta information related to the document.
	 @param file File that needs to be checked.
	 @param password Password for decryption. Note that if a correct password is already known then this parameter is ignored.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/
	public final GetDocumentInfoResponse getDocumentInfo(FileObject file) throws URISyntaxException, StarDocsException
	{
		return getDocumentInfo(file, null);
	}

	public final GetDocumentInfoResponse getDocumentInfo(FileObject file, String password) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.getDocumentInfo(file, password);
	}


	/** 
	 Get document information properties of specified file.
	 @param file File whose document information properties are required.
	 @param password Password for decryption.
	public final GetPropertiesResponse getProperties(FileObject file)
	{
		return getProperties(file, null);
	}

	public final GetPropertiesResponse getProperties(FileObject file, String password)
	{
		return docOperationsInt.getProperties(file, password);
	}
	*/

	/** 
	 Sets document information properties for specified file.
	 @param file File whose document information properties needs to be set.
	 @param password Password for decryption.
	 @param properties Document information properties that need to be set for the documents.             
	public final DocObject setProperties(FileObject file, String password, DocProperties properties)
	{
		return docOperationsInt.setProperties(file, password, properties);
	}
	*/

	/*
	/// <summary>
	/// Get encryption settings of specified file.
	/// </summary>
	/// <param name="file">\File whose security settings are
	///                    required.</param>
	/// <param name="password">Password for decryption.</param>
	public GetPropertiesSecurityResponse getPropertiesSecurity(FileObject file, string password = null)
	{
	  return docOperationsInt.getPropertiesSecurity(file, password);
	}
	*/

	/** 
	 Merge specified files.
	 @param files Files that need to be merged.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Pages that need to be included in the merged output document.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/
	public final DocObject merge(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return merge(files, null, null);
	}

	public final DocObject merge(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return merge(files, passwords, null);
	}

	public final DocObject merge(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.merge(files, passwords, pageRanges);
	}

	/** 
	 Splits specified document by specified page range.
	 @param file Files that need to be split.
	 @param password Password for decryption.
	 @param pageRanges Page ranges in the files that need to be split as separate documents.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> splitByPageRange(FileObject file) throws URISyntaxException, StarDocsException
	{
		return splitByPageRange(file, null, null);
	}

	public final ArrayList<DocObject> splitByPageRange(FileObject file, String password) throws URISyntaxException, StarDocsException
	{
		return splitByPageRange(file, password, null);
	}

	public final ArrayList<DocObject> splitByPageRange(FileObject file, String password, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.splitByPageRange(file, password, pageRanges);
	}


	/** 
	 @param file Files that need to be split.
	 @param password Password for decryption.
	 @param pageSeparator               
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> splitBySeparatorPage(FileObject file) throws URISyntaxException, StarDocsException
	{
		return splitBySeparatorPage(file, null, null);
	}

	public final ArrayList<DocObject> splitBySeparatorPage(FileObject file, String password) throws URISyntaxException, StarDocsException
	{
		return splitBySeparatorPage(file, password, null);
	}

	public final ArrayList<DocObject> splitBySeparatorPage(FileObject file, String password, PageSeparator pageSeparator) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.splitBySeparatorPage(file, password, pageSeparator);
	}

	/** 
	 Encrypt specified file.
	 @param file \File that needs to be encrypted.
	 @param password Password for decryption.
	 @param pdfEncryptionLevel Encryption level for the output document.
	 @param newOpenPassword User password for the output document.
	 @param newPermissionsPassword Owner password for the output document.
	 @param newPermissions New document usage restrictions for the output document.        
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final DocObject encrypt(FileObject file, String password) throws URISyntaxException, StarDocsException
	{
		return encrypt(file, password, PDFEncryptionLevel.None, "", "", null);
	}

	public final DocObject encrypt(FileObject file, String password, PDFEncryptionLevel pdfEncryptionLevel) throws URISyntaxException, StarDocsException
	{
		return encrypt(file, password, pdfEncryptionLevel, "", "", null);
	}

	public final DocObject encrypt(FileObject file, String password, PDFEncryptionLevel pdfEncryptionLevel, String newOpenPassword, String newPermissionsPassword) throws URISyntaxException, StarDocsException
	{
		return encrypt(file, password, pdfEncryptionLevel, newOpenPassword, newPermissionsPassword, null);
	}

	public final DocObject encrypt(FileObject file, String password, PDFEncryptionLevel pdfEncryptionLevel, String newOpenPassword) throws URISyntaxException, StarDocsException
	{
		return encrypt(file, password, pdfEncryptionLevel, newOpenPassword, "", null);
	}

	public final DocObject encrypt(FileObject file, String password, PDFEncryptionLevel pdfEncryptionLevel, String newOpenPassword, String newPermissionsPassword, DocPermissions newPermissions) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.encrypt(file, password, pdfEncryptionLevel, newOpenPassword, newPermissionsPassword, newPermissions);
	}

	/** 
	 Search for text in specified PDF file.
	 @param file File in which text needs to be searched.
	 @param password Passwords of the files for decryption.
	 @param pageRange Pages where search needs to be performed.
	 @param textSearchMode Whether the search is for literal strings or with regular expressions.
	 @param searchText Text whose occurrences need to be found.
	 @param searchScope Specifes which document areas should be included in the search.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final SearchTextResponse searchText(FileObject file, String password, PageRange pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText) throws URISyntaxException, StarDocsException
	{
		return searchText(file, password, pageRange, 
				textSearchMode, searchText, EnumSet.of(SearchScope.PageText));
	}

	public final SearchTextResponse searchText(FileObject file, String password, PageRange pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, EnumSet<SearchScope> searchScope) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.searchText(file, password, pageRange, 
				textSearchMode, searchText, searchScope);
	}

	/** 
	 Redacts text in specified PDF file.
	 @param file File in which text needs to be redacted.
	 @param password Passwords of the files for decryption.
	 @param pageRange Pages where redaction needs to be performed.
	 @param textSearchMode Whether the search is for literal strings or with regular expressions.
	 @param searchText Text whose occurrences need to be redacted.
	 @param removeAssociatedAnnotations True if annotations associated with the redacted text (if any) should also be removed.
	 @param fillSettings How the redacted region needs to be replaced.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, boolean removeAssociatedAnnotations, 
			RedactFillSettings fillSettings, EnumSet<DocumentItem> includeAdditionalItems) throws URISyntaxException, StarDocsException
	{
		return redactText(file, password, pageRange, 
				textSearchMode, searchText, removeAssociatedAnnotations, 
				fillSettings, includeAdditionalItems, EnumSet.noneOf(RedactCleanupSetting.class));
	}

	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, boolean removeAssociatedAnnotations, 
			RedactFillSettings fillSettings) throws URISyntaxException, StarDocsException
	{
		return redactText(file, password, pageRange, 
				textSearchMode, searchText, removeAssociatedAnnotations, 
				fillSettings, EnumSet.noneOf(DocumentItem.class), EnumSet.noneOf(RedactCleanupSetting.class));
	}

	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, boolean removeAssociatedAnnotations) throws URISyntaxException, StarDocsException
	{
		return redactText(file, password, pageRange, 
				textSearchMode, searchText, removeAssociatedAnnotations, 
				null, EnumSet.noneOf(DocumentItem.class), EnumSet.noneOf(RedactCleanupSetting.class));
	}

	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText) throws URISyntaxException, StarDocsException
	{
		return redactText(file, password, pageRange, 
				textSearchMode, searchText, false, 
				null, EnumSet.noneOf(DocumentItem.class), EnumSet.noneOf(RedactCleanupSetting.class));
	}

	public final DocObject redactText(FileObject file, String password, PageRangeSettings pageRange, 
			TextSearchMode textSearchMode, ArrayList<SearchText> searchText, boolean removeAssociatedAnnotations, 
			RedactFillSettings fillSettings, EnumSet<DocumentItem> includeAdditionalItems, EnumSet<RedactCleanupSetting> cleanupSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.redactText(file, password, pageRange, 
				textSearchMode, searchText, removeAssociatedAnnotations, 
				fillSettings, includeAdditionalItems, cleanupSettings);
	}

	/** 
	 Fills a PDF form with the supplied values.
	 @param file File in which text needs to be redacted.
	 @param password Passwords of the files for decryption.
	 @param formFields List of fields containing their names, values and a flag to whether the field should be flattened after filling.
	 @param flattenAllFields Flatten (finalize) all the fields in the PDF form.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final DocObject fillForm(FileObject file, String password, ArrayList<PDFFormFieldFillData> formFields) throws URISyntaxException, StarDocsException
	{
		return fillForm(file, password, formFields, false);
	}

	public final DocObject fillForm(FileObject file, String password, ArrayList<PDFFormFieldFillData> formFields, boolean flattenAllFields) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.fillForm(file, password, formFields, flattenAllFields);
	}

	/** 
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToTIFF(files, null, null, null, TIFFCompressionType.Deflate);
	}
	
	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToTIFF(files, passwords, null, null, TIFFCompressionType.Deflate);
	}
	
	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToTIFF(files, passwords, pageRanges, null, TIFFCompressionType.Deflate);
	}

	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToTIFF(files, passwords, pageRanges, imageEncoderSettings, TIFFCompressionType.Deflate);
	}

	public final ArrayList<DocObject> convertToTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings, TIFFCompressionType tiffCompressionType) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToTIFF(files, passwords, pageRanges, imageEncoderSettings, tiffCompressionType);
	}

	/** 
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToMTIFF(files, null, null, null, TIFFCompressionType.Deflate, MTIFFConversionMode.ConvertToSeparateFiles);
	}

	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToMTIFF(files, passwords, null, null, TIFFCompressionType.Deflate, MTIFFConversionMode.ConvertToSeparateFiles);
	}
	
	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToMTIFF(files, passwords, pageRanges, null, TIFFCompressionType.Deflate, MTIFFConversionMode.ConvertToSeparateFiles);
	}
	
	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToMTIFF(files, passwords, pageRanges, imageEncoderSettings, TIFFCompressionType.Deflate, MTIFFConversionMode.ConvertToSeparateFiles);
	}

	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings, TIFFCompressionType tiffCompressionType) throws URISyntaxException, StarDocsException
	{
		return convertToMTIFF(files, passwords, pageRanges, imageEncoderSettings, tiffCompressionType, MTIFFConversionMode.ConvertToSeparateFiles);
	}

	public final ArrayList<DocObject> convertToMTIFF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings, TIFFCompressionType tiffCompressionType, MTIFFConversionMode conversionMode) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToMTIFF(files, passwords, pageRanges, imageEncoderSettings, tiffCompressionType, conversionMode);
	}

	/** 
	 Converts pages in current document to JPEG format.
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToJPEG(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToJPEG(files, null, null, null);
	}

	public final ArrayList<DocObject> convertToJPEG(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToJPEG(files, passwords, null, null);
	}

	public final ArrayList<DocObject> convertToJPEG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToJPEG(files, passwords, pageRanges, null);
	}

	public final ArrayList<DocObject> convertToJPEG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToJPEG(files, passwords, pageRanges, imageEncoderSettings);
	}

	/** 
	 Converts pages in current document to GIF format.
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 @return List containing converted GIF images. 
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToGIF(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToGIF(files, null, null, null);
	}

	public final ArrayList<DocObject> convertToGIF(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToGIF(files, passwords, null, null);
	}

	public final ArrayList<DocObject> convertToGIF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToGIF(files, passwords, pageRanges, null);
	}

	public final ArrayList<DocObject> convertToGIF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToGIF(files, passwords, pageRanges, imageEncoderSettings);
	}

	/** 
	 Converts pages in current document to BMP format.
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 @return List containing the bitmap images. 
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToBMP(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToBMP(files, null, null, null);
	}
	
	public final ArrayList<DocObject> convertToBMP(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToBMP(files, passwords, null, null);
	}

	public final ArrayList<DocObject> convertToBMP(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToBMP(files, passwords, pageRanges, null);
	}

	public final ArrayList<DocObject> convertToBMP(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToBMP(files, passwords, pageRanges, imageEncoderSettings);
	}

	/** 
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param imageEncoderSettings Conversion settings.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToPNG(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToPNG(files, null, null, null);
	}

	public final ArrayList<DocObject> convertToPNG(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToPNG(files, passwords, null, null);
	}

	public final ArrayList<DocObject> convertToPNG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToPNG(files, passwords, pageRanges, null);
	}

	public final ArrayList<DocObject> convertToPNG(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			ImageEncoderSettings imageEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToPNG(files, passwords, pageRanges, imageEncoderSettings);
	}

	/** 
	 @param files Files that need to be converted.
	 @param passwords Passwords of the files for decryption.
	 @param pageRanges Page ranges in the files that need to be converted.
	 @param pdfEncoderSettings Conversion settings.
	 * @throws StarDocsException 
	 * @throws URISyntaxException 
	*/

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files) throws URISyntaxException, StarDocsException
	{
		return convertToPDF(files, null, null, null, ConversionMode.ConvertToSeparateFiles, null);
	}

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords) throws URISyntaxException, StarDocsException
	{
		return convertToPDF(files, passwords, null, null, ConversionMode.ConvertToSeparateFiles, null);
	}
	
	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges) throws URISyntaxException, StarDocsException
	{
		return convertToPDF(files, passwords, pageRanges, null, ConversionMode.ConvertToSeparateFiles, null);
	}

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			PDFEncoderSettings pdfEncoderSettings) throws URISyntaxException, StarDocsException
	{
		return convertToPDF(files, passwords, pageRanges, pdfEncoderSettings, ConversionMode.ConvertToSeparateFiles, null);
	}

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			PDFEncoderSettings pdfEncoderSettings, ConversionMode conversionMode) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToPDF(files, passwords, pageRanges, pdfEncoderSettings, conversionMode, null);
	}

	public final ArrayList<DocObject> convertToPDF(ArrayList<FileObject> files, ArrayList<String> passwords, ArrayList<PageRangeSettings> pageRanges, 
			PDFEncoderSettings pdfEncoderSettings, ConversionMode conversionMode, ConverterDigitizerSettings digitizerSettings) throws URISyntaxException, StarDocsException
	{
		return docOperationsInt.convertToPDF(files, passwords, pageRanges, pdfEncoderSettings, conversionMode, digitizerSettings);
	}
}