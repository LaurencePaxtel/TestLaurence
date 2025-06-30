// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18/02/20, 18:17:08
// ----------------------------------------------------
// Method: [HeberGement].HG_EcranSaisie_B.btn_parametrage_reports
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $vl_Fenetre : Integer

$vl_Fenetre:=Open form window:C675([DiaLogues:3]; "DL_Reports_Config"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
DIALOG:C40([DiaLogues:3]; "DL_Reports_Config")

CLOSE WINDOW:C154($vl_Fenetre)