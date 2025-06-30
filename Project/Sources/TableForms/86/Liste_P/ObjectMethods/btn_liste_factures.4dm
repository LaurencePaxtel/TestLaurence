// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27/01/20, 17:47:20
// ----------------------------------------------------
// Method: [Factures].Liste_HB.btn_liste_factures
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_LONGINT:C283($ref_fenere)
		
		selected_form_no:=1
		txt_titre_fenetre:="Liste des factures"
		
		$ref_fenere:=AGL_WINDOW(1150; 600; 4; "factures_liste"; "AGL_CLOSE_WINDOW"; True:C214)
		
		DIALOG:C40([Factures:86]; "factures_liste"; New object:C1471("appel"; 2))
		CLOSE WINDOW:C154($ref_fenere)
End case 