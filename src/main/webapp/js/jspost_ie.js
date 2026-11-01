// This sample is based on the Greasmonkey script that was written by Avinash Atreya
// version 0.1.1 BETA!
// 11 Aug 2005
// Copyright (c) 2005, Avinash Atreya, Dan Theurer, Oliver Harte
// Released under the Creative Common License by Attribution
// http://creativecommons.org/about/licenses/



/*##########################################################################################

This version simply enables the POST method to be enacted by both Mozilla browsers AND IE 
through javascript.

There are NO changes to either the encoding function, or the dynamic creation of the XML string.

The only changes are replacement of the Mozilla DOM functionalty with conventional dynamic 
object creation functionalty using the document.write method understood by most browsers.

A trivial hack to be sure, but nevertheless enormously usefull to me.

This method is of use if you need to pass a variable to the XML. For instance, I can pass a 
zip code to the XML on the fly thusly : doSubmit(zipcode_1). 

Oliver Harte, Aug 2005


##########################################################################################*/

/*##########################################################################################

TAGS FOR PAGE TO CALL THE FUNCTION :

<html>
<head>
</head>
<body>
<SCRIPT LANGUAGE="JavaScript" SRC="jspost.js"></script>

<h2>Java script POST sample</h2>

<p>Clicking this Link executes a POST request (works in both IE and Mozilla)</p>

<A HREF="javascript:doSubmit();"> do the form </A>

</body>
</html>

##########################################################################################*/


//don't know if this is going to interfere with variables of other scripts. Hopefully shouldn't

window.targetUrl = 'http://api.maps.yahoo.com/Maps/V1/AnnotatedMaps';
window.namespace = 'yahoo:maps';
window.appId = 'YahooDemo';


//To POST the XML it must be encoded. This is done here. Therefore we can build a more readable XML string.
window.xmlEncode = function(text) 
{
	var entityMap  = {
		">" : "gt",
		"<" : "lt",
		"\"" : null,
		"&" : null
	};

	var retval = "";
	if(!text)
	{
		return "";
	}
	for(var i =0; i < text.length; i++)
	{
		var ch = text.charAt(i);
		if(entityMap[ch])
		{
			retval += "&"+entityMap[ch]+";";
		}
		else
		{
			retval += ch;
		}
	}
	return retval;
}



//constructs the xml and submits the feed.

function doSubmit()
{
	
	var xml = "";
	xml += "<rss version = '2.0'>\n";
	xml += "<channel xmlns:" + namespace +"= 'http://api.maps.yahoo.com/Maps/V1/AnnotatedMaps/'>\n";
		xml += "<title>Return to the Yahoo! Developer Network</title> <!-- Anchor to the link  -->\n";
	  xml += "<link>http://developer.yahoo.net/maps/</link><!-- Link back to craig's list -->\n";
		xml += "<description>Locations that you selected to view</description>\n";
		
		
	  xml += "<item>\n";                                                                           
		xml += "<title>" + xmlEncode("Indigo") + "</title>\n";                    
		xml += "<link>" + xmlEncode("http://www.indigorestaurant.com/") + "</link>\n";                       
		xml += "<description>" + xmlEncode("Indigo Restaurant") + "</description>\n";  
		xml += "<" + namespace +":Address>" + xmlEncode("687 McAllister Street") +             
			"</" +namespace + ":Address>\n";                                                           
		xml += "<" + namespace + ":CityState>" + xmlEncode("San Francisco, CA")+         
			"</" + namespace + ":CityState>\n";                                                                                                                     
		xml += "<" + namespace + ":Country>" + xmlEncode("us") +            
			"</" + namespace + ":Country>\n";                                                          
		xml += "</item>\n";      
	
		xml += "<item>\n";                                                                           
		xml += "<title>" + xmlEncode("Pacific Cafe") + "</title>\n";                    
		xml += "<link>" + xmlEncode("http://travel.yahoo.com/p-travelguide-2731595-pacific_cafe_san_francisco-i/") + "</link>\n";                       
		xml += "<description>" + xmlEncode("Pacific Cafe") + "</description>\n";  
		xml += "<" + namespace +":Address>" + xmlEncode("7000 Geary Blvd") +             
			"</" +namespace + ":Address>\n";                                                           
		xml += "<" + namespace + ":CityState>" + xmlEncode("San Francisco, CA")+         
			"</" + namespace + ":CityState>\n";                                                                                                                     
		xml += "<" + namespace + ":Country>" + xmlEncode("us") +            
			"</" + namespace + ":Country>\n";                                                          
		xml += "</item>\n";                                                                          
		  
	  xml += "<item>\n";                                                                           
		xml += "<title>" + xmlEncode("Sutro's at the Cliff House") + "</title>\n";                    
		xml += "<link>" + xmlEncode("http://www.cliffhouse.com/info/dining.htm#SUTRO/") + "</link>\n";                       
		xml += "<description>" + xmlEncode("Sutro's at the Cliff House") + "</description>\n";  
		xml += "<" + namespace +":Address>" + xmlEncode("1090 Point Lobos") +             
			"</" +namespace + ":Address>\n";                                                           
		xml += "<" + namespace + ":CityState>" + xmlEncode("San Francisco, CA")+         
			"</" + namespace + ":CityState>\n";                                                                                                                     
		xml += "<" + namespace + ":Country>" + xmlEncode("us") +            
			"</" + namespace + ":Country>\n";                                                          
		xml += "</item>\n";  
		
	xml += "</channel>\n";
	xml += "</rss>";
	

	document.YahooMapsRequestForm.xmlsrc.value = xml;
	document.YahooMapsRequestForm.submit();

}


var D = document;

D.write('<form name="YahooMapsRequestForm" method="post" action="http://api.maps.yahoo.com/Maps/V1/annotatedMaps">');
D.write('<input name="appid" id="appid" type="hidden" value="YahooDemo">');
D.write('<input name="xmlsrc" id="xmlsrc" type="hidden" value="">');
D.write('</form>');


/*##########################################################################################*/