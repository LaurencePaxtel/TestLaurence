//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 19:19:22
// ----------------------------------------------------
// Method: UTL_Genere_Ref_Impression
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $texte)

$texte:=" - "+String:C10(Current date:C33(*); Système date court:K1:1)+" - "+String:C10(Current time:C178(*); h mn:K7:2)

$0:=$texte