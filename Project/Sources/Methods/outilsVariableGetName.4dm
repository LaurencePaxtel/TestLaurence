//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 05/07/24, 15:50:03
// ----------------------------------------------------
// Méthode : outilsVariableGetName
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Text

var $i_el : Integer

$0:=Char:C90(Apostrophe:K15:44)

For ($i_el; 1; Length:C16($1))
	$0+=$1[[$i_el]]
End for 

$0+=Char:C90(Apostrophe:K15:44)