//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:58:05
// ----------------------------------------------------
// Méthode : WEB_UTL_getVal
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1)

$k:=Find in array:C230(w_variables; $1)
If ($k#-1)
	$0:=w_valeurs{$k}
Else 
	$0:=""
End if 