// JavaScript Document
var xmlhttp;
function GetXmlHttpObject()
{
	if (window.XMLHttpRequest)
	{ // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
		return xmlhttp;
	}
	else
	{ // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		return xmlhttp;
	}
	return null;
}
function loadXMLDoc(url)
{
	xmlhttp = GetXmlHttpObject();
	if (xmlhttp==null)
	{
		alert ("Your browser does not support XMLHTTP!");
		return;
	}
	xmlhttp.onreadystatechange = state_ChangeTxt
	xmlhttp.open("GET",url,true);
	xmlhttp.send(null);
}
function state_ChangeTxt()
{
	if(xmlhttp.readyState == 4)
	{
		document.getElementById('test').innerHTML=xmlhttp.responseText;
	}
}
function state_ChangeXml()
{
	if(xmlhttp.readyState == 4)
	{
		var xml = req.responseXML;
	    var isNotFinished = xml.getElementsByTagName("finished")[0];
	    var myBytesRead = xml.getElementsByTagName("bytes_read")[0];
	    var myContentLength = xml.getElementsByTagName("content_length")[0];
	    var myPercent = xml.getElementsByTagName("percent_complete")[0];
	    if ((isNotFinished == null) && (myPercent == null)){
    	    document.getElementById("initializing").style.
        	visibility = "visible";
	        window.setTimeout("ajaxFunction();", 100);
    	} else {
        	document.getElementById("initializing").style.
	        visibility = "hidden";
    	    document.getElementById("progressBarTable").style.
        	visibility = "visible";
	        document.getElementById("percentCompleteTable").style.
    	    visibility = "visible";
        	document.getElementById("bytesRead").style.
	        visibility = "visible";

	        myBytesRead = myBytesRead.firstChild.data;
    	    myContentLength = myContentLength.firstChild.data;

        	if (myPercent != null) {
	          myPercent = myPercent.firstChild.data;
       	      document.getElementById("progressBar").style.width = myPercent + "%";
	          document.getElementById("bytesRead").innerHTML = myBytesRead + " of " + 
	            myContentLength + " bytes read";
    	      document.getElementById("percentComplete").innerHTML = myPercent + "100%";
	          window.setTimeout("ajaxFunction();", 100);
    	    } else {
        	document.getElementById("bytesRead").style.visibility = "hidden";
	        document.getElementById("progressBar").style.width = "100%";
	        document.getElementById("percentComplete").innerHTML = "File Uploading Done!";
	        document.getElementById("txtFile").value="";
	        }
    	}
	}
}
function showHint(str)
{
	if (str.length==0)
	{
		document.getElementById('txtHint').innerHTML="";
		return;
	}
	xmlhttp = GetXmlHttpObject();
	if (xmlhttp==null)
	{
		alert ("Your browser does not support XMLHTTP!");
		return;
	}
	var url = "test2.jsp";
	url = url+"?q="+str;
	url = url+"&sid="+Math.random();
	xmlhttp.onreadystatechange=state_ChangeTxt;
	xmlhttp.open("GET",url,true);
	xmlhttp.send(null);
}