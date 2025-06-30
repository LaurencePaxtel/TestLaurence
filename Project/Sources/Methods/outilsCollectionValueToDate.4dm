//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 28/09/22, 09:40:52
// ----------------------------------------------------
// Méthode : outilsCollectionValueToDate
// Description
// Permet avec la commande .map() d'une collection de
// convertir pour chaque valeur de celle-ci au format Text
//
// Paramètres
// ----------------------------------------------------
var $1 : Object
var $2 : Text

If (Count parameters:C259=2)
	$1.result:=New object:C1471
	$1.result[$2]:=!2000-01-01!
Else 
	$1.result:=Date:C102($1.value)
End if 