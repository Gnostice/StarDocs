package com.gnostice.stardocssdk;

import java.net.URISyntaxException;
import java.util.ArrayList;

/* 
 * Gnostice StarDocs v1
 * Copyright © Gnostice Information Technologies Private Limited, Bangalore, India
 * http://www.gnostice.com
 * 
*/

/** 
 Represents findings of a call to GetDocumentInfo method.
*/

public class SearchTextResponse
{
	public class BoundingRect
	{
		// Fields

		// Ctors
		BoundingRect(CommonInt.RestAPIBoundingRect apiResponse)
		{
			pageNum = apiResponse.pageNum;
			float x = apiResponse.rect.x;
			float y = apiResponse.rect.y;
			float width = apiResponse.rect.width;
			float height = apiResponse.rect.height;
			rect = new Rect(y, x, y + height, x + width);
		}

		// Properties
		private int pageNum;
		public int getPageNum()
		{
			return pageNum;
		}
		
		private Rect rect;
		public Rect getRect()
		{
			return rect;
		}

		// Methods
		@Override
		public String toString()
		{
			String res = "pageNum=" + pageNum + "\n";
			res += "\t" + rect.toString() + "\n";
			return res;
		}
	}
	public class SearchHit
	{
		// Fields

		// Ctors
		SearchHit(CommonInt.RestAPISearchHit apiResponse)
		{
			matchText = apiResponse.matchText;
			foundIn = parseSearchScope(apiResponse.foundIn);
			startPageNum = apiResponse.startPageNum;
			lineContainingText = apiResponse.lineContainingText;
			indexOfTextInLine = apiResponse.indexOfTextInLine;
			boundingRects = new ArrayList<BoundingRect>();
			for (CommonInt.RestAPIBoundingRect br: apiResponse.boundingRects)
			{
				boundingRects.add(new BoundingRect(br));
			}
		}

		private SearchScope parseSearchScope(String scope) 
		{
			if (scope.equalsIgnoreCase("pageText"))
			{
				return SearchScope.PageText;
			}
			else if (scope.equalsIgnoreCase("pageImages"))
			{
				return SearchScope.PageImages;
			}
			else if (scope.equalsIgnoreCase("documentProperties"))
			{
				return SearchScope.DocumentProperties;
			}
			else if (scope.equalsIgnoreCase("bookmarks"))
			{
				return SearchScope.Bookmarks;
			}
			else if (scope.equalsIgnoreCase("bookmarkActions"))
			{
				return SearchScope.BookmarkActions;
			}
			else if (scope.equalsIgnoreCase("annotations"))
			{
				return SearchScope.Annotations;
			}
			else if (scope.equalsIgnoreCase("annotationActions"))
			{
				return SearchScope.AnnotationActions;
			}
			
			return null;
		}

		// Properties
		private String matchText;
		public String getMatchText()
		{
			return matchText;
		}

		private SearchScope foundIn;
		public SearchScope getFoundIn()
		{
			return foundIn;
		}

		private int startPageNum;
		public int getStartPageNum()
		{
			return startPageNum;
		}
		
		private String lineContainingText;
		public String getLineContainingText()
		{
			return lineContainingText;
		}

		private int indexOfTextInLine;
		public int getIndexOfTextInLine()
		{
			return indexOfTextInLine;
		}

		private ArrayList<BoundingRect> boundingRects;
		public ArrayList<BoundingRect> getBoundingRects()
		{
			return boundingRects;
		}

		// Methods
		@Override
		public String toString()
		{
			String res = "matchText=" + matchText + "\n";
			res += "foundIn=" + foundIn.toString() + "\n";
			res += "startPageNum=" + startPageNum + "\n";
			res += "lineContainingText=" + lineContainingText + "\n";
			res += "indexOfTextInLine=" + indexOfTextInLine + "\n";
			res += "boundingRects=\n";
			for (BoundingRect brect: boundingRects)
			{
				res += "\t" + brect.toString() + "\n";
			}
			return res;
		}
	}
	
	public class SearchTextResult
	{
		// Fields

		// Ctors
		SearchTextResult(CommonInt.RestAPISearchTextResult apiResponse)
		{
			text = apiResponse.text;
			hits = new ArrayList<SearchHit>();
			for (CommonInt.RestAPISearchHit hit: apiResponse.hits)
			{
				hits.add(new SearchHit(hit));
			}
		}

		// Properties
		private String text;
		public String getText()
		{
			return text;
		}
		
		private ArrayList<SearchHit> hits;
		public ArrayList<SearchHit> getHits()
		{
			return hits;
		}

		// Methods
		@Override
		public String toString()
		{
			String res = "text=" + text + "\n";
			for (SearchHit hit: hits)
			{
				res += "\t" + hit.toString() + "\n";
			}
			return res;
		}
	}

	// Fields

	// Ctors
	public SearchTextResponse(CommonInt.RestAPISearchTextResponse apiResponse) throws URISyntaxException
	{
		results = new ArrayList<SearchTextResult>();
		for (CommonInt.RestAPISearchTextResult result: apiResponse.results)
		{
			results.add(new SearchTextResult(result));
		}
	}

	// Properties
	private ArrayList<SearchTextResult> results;
	public final ArrayList<SearchTextResult> getResults()
	{
		return results;
	}

	// Methods
	@Override
	public String toString()
	{
		String res = "results=\n";
		for (SearchTextResult result: results)
		{
			res += "\t" + result.toString() + "\n";
		}
		return res;
	}
}