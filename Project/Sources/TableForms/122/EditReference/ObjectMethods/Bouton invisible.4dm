C_BOOLEAN:C305($stop_b)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Voulez-vous vraiment sauvegarder vos changements (cette opération est irréversible) ?"; "Oui"; "Non")
		
		If (OK=1)
			
			If (Form:C1466.refSelection.length=1)  // Une seule référence produit sélectionnée
				
				If (Form:C1466.refSelection[0].quantiteMax<Form:C1466.refSelection[0].quantite)
					ALERT:C41("Impossible de sauvegarder vos changements car la quantité restante ne peut être "+\
						"supérieure à la quantité maximale de la référence produit « "+Form:C1466.refSelection[0].reference+" »")
					
					$stop_b:=True:C214
				End if 
				
			Else 
				$collection_c:=Form:C1466.refSelection.query("quantite > :1"; Form:C1466.refSelection[0].quantiteMax)
				
				If ($collection_c.length>0)
					ALERT:C41("Impossible de sauvegarder vos changements car au moins une référence produit de votre sélection a une quantité restante "+\
						"supérieure à la quantité maximale « "+String:C10(Form:C1466.refSelection[0].quantiteMax)+" »")
					
					$stop_b:=True:C214
				End if 
				
			End if 
			
			If ($stop_b=False:C215)
				
				If (Form:C1466.refSelection.length=1)  // Une seule référence produit sélectionnée
					
					If (Form:C1466.oldReference#Form:C1466.refSelection[0].reference)  // On a changé la référence produit
						outilsStockGestion(0; Form:C1466.elementCourant.date; Form:C1466.elementCourant.date; Form:C1466)
						
						// Je change la propriete oldReference pour pouvoir retrouver la référence dans les cas qui suivent
						Form:C1466.oldReference:=Form:C1466.refSelection[0].reference
					End if 
					
				End if 
				
				If (Form:C1466.oldQuantiteMax#Form:C1466.refSelection[0].quantiteMax)  // On a diminué ou augmenté la quantité maximale dans le stock
					outilsStockGestion(1; Date:C102(Form:C1466.quantiteMaxDateDu); Date:C102(Form:C1466.quantiteMaxDateAu); Form:C1466)
				End if 
				
				If (Form:C1466.oldQuantite#Form:C1466.refSelection[0].quantite)  // On a diminué ou augmenté la quantité restante dans le stock
					outilsStockGestion(2; Date:C102(Form:C1466.quantiteDateDu); Date:C102(Form:C1466.quantiteDateAu); Form:C1466)
				End if 
				
				ACCEPT:C269
			End if 
			
		Else 
			CANCEL:C270
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 