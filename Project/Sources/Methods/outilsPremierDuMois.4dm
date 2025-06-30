//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/09/21, 16:24:09
// ----------------------------------------------------
// Méthode : outilsPremierDuMois
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_DATE:C307($0)
C_DATE:C307($1)

$0:=Date:C102("01/"+String:C10(Month of:C24($1))+"/"+String:C10(Year of:C25($1)))