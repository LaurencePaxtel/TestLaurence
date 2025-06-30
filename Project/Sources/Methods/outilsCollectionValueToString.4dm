//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 01/06/23, 18:20:16
// ----------------------------------------------------
// Méthode : outilsCollectionValueToString
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Object
var $2 : Text

If (Count parameters:C259=2)
	$1.value[$2]:=String:C10($1.value[$2])
	$1.result:=$1.value
Else 
	$1.result:=String:C10($1.value)
End if 