//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/03/22, 21:59:00
// ----------------------------------------------------
// Méthode : outilsObjectDeleteProperty
// Description
// Méthode qui permet de supprimer plusieurs propriétés d'un objet
//
// Paramètres
// ----------------------------------------------------
var $1 : Object
var ${2} : Text

var $i_el : Integer

For ($i_el; 2; Count parameters:C259)
	OB REMOVE:C1226($1; ${$i_el})
End for 