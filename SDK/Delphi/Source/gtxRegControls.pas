{
 Gnostice StarDocs v2
 Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 http://www.gnostice.com
}

unit gtxRegControls;

interface

uses
	System.Classes, gtxStarDocsSDK;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('StarDocs SDK', [TgtxStarDocsSDK]);

end;

end.
