//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/03/20, 09:13:36
// ----------------------------------------------------
// Method: Go_Dossiers_Encours
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283(DOS_HB_ReferenceID)

DOS_HB_ReferenceID:=$1

$vl_Fenetre:=Open form window:C675([DiaLogues:3]; "DL_Dossiers_Encours"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
DIALOG:C40([DiaLogues:3]; "DL_Dossiers_Encours")

CLOSE WINDOW:C154($vl_Fenetre)
<>PR_Dossiers_Encours:=0