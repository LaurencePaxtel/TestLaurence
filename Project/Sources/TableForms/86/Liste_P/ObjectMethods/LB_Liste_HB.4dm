// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/01/20, 16:46:35
// ----------------------------------------------------
// Method: [Factures].Liste_HB.LB_Liste_HB
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($colonne; $ligne; fac_heberge_selected_id)
		
		LISTBOX GET CELL POSITION:C971(LB_Liste_HB; $colonne; $ligne)
		
		fac_heberge_selected_id:=tb_liste_hb_ref_id{$ligne}
		
		
End case 