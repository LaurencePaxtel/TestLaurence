C_LONGINT:C283(colonne; ligne)


Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		LISTBOX GET CELL POSITION:C971(LB_Sous_Menus; colonne; ligne)
		
		READ WRITE:C146([NAV_Sous_Menus:78])
		GOTO SELECTED RECORD:C245([NAV_Sous_Menus:78]; ligne)
		LOAD RECORD:C52([NAV_Sous_Menus:78])
		
		MODIFY RECORD:C57([NAV_Sous_Menus:78])
		
		//If (ligne>0)
		//$vl_Fenetre:=Open form window([NAV_Parametrage];"Saisie_P";Modal form dialog box;On the left;At the top)
		//DIALOG([NAV_Parametrage];"Saisie_P")
		//CLOSE WINDOW($vl_Fenetre)
		//End if 
		
		READ ONLY:C145([NAV_Sous_Menus:78])
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
	: (Form event code:C388=Sur clic:K2:4)
		If (Contextual click:C713)
			LISTBOX GET CELL POSITION:C971(LB_NAV_Parametrage; colonne; ligne)
			If (ligne#0)
				$a:=Pop up menu:C542("Supprimer")
				If ($a=1)
					CONFIRM:C162("Voulez vous supprimer cet enregistrement"; "Oui"; "Non")
					If (ok=1)
						LISTBOX GET CELL POSITION:C971(LB_Sous_Menus; colonne; ligne)
						
						READ WRITE:C146([NAV_Sous_Menus:78])
						GOTO SELECTED RECORD:C245([NAV_Sous_Menus:78]; ligne)
						LOAD RECORD:C52([NAV_Sous_Menus:78])
						
						DELETE RECORD:C58([NAV_Sous_Menus:78])
						
						READ ONLY:C145([NAV_Sous_Menus:78])
						ALL RECORDS:C47([NAV_Sous_Menus:78])
						
					End if 
				End if 
			End if 
		End if 
		
	: (Form event code:C388=Sur chargement:K2:1)
		
End case 


