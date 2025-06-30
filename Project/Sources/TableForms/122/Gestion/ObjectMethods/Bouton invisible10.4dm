C_TEXT:C284($produit_t)
C_OBJECT:C1216($table_o; $enregistrement_o; $refProduit_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (produit_at{produit_at}#"") & (produit_at{produit_at}#"Tous")
			CONFIRM:C162("Voulez-vous changer le nom du produit (cette opération est irréversible) ?"; "Oui"; "Non")
			
			If (OK=1)
				$produit_t:=Request:C163("Nouveau nom du produit « "+produit_at{produit_at}+" » ?"; ""; "Valider"; "Annuler")
				
				If ($produit_t#"")
					$table_o:=Form:C1466.entitySelectionInit.query("produit = :1"; produit_at{produit_at})
					
					If ($table_o.length>0)
						outilsProgressBar(0; "Initialisation"; True:C214)
						
						For each ($enregistrement_o; $table_o)
							outilsProgressBar(($enregistrement_o.indexOf($table_o)+1)/$table_o.length; "Modification du produit « "+produit_at{produit_at}+" » et des références produit en cours..."; True:C214)
							
							$enregistrement_o.produit:=$produit_t
							$collection_c:=$enregistrement_o.configuration.detail.query("autoReference = :1"; True:C214)
							
							If ($collection_c.length>0)  // Il y a des références produits qui ont été généré automatiquement suivant le modèle "nomProduit n°[x]"
								
								For each ($refProduit_o; $collection_c)
									$refProduit_o.reference:=Replace string:C233($refProduit_o.reference; produit_at{produit_at}; $produit_t)
								End for each 
								
							End if 
							
							$enregistrement_o.save()
						End for each 
						
						outilsProgressBar(1; "arrêt")
						
						// Mise à jour de la table Societe
						outilsOrdaSearchSimple("SOciete"; "Ref_Structure"; structure_at{structure_at}; ->$enregistrement_o; "first")
						
						If ($enregistrement_o#Null:C1517)
							$collection_c:=$enregistrement_o.SO_StockHeberge.param.query("produit = :1"; produit_at{produit_at})
							
							If ($collection_c.length=1)
								$collection_c[0].produit:=$produit_t
								
								$enregistrement_o.save()
							End if 
							
						End if 
						
						Form:C1466.reinitialisation:=True:C214
						POST OUTSIDE CALL:C329(Current process:C322)
					End if 
					
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner un produit avant de pouvoir l'éditer")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 