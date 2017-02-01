package com.gnostice.stardocssdk;

/** 
 Represents a form field and its fill data.
*/
public class PDFFormFieldFillData
{
	// Fields

	// Ctors
	/** 
	 Creates a new instance of this class with specified field name, value and flag to 
	 indicate whether the field should be flattened after filling.
	*/

	public PDFFormFieldFillData(String fieldName, String fieldValue)
	{
		this(fieldName, fieldValue, false);
	}

	public PDFFormFieldFillData(String fieldName)
	{
		this(fieldName, "", false);
	}

//C# TO JAVA CONVERTER NOTE: Java does not support optional parameters. Overloaded method(s) are created above:
//ORIGINAL LINE: public PDFFormFieldFillData(string fieldName, string fieldValue = "", bool flattenField = false)
	public PDFFormFieldFillData(String fieldName, String fieldValue, boolean flattenField)
	{
		setFieldName(fieldName);
		setFieldValue(fieldValue);
		setFlattenField(flattenField);
	}

	// Properties
	/** 
	 Gets or sets the field name.
	*/
	private String FieldName;
	public final String getFieldName()
	{
		return FieldName;
	}
	public final void setFieldName(String value)
	{
		FieldName = value;
	}
	/** 
	 Gets or sets the value to be filled in the field.
	*/
	private String FieldValue;
	public final String getFieldValue()
	{
		return FieldValue;
	}
	public final void setFieldValue(String value)
	{
		FieldValue = value;
	}
	/** 
	 Gets or sets a flag that indicates whether the form field should be 
	 flattened (finalized) after filling it.
	*/
	private boolean FlattenField;
	public final boolean getFlattenField()
	{
		return FlattenField;
	}
	public final void setFlattenField(boolean value)
	{
		FlattenField = value;
	}
}