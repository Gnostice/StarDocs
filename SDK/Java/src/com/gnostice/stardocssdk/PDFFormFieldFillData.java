package com.gnostice.stardocssdk;

/** 
 Represents a form field and its fill data.
*/
public class PDFFormFieldFillData
{
	// Properties
	private String FieldName;
	private String FieldValue;
	private boolean FlattenField;

	// Ctors
	/** 
	 Creates a new instance of this class with specified field name, value and flag to 
	 indicate whether the field should be flattened after filling.
	*/

	public PDFFormFieldFillData(String fieldName, String fieldValue)
	{
		this(fieldName, fieldValue, false);
	}

	public PDFFormFieldFillData(String fieldName, String fieldValue, boolean flattenField)
	{
		setFieldName(fieldName);
		setFieldValue(fieldValue);
		setFlattenField(flattenField);
	}

	/** 
	 Gets or sets the field name.
	*/
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
	public final boolean getFlattenField()
	{
		return FlattenField;
	}
	public final void setFlattenField(boolean value)
	{
		FlattenField = value;
	}
}