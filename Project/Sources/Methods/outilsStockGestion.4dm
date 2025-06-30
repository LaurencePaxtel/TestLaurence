//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 05/01/22, 11:06:06
// ----------------------------------------------------
// Méthode : outilsStockGestion
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer  // Entrée
var $2 : Variant
var $3 : Variant
var $4 : Object
var $5 : Object
var $6 : Object
var $7 : Integer

var $nbJour_el; $i_el; $quantiteModif_el; $quantiteMaxModif_el : Integer
var $date_d : Date
var $table_o; $enregistrement_o : Object
var $collection_c : Collection

var autreCollection_c : Collection

If (Count parameters:C259=7)  // Si on provient du formulaire [StockBis]Disponibilite
	$4.elementCourant:=$5
	$4.refSelection:=New collection:C1472($6)
	
	$4.oldReference:=$4.refSelection[0].reference
	$4.oldQuantite:=$4.refSelection[0].quantite
	
	$4.refSelection[0].quantite:=$4.oldQuantite-$7
End if 

Case of 
	: ($1<=2)  // Modification d'une ou plusieurs référence produit
		$nbJour_el:=outilsGetNbJour($2; $3)
		
		If ($nbJour_el>=0)
			$nbJour_el:=$nbJour_el+1
		End if 
		
		$date_d:=$2
		$collection_c:=New collection:C1472
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For ($i_el; 1; $nbJour_el)
			outilsProgressBar($i_el/$nbJour_el; "Modification des références produit en cours..."; True:C214)
			
			If ($i_el>1)
				$date_d:=Add to date:C393($date_d; 0; 0; 1)
			End if 
			
			$table_o:=ds:C1482.StockBis.query("date = :1 AND produit = :2"; $date_d; $4.elementCourant.produit)
			
			If ($table_o.length=0)  // Le stock de produit n'existe pas à la date sur laquelle on est en train de boucler
				$collection_c.push(New object:C1471("produit"; $4.elementCourant.produit; "date"; $date_d; "commentaire"; "Le produit « "+$4.elementCourant.produit+" » n'existe pas"))
			Else   // Le stock de produit existe, on va regarder si la référence de produit aussi
				$enregistrement_o:=$table_o.first()
				$enregistrement_o.reload()
				
				autreCollection_c:=New collection:C1472
				
				For each ($refProduit_o; $4.refSelection)
					
					// Obliger de faire avec la commande EXECUTER FORMULE car sans, ça ne marche pas et pire ça provoque une erreur (?)...
					If ($4.refSelection.length=1)  // Une seule référence produit sélectionnée
						EXECUTE FORMULA:C63("autreCollection_c:=$enregistrement_o.configuration.detail.query(\"reference = :1\";\""+$4.oldReference+"\")")
					Else   // Plusieurs références produit sélectionnées
						EXECUTE FORMULA:C63("autreCollection_c:=$enregistrement_o.configuration.detail.query(\"reference = :1\";\""+$refProduit_o.reference+"\")")
					End if 
					
					If (autreCollection_c.length=1)  // Bingo la référence produit existe pour la date sur laquelle on est en train de boucler
						
						If ($4.refSelection.length=1)  // Une seule référence produit sélectionnée
							autreCollection_c[0].reference:=$4.refSelection[0].reference
							
							If ($4.oldReference#autreCollection_c[0].reference)  // La référence produit a été modifiée, ajout d"un log
								autreCollection_c[0].log.push(New object:C1471("type"; "Modification"; "commentaire"; "La référence produit est passé de « "+$4.oldReference+" » à « "+autreCollection_c[0].reference+" »"; "ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
							End if 
							
						End if 
						
						Case of 
							: ($1=1)  // Gestion des quantités maximales
								$quantiteMaxModif_el:=$4.oldQuantiteMax-$4.refSelection[0].quantiteMax
								
								If ($quantiteMaxModif_el#0)  // On a diminué ou augmenté la quantité maximale dans le stock
									autreCollection_c[0].log.push(New object:C1471("type"; "Modification"; "commentaire"; "La quantité maximale de la référence produit « "+autreCollection_c[0].reference+" » est passé de « "+String:C10($4.oldQuantiteMax)+" » à « "+String:C10($4.refSelection[0].quantiteMax)+" »"; "ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
									$enregistrement_o.log.detail.push(New object:C1471("type"; "Modification"; \
										"commentaire"; "Changement de la quantité maximale de stock"; \
										"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
									
									Case of 
										: ($quantiteMaxModif_el<0)  // On a augmenté la quantité max
											autreCollection_c[0].quantite:=autreCollection_c[0].quantite+Abs:C99($quantiteMaxModif_el)
											
											$enregistrement_o.quantiteMax:=$enregistrement_o.quantiteMax+Abs:C99($quantiteMaxModif_el)
											$enregistrement_o.quantite:=$enregistrement_o.quantite+Abs:C99($quantiteMaxModif_el)
										: ($quantiteMaxModif_el>0)  // On a diminué la quantité max
											
											If (autreCollection_c[0].quantite<(autreCollection_c[0].quantite-$quantiteMaxModif_el))
												$enregistrement_o.quantite:=$enregistrement_o.quantite-autreCollection_c[0].quantite
												autreCollection_c[0].quantite:=0
											End if 
											
											$enregistrement_o.quantiteMax:=$enregistrement_o.quantiteMax-$quantiteMaxModif_el
											
											If ($enregistrement_o.quantite<0)  // Si on a trop diminué le stock
												$enregistrement_o.quantite:=0
											End if 
											
									End case 
									
									autreCollection_c[0].quantiteMax:=$4.refSelection[0].quantiteMax
								End if 
								
							: ($1=2)  // Gestion des quantités restantes
								$quantiteModif_el:=$4.oldQuantite-$4.refSelection[0].quantite
								
								If ($quantiteModif_el#0)  // On a diminué ou augmenté la quantité restante dans le stock
									autreCollection_c[0].log.push(New object:C1471("type"; "Modification"; \
										"commentaire"; "La quantité restante de la référence produit « "+autreCollection_c[0].reference+" » est passé de « "+String:C10($4.oldQuantite)+" » à « "+String:C10($4.refSelection[0].quantite)+" »"; \
										"utilisateur"; Current user:C182; \
										"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
									
									$enregistrement_o.log.detail.push(New object:C1471("type"; "Modification"; \
										"commentaire"; "Changement de la quantité restante du stock"; \
										"utilisateur"; Current user:C182; \
										"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
									
									autreCollection_c[0].quantite:=$4.refSelection[0].quantite
									
									Case of 
										: ($quantiteModif_el<0)  // On a augmenté la quantité restante
											$enregistrement_o.quantite:=$enregistrement_o.quantite+Abs:C99($quantiteModif_el)
											
											If (Count parameters:C259=7)  // Si on provient du formulaire [StockBis]Disponibilite
												
												If (autreCollection_c[0].hebergeID#Null:C1517)
													OB REMOVE:C1226(autreCollection_c[0]; "hebergeID")
												End if 
												
											End if 
											
										: ($quantiteModif_el>0)  // On a diminué la quantité restante
											$enregistrement_o.quantite:=$enregistrement_o.quantite-$quantiteModif_el
											
											If ($enregistrement_o.quantite<0)  // Si on a trop diminué le stock
												$enregistrement_o.quantite:=0
											End if 
											
											If (Count parameters:C259=7)  // Si on provient du formulaire [StockBis]Disponibilite
												autreCollection_c[0].log.push(New object:C1471("type"; "Infos"; \
													"commentaire"; "La référence produit « "+autreCollection_c[0].reference+" » a été affectée à l'hébergé "+String:C10([HeberGement:5]HG_HB_ID:19); \
													"utilisateur"; Current user:C182; \
													"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
												
												autreCollection_c[0].hebergeID:=[HeberGement:5]HG_HB_ID:19
											End if 
											
									End case 
									
								End if 
								
						End case 
						
						$enregistrement_o.save()
					Else 
						$collection_c.push(New object:C1471("produit"; $4.elementCourant.produit; "date"; $date_d; "commentaire"; "La référence produit « "+$4.oldReference+" » n'existe pas"))
					End if 
					
				End for each 
				
			End if 
			
		End for 
		
		outilsProgressBar(1; "arrêt")
	: ($1=3)  // Ajout d'une référence produit
		$3.elementCourant.configuration.detail.push(New object:C1471)
		
		$i_el:=$3.elementCourant.configuration.detail.length-1
		$2->:=Generate UUID:C1066
		
		$3.elementCourant.configuration.detail[$i_el].id:=$2->
		$3.elementCourant.configuration.detail[$i_el].reference:="Nouvelle référence produit"
		
		$3.elementCourant.configuration.detail[$i_el].quantite:=0
		$3.elementCourant.configuration.detail[$i_el].quantiteMax:=0
		
		$3.elementCourant.configuration.detail[$i_el].log:=New collection:C1472(New object:C1471)
		
		$3.elementCourant.configuration.detail[$i_el].log[0].type:="Creation"
		$3.elementCourant.configuration.detail[$i_el].log[0].commentaire:="Ajout de la référence produit"
		$3.elementCourant.configuration.detail[$i_el].log[0].ts:=outilsTimeStamp(Current date:C33; Current time:C178)
		
		$3.elementCourant.save()
		
		$3.refSelection:=New collection:C1472($3.elementCourant.configuration.detail[$i_el])
End case 

If (Count parameters:C259=7)
	OB REMOVE:C1226($4; "elementCourant")
	OB REMOVE:C1226($4; "refSelection")
	
	OB REMOVE:C1226($4; "oldReference")
	OB REMOVE:C1226($4; "oldQuantite")
End if 