//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 14/03/23, 17:51:13
// ----------------------------------------------------
// Méthode : outilsWebManagePopup
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Integer

var $html_t : Text

Case of 
	: ($1=1)  // Ajout d'un popup 4WP
		$html_t:="<div id=\"4DWriteDiv\" style=\"width: 100%; text-align: center;\">"
		$html_t:=$html_t+"<iframe id=\"4DWriteIframe\" height=\"700\" src=\"\" style=\"\">"
		$html_t:=$html_t+"</iframe>"
		$html_t:=$html_t+"</div>"
End case 

$0:=$html_t