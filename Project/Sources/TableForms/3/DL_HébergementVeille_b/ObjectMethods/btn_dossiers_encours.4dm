// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/03/20, 08:09:05
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementChercher.btn_dossiers_encours
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Form event code:C388=Sur clic:K2:4)
	
	$vl_Fenetre:=Open form window:C675([DiaLogues:3]; "DL_Dossiers_Encours_Liste"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
	DIALOG:C40([DiaLogues:3]; "DL_Dossiers_Encours_Liste")
	CLOSE WINDOW:C154($vl_Fenetre)
	
End if 