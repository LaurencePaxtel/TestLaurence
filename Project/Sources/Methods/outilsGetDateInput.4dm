//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/09/22, 10:45:16
// ----------------------------------------------------
// Méthode : outilsGetDateInput
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Date

$0:=String:C10(Year of:C25($1))+"-"+String:C10(Month of:C24($1); "00")+"-"+String:C10(Day of:C23($1); "00")