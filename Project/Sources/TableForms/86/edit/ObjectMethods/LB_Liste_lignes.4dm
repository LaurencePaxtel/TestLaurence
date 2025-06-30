// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/01/20, 16:47:11
// ----------------------------------------------------
// Method: [Factures].edit.LB_Liste_lignes
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($choix; $menu)
C_LONGINT:C283($colonne; $ligne)

Case of 
	: (Form event code:C388=Sur clic:K2:4) | (Form event code:C388=Sur double clic:K2:5)
		LISTBOX GET CELL POSITION:C971(LB_Liste_lignes; $colonne; $ligne)
		
		If (Contextual click:C713)
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "Nouvelle ligne")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "Ajouter")
			
			If ($ligne>0)
				APPEND MENU ITEM:C411($menu; "(-")
				
				APPEND MENU ITEM:C411($menu; "Editer")
				SET MENU ITEM PARAMETER:C1004($menu; -1; "Visualiser")
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (29/10/2021)
				APPEND MENU ITEM:C411($menu; "(-")
				
				APPEND MENU ITEM:C411($menu; "Supprimer")
				SET MENU ITEM PARAMETER:C1004($menu; -1; "Supprimer")
			End if 
			
			$choix:=Dynamic pop up menu:C1006($menu)
			RELEASE MENU:C978($menu)
		Else 
			
			If (Form event code:C388=Sur double clic:K2:5)
				
				If (Read only state:C362([Factures_Lignes:87]))
					READ WRITE:C146([Factures_Lignes:87])
				End if 
				
				GOTO SELECTED RECORD:C245([Factures_Lignes:87]; $ligne)
				
				If ([Factures_Lignes:87]ID:1#0)
					$choix:="Visualiser"
				Else 
					$choix:="Ajouter"
				End if 
				
			End if 
			
		End if 
		
		Case of 
			: ($choix="Ajouter")
				
				If (Not:C34([Factures:86]FAC_Cloture:10))
					CREATE RECORD:C68([Factures_Lignes:87])
					MultiSoc_Init_Structure(->[Factures_Lignes:87])
					
					[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
					[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
					[Factures_Lignes:87]FACL_Service_ID:4:=1
					[Factures_Lignes:87]FACL_Service_Ids:30:=""
					[Factures_Lignes:87]FACL_No_Ordre:7:=Records in selection:C76([Factures_Lignes:87])+1
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (29/10/2021)
					UTL_Open_Window(->[Factures_Lignes:87]; "edit")
					
					QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
					MultiSoc_Filter(->[Factures_Lignes:87])
					
					ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (29/10/2021)
					Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
					REDRAW:C174(LB_Liste_lignes)
				End if 
				
			: ($choix="Visualiser")
				
				If (Read only state:C362([Factures_Lignes:87]))
					READ WRITE:C146([Factures_Lignes:87])
				End if 
				
				GOTO SELECTED RECORD:C245([Factures_Lignes:87]; $ligne)
				
				UTL_Open_Window(->[Factures_Lignes:87]; "edit")
				
				
				REDRAW:C174(LB_Liste_lignes)
			: ($choix="Supprimer")
				// Modifié par : Scanu Rémy - remy@connect-io.fr (29/10/2021)
				If (Read only state:C362([Factures_Lignes:87]))
					READ WRITE:C146([Factures_Lignes:87])
				End if 
				
				GOTO SELECTED RECORD:C245([Factures_Lignes:87]; $ligne)
				
				DELETE RECORD:C58([Factures_Lignes:87])
				
				Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
				REDRAW:C174(LB_Liste_lignes)
		End case 
		
End case 