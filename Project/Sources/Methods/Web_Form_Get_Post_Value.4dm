//%attributes = {}
// ----------------------------------------------------
// User name (OS): Scanu Rémy
// Date and time: 22/12/20, 15:47:10
// ----------------------------------------------------
// Method: Web_Form_Get_Post_Value
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($pos_el)

ARRAY TEXT:C222($propriete_at; 0)
ARRAY TEXT:C222($valeurs_at; 0)

WEB GET VARIABLES:C683($propriete_at; $valeurs_at)

$pos_el:=Find in array:C230($propriete_at; $1)

If ($pos_el>0)
	$0:=$valeurs_at{$pos_el}
End if 