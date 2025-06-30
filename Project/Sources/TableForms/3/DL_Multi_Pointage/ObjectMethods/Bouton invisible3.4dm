var $colonne_el; $ligne_el; $indice_el : Integer

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		LISTBOX GET CELL POSITION:C971(*; "List Box"; $colonne_el; $ligne_el)
		
		If ($ligne_el>0)
			
			If (tb_centre_choix{$ligne_el}=True:C214)
				tb_centre_liste_quantite{$ligne_el}:=tb_centre_liste_quantite{$ligne_el}-1
				
				If (tb_centre_liste_quantite{$ligne_el}<0)
					tb_centre_liste_quantite{$ligne_el}:=0
				End if 
				
				$line_c:=Form:C1466.lineInfo.indices("id = :1"; tb_centre_liste_id{$ligne_el})
				$indice_el:=$line_c[0]
				
				Form:C1466.lineInfo[$indice_el].quantite:=tb_centre_liste_quantite{$ligne_el}
			Else 
				ALERT:C41("Veuillez cocher la boite à cocher de la ligne avant de pouvoir modifier la quantité")
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ligne")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 