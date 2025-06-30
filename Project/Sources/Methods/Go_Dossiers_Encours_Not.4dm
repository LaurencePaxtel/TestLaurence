//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/03/20, 16:21:14
// ----------------------------------------------------
// Method: Go_Dossiers_Encours_Not
// Description
// 
//
// Parameters
// ----------------------------------------------------


$vl_Fenetre:=Open form window:C675([DiaLogues:3]; "DL_Dossiers_Encours_Not"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
DIALOG:C40([DiaLogues:3]; "DL_Dossiers_Encours_Not")
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_Dossiers_Encours_Liste:=0