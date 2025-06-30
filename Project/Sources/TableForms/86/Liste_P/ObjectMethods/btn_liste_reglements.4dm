// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27/01/20, 17:47:50
// ----------------------------------------------------
// Method: [Factures].Liste_HB.btn_liste_reglements
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($position_t)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		selected_form_no:=3
		txt_titre_fenetre:="Liste des règlements"
		
		// Modifié par : Scanu Rémy (23/02/2022)
		$position_t:="center"
		outilsCreateWindowsForm("reglements_liste"; ->$position_t; New object:C1471("dateDu"; txt_filtre_date1; "dateAu"; txt_filtre_date2); ->[Factures:86])
End case 