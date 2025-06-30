//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/06/23, 17:42:07
// ----------------------------------------------------
// Méthode : outilsCheckStringIsNumber
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean
var $1 : Text

var $i_el : Integer

For ($i_el; 1; Length:C16($1))
	
	If ($1[[$i_el]]="0") | ($1[[$i_el]]="1") | ($1[[$i_el]]="2") | ($1[[$i_el]]="3") | ($1[[$i_el]]="4") | ($1[[$i_el]]="5") | ($1[[$i_el]]="6") | ($1[[$i_el]]="7") | ($1[[$i_el]]="8") | ($1[[$i_el]]="9")
		$0:=True:C214
	Else 
		$0:=False:C215
		$i_el:=Length:C16($1)
	End if 
	
End for 