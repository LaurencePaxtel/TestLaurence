C_TEXT:C284($produit_t)
C_OBJECT:C1216($table_o; $enregistrement_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.elementSelection.length>0)
			CONFIRM:C162("Êtes-vous sûr de supprimer "+Choose:C955(Form:C1466.elementSelection.length>1; "les "; "l'élément")+Choose:C955(Form:C1466.elementSelection.length>1; String:C10(Form:C1466.elementSelection.length); "")+" sélectionné(s) ?"; "Oui"; "Non")
			
			If (OK=1)
				$collection_c:=Form:C1466.elementSelection.toCollection("produit").distinct("produit")
				Form:C1466.elementSelection.drop()
				
				$table_o:=ds:C1482.StockBis.all()
				outilsOrdaSearchByRefStctre(->$table_o; structure_at{structure_at})
				
				For each ($produit_t; $collection_c)
					$table_o:=$table_o.query("produit = :1"; $produit_t)
					
					If ($table_o.length=0)  // Le stock ne contient plus aucune produit qui vient d'être supprimer
						outilsOrdaSearchSimple("SOciete"; "Ref_Structure"; structure_at{structure_at}; ->$enregistrement_o; "first")
						
						If ($enregistrement_o#Null:C1517)
							$collection_c:=$enregistrement_o.SO_StockHeberge.param.indices("produit = :1"; $produit_t)
							
							If ($collection_c.length=1)
								$enregistrement_o.SO_StockHeberge.param.remove($collection_c[0])
								
								$enregistrement_o.save()
							End if 
							
						End if 
						
					End if 
					
				End for each 
				
				Form:C1466.reinitialisation:=True:C214
				POST OUTSIDE CALL:C329(Current process:C322)
			End if 
			
		Else 
			ALERT:C41("Merci de sélectionner un ou plusieurs éléments dans la liste ci-dessous")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 