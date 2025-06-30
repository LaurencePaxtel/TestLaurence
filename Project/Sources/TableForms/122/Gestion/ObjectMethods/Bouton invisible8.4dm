C_TEXT:C284($structure_t; $produit_t; $quantite_t; $quantiteMax_t; $dateDebut_t; $dateFin_t; $position_t; $reference_t; $numIncrementationAutoDebut_t)
C_LONGINT:C283($i_el; $nbJour_el; $j_el; $start_el; $k_el; $quantiteAdd_el; $reference_el)
C_BOOLEAN:C305($referenceAuto_b; $referenceOnlyDigit_b)
C_OBJECT:C1216($enregistrement_o; $table_o)
C_COLLECTION:C1488($collection_c; $autreCollection_c)

C_DATE:C307(dateDebut_d; dateFin_d)

$collection_c:=New collection:C1472
$autreCollection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$structure_t:=structure_at{structure_at}
		
		If ($structure_t#"Choix de la structure")
			ARRAY TO COLLECTION:C1563($collection_c; produit_at; "produit")
			$collection_c.remove(0)
			
			$collection_c:=$collection_c.orderBy("produit")
			$collection_c.insert(0; New object:C1471("produit"; "Nouveau produit"))
			
			$position_t:="center"
			outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $collection_c; \
				"property"; "produit"; "selectSubTitle"; "Choix du produit"; "subTitle"; "Merci de sélectionner un produit, si vous souhaitez ajouter un nouveau produit merci de sélectionner « Nouveau produit » :"; "title"; "Choix du produit :"))
			
			If (selectValue_t#"")
				
				If (selectValue_t="Nouveau produit")
					$produit_t:=Request:C163("Qu'est ce qui doit être ajouter au stock de la structure "+$structure_t+" ?"; ""; "Valider"; "Annuler")
				Else 
					$produit_t:=selectValue_t
				End if 
				
			End if 
			
			If ($produit_t#"")
				
				If (selectValue_t="Nouveau produit")
					$quantiteMax_t:=Request:C163("Quelle est la quantité maximale de « "+$produit_t+" » que peut contenir votre stock ?"; "0"; "Valider"; "Annuler")
				Else 
					$quantiteMax_t:=Request:C163("Quelle est la quantité maximale de « "+$produit_t+" » qui doit être ajouter à votre stock déjà existant ?"; "0"; "Valider"; "Annuler")
				End if 
				
				If (Num:C11($quantiteMax_t)>0)
					$quantite_t:=Request:C163("Quelle est la quantité de « "+$produit_t+" » qui doit-être ajouter au stock ?"; "0"; "Valider"; "Annuler")
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (04/11/2022)
					// Résolution du bug  commande Date(...) dans le formulaire
					Case of 
						: (Num:C11($quantite_t)>0) & (Num:C11($quantite_t)>Num:C11($quantiteMax_t))
							ALERT:C41("La quantité maximale ne peut pas être supérieure à la quantité ajoutée")
						: (Num:C11($quantite_t)>0)
							$dateDebut_t:=Request:C163("A partir de quand le produit « "+$produit_t+" » doit-être ajouter au stock ?"; String:C10(Current date:C33); "Valider"; "Annuler")
							EXECUTE FORMULA:C63("dateDebut_d:=Date:C102(\""+$dateDebut_t+"\")")
							
							If (dateDebut_d#!00-00-00!)
								EXECUTE FORMULA:C63("dateDebut_d:=Date:C102(\""+$dateDebut_t+"\")")
								CONFIRM:C162("Est-ce qu'il y a une date à partir de laquelle le stock de « "+$produit_t+" » doit cesser d'exister ?"; "Oui"; "Non")
								
								If (OK=1)
									$dateFin_t:=Request:C163("A partir de quand le produit « "+$produit_t+" » ne doit plus exister au sein du stock ?"; String:C10(Current date:C33+1); "Valider"; "Annuler")
									EXECUTE FORMULA:C63("dateFin_d:=Date:C102(\""+$dateFin_t+"\")")
									
									If (dateFin_d=!00-00-00!)
										ALERT:C41("La date n'est pas valide, veuillez sélectionner une période")
									End if 
									
								End if 
								
								If (dateFin_d=!00-00-00!)
									$position_t:="center"
									outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("periode"; "1 jour"); New object:C1471("periode"; "1 semaine"); \
										New object:C1471("periode"; "1 mois"); New object:C1471("periode"; "3 mois"); New object:C1471("periode"; "6 mois"); New object:C1471("periode"; "1 an"); New object:C1471("periode"; "2 ans"); New object:C1471("periode"; "3 ans"); \
										New object:C1471("periode"; "4 ans"); New object:C1471("periode"; "5 ans"); New object:C1471("periode"; "10 ans")); \
										"property"; "periode"; "selectSubTitle"; "Choix de la période"; "subTitle"; "Merci de sélectionner une période pour laquelle le produit « "+$produit_t+" » apparaîtra dans votre stock :"; "title"; "Choix de la période :"))
									
									If (selectValue_t#"")
										
										Case of 
											: (selectValue_t="1 jour")
												dateFin_d:=Add to date:C393(dateDebut_d; 0; 0; 1)
											: (selectValue_t="1 semaine")
												dateFin_d:=Add to date:C393(dateDebut_d; 0; 0; 7)
											: (selectValue_t="@mois@")
												dateFin_d:=Add to date:C393(dateDebut_d; 0; Num:C11(selectValue_t); 0)
											: (selectValue_t="@an@")
												dateFin_d:=Add to date:C393(dateDebut_d; Num:C11(selectValue_t); 0; 0)
										End case 
										
									Else 
										ALERT:C41("Aucune période sélectionnée, merci de recommencer")
									End if 
									
								End if 
								
								If (dateFin_d#!00-00-00!)
									CONFIRM:C162("Voulez-vous une référence produit générique pour chaque « "+$produit_t+" », si vous acceptez la référence produit « "+$produit_t+" n°[1,2,3...] » sera appliqué automatiquement ?"; "Oui"; "Non")
									$referenceAuto_b:=(OK=1)
									
									If (OK=0)
										$reference_t:=Request:C163("Référence produit ?"; ""; "Valider"; "Annuler")
										
										If ($reference_t="")
											ALERT:C41("Aucune référence n'a été indiqué, la référence produit générique « "+$produit_t+" [1,2,3...] » va être appliquer automatiquement")
										Else 
											
											For ($i_el; 1; Length:C16($reference_t))
												$referenceOnlyDigit_b:=outilsCheckCharacterIsNumber($reference_t[[$i_el]])
												
												If ($referenceOnlyDigit_b=False:C215)
													$reference_t:=$reference_t+" - [n°]"
													$i_el:=Length:C16($reference_t)
												End if 
												
											End for 
											
										End if 
										
									Else 
										CONFIRM:C162("Voulez-vous faire débuter l'incrémentation auto à partir de « 1 » ?"; "Oui"; "Non")
										
										If (OK=0)
											$numIncrementationAutoDebut_t:=Request:C163("A partir de quand on doit faire débuter l'incrémentation auto ?"; "1"; "Valider"; "Annuler")
											
											If (Num:C11($numIncrementationAutoDebut_t)=0)
												$numIncrementationAutoDebut_t:="1"
											End if 
											
										End if 
										
									End if 
									
									If ($reference_t="")
										$reference_t:=$produit_t+"[n°]"
									End if 
									
									outilsProgressBar(0; "Initialisation"; True:C214)
									
									$nbJour_el:=outilsGetNbJour(dateDebut_d; dateFin_d)
									
									If ($nbJour_el>=0)
										$nbJour_el:=$nbJour_el+1
									End if 
									
									Repeat 
										outilsProgressBar($j_el/$nbJour_el; "Création du produit « "+$produit_t+" » et des références produit en cours..."; True:C214)
										
										// On vérifie qu'on a pas déjà ajouter un produit au stock identique pour le jour sur lequel on est en train de boucler
										$table_o:=ds:C1482.StockBis.query("Ref_Structure = :1 AND produit = :2 AND date = :3"; structure_at{structure_at}; $produit_t; dateDebut_d)
										
										If ($table_o.length=1)
											$enregistrement_o:=$table_o[0]
											
											$enregistrement_o.log.detail.push(New object:C1471("type"; "Modification"; \
												"commentaire"; "Ajout du produit au stock"; \
												"utilisateur"; Current user:C182; \
												"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
										Else 
											$enregistrement_o:=ds:C1482.StockBis.new()
											
											$enregistrement_o.Ref_Structure:=$structure_t
											
											$enregistrement_o.date:=dateDebut_d
											$enregistrement_o.produit:=$produit_t
											
											$enregistrement_o.quantite:=Num:C11($quantite_t)
											$enregistrement_o.quantiteMax:=Num:C11($quantiteMax_t)
											
											$enregistrement_o.log:=New object:C1471("detail"; New collection:C1472(New object:C1471("type"; "Création"; \
												"commentaire"; "Ajout du produit au stock"; \
												"utilisateur"; Current user:C182; \
												"ts"; outilsTimeStamp(Current date:C33; Current time:C178))))
											
											$enregistrement_o.configuration:=New object:C1471("detail"; New collection:C1472)
										End if 
										
										$start_el:=1
										
										If ($numIncrementationAutoDebut_t#"")  // L'utilisateur a décidé de faire démarrer l'incrémentation auto à partir d'un autre nombre qu'1
											$start_el:=Num:C11($numIncrementationAutoDebut_t)
										End if 
										
										For ($i_el; $start_el; Num:C11($quantiteMax_t)+$start_el-1)
											$autreCollection_c:=New collection:C1472
											
											If ($table_o.length=1)  // On complète le stock du produit par d'autres références produit
												$autreCollection_c:=$enregistrement_o.configuration.detail.query("reference = :1"; Replace string:C233($reference_t; "[n°]"; " n°"+String:C10($i_el)))
											End if 
											
											If ($table_o.length=0) | (($table_o.length=1) & ($autreCollection_c.length=0))
												$enregistrement_o.configuration.detail.push(New object:C1471)
												$k_el:=$enregistrement_o.configuration.detail.length-1
												
												$enregistrement_o.configuration.detail[$k_el].id:=Generate UUID:C1066
												
												// Modifié par : Scanu Rémy (04/11/2022)
												
												Case of 
													: ($referenceOnlyDigit_b=False:C215)
														$enregistrement_o.configuration.detail[$k_el].reference:=Replace string:C233($reference_t; "[n°]"; " n°"+String:C10($i_el))
													: ($i_el=$start_el)
														$enregistrement_o.configuration.detail[$k_el].reference:=$reference_t
														$reference_el:=Num:C11($reference_t)
													Else 
														$reference_el:=$reference_el+1
														$enregistrement_o.configuration.detail[$k_el].reference:=String:C10($reference_el)
												End case 
												
												$enregistrement_o.configuration.detail[$k_el].autoReference:=$referenceAuto_b
												
												$quantiteAdd_el:=$quantiteAdd_el+1
												
												If ($quantiteAdd_el<=Num:C11($quantite_t))
													$enregistrement_o.configuration.detail[$k_el].quantite:=1
												Else 
													$enregistrement_o.configuration.detail[$k_el].quantite:=0
												End if 
												
												$enregistrement_o.configuration.detail[$k_el].quantiteMax:=1
												
												$enregistrement_o.configuration.detail[$k_el].log:=New collection:C1472(New object:C1471)
												
												$enregistrement_o.configuration.detail[$k_el].log[0].type:="Creation"
												
												$enregistrement_o.configuration.detail[$k_el].log[0].commentaire:="Ajout de la référence produit"
												$enregistrement_o.configuration.detail[$k_el].log[0].utilisateur:=Current user:C182
												
												$enregistrement_o.configuration.detail[$k_el].log[0].ts:=outilsTimeStamp(Current date:C33; Current time:C178)
											End if 
											
											If ($table_o.length=1) & ($autreCollection_c.length=0)
												
												If ($quantiteAdd_el<=Num:C11($quantite_t))
													$enregistrement_o.quantite:=$enregistrement_o.quantite+1
												End if 
												
												$enregistrement_o.quantiteMax:=$enregistrement_o.quantiteMax+1
											End if 
											
										End for 
										
										$enregistrement_o.save()
										
										$j_el:=$j_el+1
										dateDebut_d:=Add to date:C393(dateDebut_d; 0; 0; 1)
										
										outilsCleanVariable(->$quantiteAdd_el; ->$reference_el)
									Until (dateDebut_d=dateFin_d)
									
									outilsProgressBar(1; "arrêt")
									
									// Mise à jour de la table Societe
									outilsOrdaSearchSimple("SOciete"; "Ref_Structure"; $structure_t; ->$enregistrement_o; "first")
									
									If ($enregistrement_o#Null:C1517)
										
										If ($enregistrement_o.SO_StockHeberge=Null:C1517)
											$enregistrement_o.SO_StockHeberge:=New object:C1471("param"; New collection:C1472)
										End if 
										
										$collection_c:=$enregistrement_o.SO_StockHeberge.param.query("produit = :1"; $produit_t)
										
										If ($collection_c.length=0)
											$enregistrement_o.SO_StockHeberge.param.push(New object:C1471("produit"; $produit_t; "check"; False:C215))
											
											$enregistrement_o.save()
										End if 
										
									Else 
										ALERT:C41("La société associée à la structure « "+$structure_t+" » n'existe pas dans la base de donnée, merci de contacter l'administrateur réseau")
									End if 
									
									Form:C1466.reinitialisation:=True:C214
									POST OUTSIDE CALL:C329(Current process:C322)
								End if 
								
							Else 
								ALERT:C41("La début de début n'est pas au bon format, veuillez recommencer")
							End if 
							
					End case 
					
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Merci de sélectionner une structure")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 