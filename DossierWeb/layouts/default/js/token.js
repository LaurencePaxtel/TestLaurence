	$(function() {
		RecupToken();
		$("#disconnect").click(function(){
			EffaceCookie("CookieHist");
			EffaceCookie('CookieHist2');
		});
	});

	
	var pathname=location.pathname;
	var myDomain=pathname.substring(0,pathname.lastIndexOf('/')) +'/';
	var date_exp = new Date();
	//date_exp.setTime(date_exp.getTime()+(1*24*3600*1000));  // une durée de vie de 1 jour
	//date_exp.setTime(date_exp.getTime()+(3600*1000));	// une durée de vie de 60 min
	//date_exp.setTime(date_exp.getTime()+(1));	
	date_exp.setTime(date_exp.getTime()+(120*60*1000));	// 20 minutes


	function get(choix) {
			var url = location.search;
			key_vals = url.split('&');
			for(var index in key_vals) {
				key_val = key_vals[index].split('=');
				var key = key_val[0];
				var val = key_val[1];
				if(choix == key) {
					return val;
				}
			}
			return false;
		}  
		
		
	

	function RecupToken() {
		/*var token=$("#Token").val();
		var infoToken=[];
		infoToken=token.split("*");  //token:                  userUUID:2013070519060300001LOCPYD             userName:Maan
		var valToken=[];
		var valUid=[];
		valToken=infoToken[0].split(":");
		valUid=infoToken[1].split(":");
		var to= valToken[1]; 
		var ud= valUid[1];
		
		CreateHist(to);
		CreateHist2(ud);    
		rechargeParams();*/		
	}

	function CreateHist(val) {
		var ValParams=val; 
		console.log(ValParams);
		console.log(date_exp);
		SetCookie("CookieHist",ValParams,date_exp);
		SetCookie("paxhost",location.host,date_exp);
	}
	
	// Too see 
if(location.pathname.substr(1) == 'SOC' && get('uid') !=='') {
	SetCookie("paxSoc",get('uid'),date_exp);
}
	function CreateHist2(val) {
		var ValParams2=val; 
		SetCookie("CookieHist2",ValParams2,date_exp);
	}
		function SetCookie (name, value, expire) {
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

	function rechargeParams(){
		var valCookies=readHist();
		if((null==valCookies)||(valCookies=="Denied")){
			EffaceCookie("CookieHist");
			EffaceCookie('CookieHist2');
			window.location.replace("deconnexion"); 
		}
		else{
			setTimeout("rechargeParams()",(120*1000*20)); 	// 20 minutes
		}    
	}

		function EffaceCookie(nom) {
			date=new Date;
			date.setFullYear(date.getFullYear()-1);
			SetCookie(nom,null,date);
		}

		function readHist(){
			var nosVariables=GetCookie("CookieHist");
			return nosVariables;
		}
		
		// To see
		function readHist2(){ 
			var nosVariables2=GetCookie("CookieHist2");
			return nosVariables2;
		}

			function GetCookie (name) {
				var arg=name+"=";
				var alen=arg.length;
				var clen=document.cookie.length;
				var i=0;
				while (i<clen) {
					var j=i+alen;
					if (document.cookie.substring(i,j)==arg)

					return getCookieVal (j);
					i=document.cookie.indexOf(" ",i)+1;
					if (i==0) break;
				}
				return null;
			}
			
			
				function getCookieVal(offset) {
					var endstr=document.cookie.indexOf (";", offset);
					if (endstr==-1)
					endstr=document.cookie.length;
					return unescape(document.cookie.substring(offset, endstr));
				}