---
source: Rest_api_with_delphi
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_delphi
source_version: 1
source_updated_on: '2011-10-26T20:24:04Z'
---

# Using the REST API with Delphi

Here are two simple procedures that demonstrates how to use the Redmine REST API with Delphi. This example uses [ICS component THttpCli](http://www.overbyte.be/frame_index.html?redirTo=/products/ics.html):

```delphi
//Creating an Issue
procedure AddIssue;
var
  xmlStream     : TMemoryStream;
  tempArray     : array[0..10000] of char;
  xmlIssue      : String;
  apiAccessKey  : String;
  HttpClient    : THttpCli;
begin
  apiAccessKey := 'a1234567abcde12121a11a123456a12a12ab123ab'; ///Api user key example
  xmlStream := TMemoryStream.Create; //Create the XML stream

  //Create and set the Http Client component
  HttpClient := THttpCli.Create(nil);
  HttpClient.ContentTypePost := 'text/xml';
  HttpClient.URL:= 'http://localhost:3000/issues.xml?key='+apiAccessKey;
  try
    xmlIssue :=
        '<?xml version="1.0"?>' +
        '<issue>' +
        '  <project_id>1</project_id>'+
        '  <tracker_id>1</tracker_id>'+
        '  <status_id>1</status_id>'+
        '  <priority_id>1</priority_id>'+
        '  <author_id>1</author_id>'+
        '  <start_date>2011-10-09</start_date>'+
        '  <subject>Created in DELPHI</subject>'+
        '  <description>Issue created in DELPHI using Redmine REST API</description>'+
        '  <custom_fields type="array">' + // adding custom fields
        '       <custom_field id="1">'+
        '           <value>12121212</value>'+
        '       </custom_field>'+
        '       <custom_field id="2">'+
        '           <value>2010-10-09</value>'+
        '       </custom_field>'+
        '  </custom_fields>'+
        '</issue>';

    // Fill the stream with the xmlIssue
    FillChar( temparray, SizeOf( temparray ), #0 );
    strpcopy( temparray, xmlIssue );
    xmlStream.Write( temparray, length(xmlIssue) );
    xmlStream.Seek( 0, soFromBeginning);

    // set the xml stream and post
    HttpClient.SendStream:=xmlStream;
    try
      HttpClient.Post;
    except
      raise;
    end;
  finally
    xmlStream.Free;
    HttpClient.Free;
  end;
end;

//Listing Issue
procedure GetIssue(issueId: String);
var
  apiAccessKey: String;
  HttpClient: THttpCli;
  xmlIssue: TXMLDocument;
begin
    Memo.Lines.Clear; //using TMemo to show the result
    apiAccessKey := 'a1234567abcde12121a11a123456a12a12ab123ab'; //Api user key example

    xmlIssue := TXMLDocument.Create(Self); //Creating XML document. Self = TForm

    //Create and set the Http Client component
    HttpClient := THttpCli.Create(nil);
    HttpClient.ContentTypePost := 'text/xml';
    HttpClient.URL:= 'http://localhost:3000/issues/'+issueId+'.xml?key='+apiAccessKey;

    HttpClient.RcvdStream := TStringStream.Create(''); //Create the Stream
    try
      try
        //Get the Issue and show some properties in TMemo
        HttpClient.Get;
        xmlIssue.LoadFromStream(HttpClient.RcvdStream);
        xmlIssue.Active := True;

        Memo.Lines.Add('Id = ' + xmlIssue.DocumentElement.ChildNodes['id'].NodeValue);
        Memo.Lines.Add('Project id = ' + xmlIssue.DocumentElement.ChildNodes['project'].AttributeNodes['id'].NodeValue);
        Memo.Lines.Add('Project Name = ' + xmlIssue.DocumentElement.ChildNodes['project'].AttributeNodes['name'].NodeValue);
        Memo.Lines.Add('Tracker id = ' + xmlIssue.DocumentElement.ChildNodes['tracker'].AttributeNodes['id'].NodeValue);
        Memo.Lines.Add('Tracker name = ' + xmlIssue.DocumentElement.ChildNodes['tracker'].AttributeNodes['name'].NodeValue);
      Except
        raise;
      end;
    finally
      HttpClient.Free;
      xmlIssue.Free;
    end;
end;
```

</code>
