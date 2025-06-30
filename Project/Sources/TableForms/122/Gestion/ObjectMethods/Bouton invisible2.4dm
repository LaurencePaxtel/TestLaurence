C_TEXT:C284($position_t; $id_t)
C_OBJECT:C1216($table_o)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$table_o:=ds:C1482.StockBis.newSelection()
		$position_t:="center"
		
		Case of 
			: (Form:C1466.refSelection=Null:C1517)
				ALERT:C41("Merci de sélectionner une structure, et ensuite sélectionner un produit dans la liste de gauche")
			: (Form:C1466.elementCourant=Null:C1517)
				ALERT:C41("Merci de sélectionner un produit dans la liste de gauche")
			Else 
				outilsStockGestion(3; ->$id_t; Form:C1466)
				outilsCreateWindowsForm("EditReference"; ->$position_t; New object:C1471("refSelection"; Form:C1466.refSelection; "elementCourant"; Form:C1466.elementCourant); ->[StockBis:122])
				
				If (OK=1)  // Bouton sauvegarder et Confirmer
					Form:C1466.changeDate:=True:C214
					
					POST OUTSIDE CALL:C329(Current process:C322)
				Else 
					// toDo supprimer référence produit non sauvegardé par l'utilisateur
					Form:C1466.elementCourant.reload()
				End if 
				
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 