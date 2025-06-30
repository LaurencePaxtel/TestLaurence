//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/07/2020, 11:56:56
// ----------------------------------------------------
// Method: NAV_Financeurs
// Description
// 
//
// Parameters
// ----------------------------------------------------

$vl_Fenetre:=Open form window:C675([Financeurs:117]; "Liste"; Form fenêtre standard:K39:10; À gauche:K39:2; En haut:K39:5)
DIALOG:C40([Financeurs:117]; "Liste")
CLOSE WINDOW:C154($vl_Fenetre)