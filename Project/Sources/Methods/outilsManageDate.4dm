//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 13/04/23, 11:05:23
// ----------------------------------------------------
// Méthode : outilsManageDate
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Date
var $1 : Integer

Case of 
	: ($1=1)  // Premier de l'année en cours
		$0:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))
	: ($1=2)  // Dernier de l'année en cours
		$0:=Date:C102("31/12/"+String:C10(Year of:C25(Current date:C33)))
End case 