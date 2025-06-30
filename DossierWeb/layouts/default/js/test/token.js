


// JavaScript Document
function SetCookie (name, value, expire)
{
	var argv=SetCookie.arguments;
	var argc=SetCookie.arguments.length;
	var expires=(argc > 2) ? argv[2] : null;
	var path=(argc > 3) ? argv[3] : null;
	var domain=(argc > 4) ? argv[4] : null;
	var secure=(argc > 5) ? argv[5] : false;
	document.cookie=name+"="+escape(value)+
		((expires==null) ? "" : ("; expires="+expires.toGMTString()))+
		((path==null) ? "" : ("; path="+path))+
		((domain==null) ? "" : ("; domain="+domain))+
		((secure==true) ? "; secure" : "");
}

var pathname=location.pathname;
var myDomain=pathname.substring(0,pathname.lastIndexOf('/')) +'/';
//var date_exp = new Date();
//date_exp.setTime(date_exp.getTime()+(1*24*3600*1000));  // une durée de vie de 1 jour
//date_exp.setTime(date_exp.getTime()+(3600*1000));	// une durée de vie de 60 min
//date_exp.setTime(date_exp.getTime()+(1));	
var date_exp = null;
function CreateHist(val)
{
var ValParams=val; 
//alert("stockage "+ValParams);
SetCookie("CookieHist",ValParams,date_exp);
SetCookie("paxhost",location.host,date_exp);
}

if(location.pathname.substr(1) == 'SOC' && get('uid') !=='') {
	SetCookie("paxSoc",get('uid'),date_exp);
}

function getCookieVal(offset) {
	var endstr=document.cookie.indexOf (";", offset);
	if (endstr==-1)
  endstr=document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}

function GetCookie (name) {
	var arg=name+"=";
	var alen=arg.length;
	var clen=document.cookie.length;
	var i=0;
	while (i<clen) 
  {
	 var j=i+alen;
	 if (document.cookie.substring(i,j)==arg)
		
   return getCookieVal (j);
   i=document.cookie.indexOf(" ",i)+1;
   if (i==0) break;
  }
	return null;
}

function readHist(){
var nosVariables=GetCookie("CookieHist");
return nosVariables;
}

function rechargeParams(){
var valCookies=readHist();
if((null==valCookies)||(valCookies=="Denied")){
//alert("SESSION EXPIRÉE ou INVALIDE: Merci de vous identifier !!");
//jAlert('SESSION EXPIRÉE: Merci de vous identifier !!', 'Avertissement');
window.location.replace("login"); 
}
else{
//document.tok..value =valCookies;
//alert(valCookies);
document.tok.VToken.value=valCookies;
//setTimeout("rechargeParams()",20200);
//alert(document.tok.VToken.value);
setTimeout("rechargeParams()",1204000);
}    
}






function CreateHist2(val)
{
var ValParams2=val; 
SetCookie("CookieHist2",ValParams2,date_exp);
}

function readHist2(){ 
var nosVariables2=GetCookie("CookieHist2");
return nosVariables2;
}


function rechargeParams2(){
var valCookies2=readHist2();
if(null==valCookies2){
//alert("SESSION EXPIRÉE: Merci de vous identifier !!");
window.location.replace("login"); 
}
else{
//alert(valCookies2);
//document.forms['tok'].elements['uid'].value
document.tok.uid.value =valCookies2;
//alert(document.tok.uid.value);
}    
}





function EffaceCookie(nom)
{
date=new Date;
date.setFullYear(date.getFullYear()-1);
SetCookie(nom,null,date);
}


$(function() {
	RecupToken();
	$("#disconnect").click(function(){
		EffaceCookie("CookieHist");
		EffaceCookie('CookieHist2');
	});
});

function RecupToken()
	{
		var token=$("#Token").val();
		var infoToken=[];
		infoToken=token.split("*");
		var valToken=[];
		var valUid=[];
		valToken=infoToken[0].split(":");
		valUid=infoToken[1].split(":");
		var to= valToken[1]; 
		var ud= valUid[1];
		//alert("token:"+to);
		//alert("userUID:"+ud);
		CreateHist(to);
		CreateHist2(ud);                                                  	   
	}
