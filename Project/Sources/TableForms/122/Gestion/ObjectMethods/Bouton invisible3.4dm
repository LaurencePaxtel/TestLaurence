C_TEXT:C284($position_t)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$position_t:="center"
		
		Case of 
			: (Form:C1466.refSelection=Null:C1517)
				ALERT:C41("Merci de sélectionner une structure, et ensuite sélectionner un produit dans la liste de gauche")
			: (Form:C1466.refSelection.length>=1)
				outilsCreateWindowsForm("EditReference"; ->$position_t; New object:C1471("refSelection"; Form:C1466.refSelection; "elementCourant"; Form:C1466.elementCourant); ->[StockBis:122])
				
				If (OK=1)  // Bouton sauvegarder et Confirmer
					Form:C1466.changeDate:=True:C214
					
					POST OUTSIDE CALL:C329(Current process:C322)
				Else 
					Form:C1466.elementCourant.reload()
				End if 
				
			Else 
				ALERT:C41("Merci de sélectionner au moins une référence produit")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 