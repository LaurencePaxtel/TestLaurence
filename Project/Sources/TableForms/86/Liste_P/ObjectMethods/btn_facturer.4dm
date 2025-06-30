// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/01/20, 17:43:54
// ----------------------------------------------------
// Method: [Factures].Liste_HB.btn_facturer
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (FAC_PAR_Generer)
			selected_form_no:=1
			txt_titre_fenetre:="Liste des factures"
			
			txt_filtre_date1:=Current date:C33(*)
			txt_filtre_date2:=Current date:C33(*)
			
			$ref_fenere:=AGL_WINDOW(900; 500; 4; "factures_liste"; "AGL_CLOSE_WINDOW"; True:C214)
			DIALOG:C40([Factures:86]; "factures_liste"; New object:C1471("appel"; 2))
			CLOSE WINDOW:C154($ref_fenere)
			
			Chk_tous:=False:C215
			Chk_facture:=True:C214
			Chk_non_facture:=False:C215
			
			FAC_P_Get_Records
		End if 
		
End case 