//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 08:12:56
// ----------------------------------------------------
// Method: Print_Init_Variables_Events
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(txt_piece_titre; txt_titre_ligne_1; txt_titre_ligne_2)

txt_piece_titre:="Liste des événements"

ORDER BY:C49([Events:103]; [Events:103]EVE_Date_Du:5; >)

$du:=String:C10([Events:103]EVE_Date_Du:5)

ORDER BY:C49([Events:103]; [Events:103]EVE_Date_Au:6; >)

$au:=String:C10([Events:103]EVE_Date_Au:6)

txt_titre_ligne_1:="Du "+String:C10($du)
txt_titre_ligne_2:="Au "+String:C10($au)
