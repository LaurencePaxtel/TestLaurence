C_LONGINT:C283($quantite_el; $quantiteMax_el; $i_el)
C_COLLECTION:C1488($collection_c; $autreCollection_c)

$collection_c:=New collection:C1472
$autreCollection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Case of 
			: (Form:C1466.refSelection=Null:C1517)
				ALERT:C41("Merci de sélectionner une structure, et ensuite sélectionner un produit dans la liste de gauche")
			: (Form:C1466.refSelection.length>1) | (Form:C1466.refSelection.length=1)
				CONFIRM:C162("Êtes-vous certain de vouloir supprimer les éléments sélectionnés ?"; "Oui"; "Non")
				
				If (OK=1)
					$quantite_el:=Form:C1466.refSelection.sum("quantite")
					$quantiteMax_el:=Form:C1466.refSelection.sum("quantiteMax")
					
					$collection_c:=Form:C1466.elementCourant.configuration.detail
					
					For ($i_el; 1; Form:C1466.refSelection.length)
						$autreCollection_c:=$collection_c.indices("id = :1"; Form:C1466.refSelection[$i_el-1].id)
						$collection_c.remove($autreCollection_c[0])
					End for 
					
					Form:C1466.elementCourant.quantite:=Form:C1466.elementCourant.quantite-$quantite_el
					Form:C1466.elementCourant.quantiteMax:=Form:C1466.elementCourant.quantiteMax-$quantiteMax_el
					Form:C1466.elementCourant.save()
					
					Form:C1466.changeDate:=True:C214
					POST OUTSIDE CALL:C329(Current process:C322)
				End if 
				
			Else 
				ALERT:C41("Merci de sélectionner au moins une référence produit")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 