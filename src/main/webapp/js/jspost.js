// This sample is based on the Greasmonkey script that was written by Avinash Atreya
// version 0.1 BETA!
// 15 July 2005
// Copyright (c) 2005, Avinash Atreya, Dan Theurer
// Released under the Creative Common License by Attribution
// http://creativecommons.org/about/licenses/

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
window.doSubmit = function()

//function doSubmit()
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
	
	var forms = document.getElementsByName('YahooMapsRequestForm');
	var form = forms[0];
	form.xmlsrc.value = xml;
	form.submit();
}

window.createForms = function ()
{
	//This appends the form after the last paragraph
	var allParas = document.getElementsByTagName('p');
	var thisPara = allParas[(allParas.length -1)];

	//append the form at the end.
	var lastPara = thisPara;
	var form = document.createElement('form');
	lastPara.parentNode.insertBefore(form,lastPara.nextSibling);
	form.setAttribute('name','YahooMapsRequestForm');
	form.setAttribute('action',targetUrl);
	form.setAttribute('onSubmit','doSubmit()');
	form.setAttribute('method','POST');
	
	var appid = document.createElement('input');
	form.appendChild(appid);
	appid.setAttribute('type','hidden');
	appid.setAttribute('id','appid');
	appid.setAttribute('name','appid');
	appid.setAttribute('value',appid);
	
	var xml = document.createElement('input');
	form.appendChild(xml);
	xml.setAttribute('type','hidden');
	xml.setAttribute('id','xmlsrc');
	xml.setAttribute('name','xmlsrc');
	xml.setAttribute('value','');
	
	var submit = document.createElement('input');
	submit.setAttribute('type','submit');
	submit.setAttribute('value','View on Y! Maps');
	form.appendChild(submit);
}