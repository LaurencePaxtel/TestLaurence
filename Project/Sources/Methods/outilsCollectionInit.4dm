//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/03/22, 21:53:53
// ----------------------------------------------------
// Méthode : outilsCollectionInit
// Description
// Méthode qui permet d'initialiser une collection pour les variables en param
//
// Paramètres
// ----------------------------------------------------
var ${1} : Pointer

var $i_el : Integer

For ($i_el; 1; Count parameters:C259)
	${$i_el}->:=New collection:C1472
End for 