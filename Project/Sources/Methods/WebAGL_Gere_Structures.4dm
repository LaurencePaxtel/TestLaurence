//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/10/18, 22:18:04
// ----------------------------------------------------
// Méthode : WebAGL_Gere_Structures
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($uid_user; $pos)
C_TEXT:C284(HTML_LISTE_STRUCTURES)

ARRAY TEXT:C222($temp; 0)

$uid_user:=$1
HTML_LISTE_STRUCTURES:=""

READ ONLY:C145([Structures:79])
READ ONLY:C145([Structure_User:80])

REDUCE SELECTION:C351([Structures:79]; 0)
REDUCE SELECTION:C351([Structure_User:80]; 0)

QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=$uid_user)

SELECTION TO ARRAY:C260([Structure_User:80]UID_Structure:1; $temp)
QUERY WITH ARRAY:C644([Structures:79]UID:1; $temp)

$pos:=Position:C15("&strc"; w_parametres; 0)

If ($pos>0)
	$w_parametres:=Substring:C12(w_parametres; 0; $pos-1)
Else 
	$w_parametres:=w_parametres
End if 

If (Records in selection:C76([Structures:79])>1)
	HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"<li class=\"dropdown-submenu dropdown-menu-left\">"
	HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"<a tabindex=\"-1\" href=\"#\">Structures</a>"
	HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"<ul class=\"dropdown-menu\">"
	
	FIRST RECORD:C50([Structures:79])
	
	For ($s; 1; Records in selection:C76([Structures:79]))
		HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"<li><a tabindex=\"-1\" href=\""+w_action+"?"+$w_parametres+"&strc="+[Structures:79]UID:1+" \">"+[Structures:79]STRC_Nom:4+"</a></li>"
		NEXT RECORD:C51([Structures:79])
	End for 
	
	HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"</ul>"
	HTML_LISTE_STRUCTURES:=HTML_LISTE_STRUCTURES+"</li>"
End if 

// $strc:=WEB_UTL_GET_PARAMS("strc")
// WebAGL_Structure_Init($uid_user; $strc)