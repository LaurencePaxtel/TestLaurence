var $colonne_el; $ligne_el; $indice_el : Integer

LISTBOX GET CELL POSITION:C971(*; "List Box"; $colonne_el; $ligne_el)

If ($ligne_el>0)
	
	If (tb_centre_choix{$ligne_el}=True:C214)
		tb_centre_liste_montant{$ligne_el}:=Form:C1466.montant
		
		$line_c:=Form:C1466.lineInfo.indices("id = :1"; tb_centre_liste_id{$ligne_el})
		$indice_el:=$line_c[0]
		
		Form:C1466.lineInfo[$indice_el].montant:=tb_centre_liste_montant{$ligne_el}
	Else 
		ALERT:C41("Veuillez cocher la boite à cocher de la ligne avant de pouvoir modifier le montant")
	End if 
	
Else 
	ALERT:C41("Veuillez sélectionner une ligne")
End if 