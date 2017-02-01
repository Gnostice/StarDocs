package com.gnostice.stardocssdk;

public class Utils 
{
	// Just lower cases the first character
	public static String toCamelCase(String name)
	{
		return name.substring(0, 1).toLowerCase().concat(name.substring(1));
	}
}
