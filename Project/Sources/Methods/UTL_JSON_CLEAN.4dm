//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/05/27, 17:06:51
// ----------------------------------------------------
// Method: UTL_JSON_CLEAN
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $texte)

$texte:=$1

If ((Type:C295($texte->)=Est un texte:K8:3) | (Type:C295($texte->)=Est un champ alpha:K8:1))
	$texte->:=Replace string:C233($texte->; "\""; "")
End if 