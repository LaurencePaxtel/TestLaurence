//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 04/11/18, 08:37:22
// ----------------------------------------------------
// Méthode : UTL_Get_Date_Naissance
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($age; $0)
C_DATE:C307($1; $aujourdhui; $origine)

$aujourdhui:=Current date:C33(*)
$origine:=$1

$age:=Year of:C25($aujourdhui)-Year of:C25($origine)

If (Add to date:C393($origine; $age; 0; 0)>$aujourdhui)
	$age:=$age-1
End if 

$0:=$age