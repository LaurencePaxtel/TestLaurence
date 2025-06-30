C_TEXT:C284($choix; $menu)
C_LONGINT:C283($colonne; $ligne)

Case of 
	: (Form event code:C388=Sur clic:K2:4) | (Form event code:C388=Sur double clic:K2:5)
		C_LONGINT:C283(fac_heberge_selected_id)
		
		LISTBOX GET CELL POSITION:C971(LB_Liste_reglements; $colonne; $ligne)
		
		READ WRITE:C146([Reglements:93])
		GOTO SELECTED RECORD:C245([Reglements:93]; $ligne)
		
		fac_heberge_selected_id:=[Reglements:93]REG_Origine_ID:18
		
		If (Contextual click:C713)
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "Modifier")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "modifier")
			
			$choix:=Dynamic pop up menu:C1006($menu)
			RELEASE MENU:C978($menu)
		Else 
			
			If (Form event code:C388=Sur double clic:K2:5)
				$choix:="modifier"
			End if 
			
		End if 
		
		Case of 
			: ($choix="modifier")
				LOAD RECORD:C52([Reglements:93])
				
				reg_is_new_record:=False:C215
				
				UTL_Open_Window(->[Factures:86]; "edit_reglement")
				REG_Get_Liste
		End case 
		
End case 