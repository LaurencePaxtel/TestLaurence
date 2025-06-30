// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15/01/20, 08:09:32
// ----------------------------------------------------
// Method: [Factures].edit.LB_Liste_factures
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $choix_t; $menu_t : Text
var $colonne_el; $ligne_el : Integer

Case of 
	: (Form event code:C388=Sur clic:K2:4) | (Form event code:C388=Sur double clic:K2:5)
		var selected_row_number; id_selected_piece; fac_heberge_selected_id : Integer
		
		LISTBOX GET CELL POSITION:C971(LB_Liste_factures; $colonne_el; $ligne_el)
		
		If (tb_fac_type_piece{$ligne_el}#"Règlement")
			fac_heberge_selected_id:=tb_fac_destinataire_id{$ligne_el}
			selected_row_number:=$ligne_el
			
			Case of 
				: (Contextual click:C713)
					$menu_t:=Create menu:C408
					
					APPEND MENU ITEM:C411($menu_t; "Editer")
					SET MENU ITEM PARAMETER:C1004($menu_t; -1; "Visualiser")
					
					$choix_t:=Dynamic pop up menu:C1006($menu_t)
					RELEASE MENU:C978($menu_t)
				: (Form event code:C388=Sur double clic:K2:5)
					// Modifié par : Scanu Rémy (25/01/2022)
					tb_fac_choix{$ligne_el}:=True:C214
					$choix_t:="Visualiser"
			End case 
			
			Case of 
				: ($choix_t="Visualiser")
					
					If (fac_heberge_selected_id#0)
						READ WRITE:C146([Factures:86])
						
						QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$ligne_el})
						
						If (i_NonVerrou(->[Factures:86]))
							QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
							MultiSoc_Filter(->[Factures_Lignes:87])
							
							ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
							id_selected_piece:=[Factures:86]ID:1
							
							UTL_Open_Window(->[Factures:86]; "edit")
						End if 
						
					End if 
					
			End case 
			
		Else 
			READ WRITE:C146([Reglements:93])
			QUERY:C277([Reglements:93]; [Reglements:93]ID:1=tb_fac_id{$ligne_el})
			
			fac_heberge_selected_id:=[Reglements:93]REG_Origine_ID:18
			
			Case of 
				: (Contextual click:C713)
					$menu_t:=Create menu:C408
					
					APPEND MENU ITEM:C411($menu_t; "Modifier")
					SET MENU ITEM PARAMETER:C1004($menu_t; -1; "modifier")
					
					$choix_t:=Dynamic pop up menu:C1006($menu_t)
					RELEASE MENU:C978($menu_t)
				: (Form event code:C388=Sur double clic:K2:5)
					$choix_t:="modifier"
			End case 
			
			Case of 
				: ($choix_t="modifier")
					LOAD RECORD:C52([Reglements:93])
					reg_is_new_record:=False:C215
					
					UTL_Open_Window(->[Factures:86]; "edit_reglement")
			End case 
			
		End if 
		
		UNLOAD RECORD:C212([Factures:86])
		UNLOAD RECORD:C212([Reglements:93])
		
		If ($choix_t#"")
			// Modifié par : Scanu Rémy - remy@connect-io.fr (09/07/2021)
			FAC_Get_Liste_Factures
		End if 
		
End case 