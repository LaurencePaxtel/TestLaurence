//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/03/22, 21:46:11
// ----------------------------------------------------
// Méthode : outilsMoveObject
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Collection

var $element_t : Text

Case of 
	: ($1=0)  // Faire disparaître les objets
		
		For each ($element_t; $2)
			OBJECT SET COORDINATES:C1248(*; $element_t; -9999; -9999)
		End for each 
		
End case 