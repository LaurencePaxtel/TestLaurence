C_TEXT:C284($position_t)
C_LONGINT:C283($i_el; $nbJour_el; $nbJourFullDay_el)
C_BOOLEAN:C305($stop_b)
C_OBJECT:C1216($table_o; $produit_o)
C_COLLECTION:C1488($collection_c; $autreCollection_c)

$collection_c:=New collection:C1472
$autreCollection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$nbJour_el:=outilsGetNbJour(date_d; [HeberGement:5]HG_RéservationDateFin:134)
		
		If ($nbJour_el=0)
			$nbJour_el:=1
		End if 
		
		If (Form:C1466.refCourant#Null:C1517)
			
			If ($nbJour_el>1)
				
				For ($i_el; 1; $nbJour_el+1)
					
					If ($i_el=1)
						$autreCollection_c.push(New object:C1471("periode"; String:C10($i_el)+" jour"))
					Else 
						$autreCollection_c.push(New object:C1471("periode"; String:C10($i_el)+" jours"))
					End if 
					
				End for 
				
				$position_t:="center"
				outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $autreCollection_c; \
					"property"; "periode"; \
					"selectSubTitle"; "Choix de la période"; \
					"subTitle"; "Merci de sélectionner une période pour laquelle la référence produit « "+Form:C1466.refCourant.reference+" » sera bloquée pour l'hébergé :"; \
					"title"; "Choix de la période :"))
				
				$nbJour_el:=Num:C11(selectValue_t)
			End if 
			
			If ($nbJour_el>0)
				CONFIRM:C162("Êtes-vous sûr(e) de vouloir bloquer la référence produit « "+Form:C1466.refCourant.reference+" » pour "+Choose:C955($nbJour_el>1; String:C10($nbJour_el)+" jours"; "1 journée")+" à compter du "+String:C10(date_d)+" ?"; "Oui"; "Non")
				
				If (OK=1)
					
					If ($nbJour_el>0)
						$nbJour_el:=$nbJour_el-1
					End if 
					
					For ($i_el; 0; $nbJour_el)
						$stop_b:=True:C214
						$table_o:=Form:C1466.entitySelectionInit.query("date = :1 AND produit = :2"; date_d+$i_el; Form:C1466.refCourant.produit)
						
						If ($table_o.length=1)  // Le produit est bien dans le stock pour date_d+$i_el
							$produit_o:=$table_o[0]
							$produit_o.reload()
							
							// On vérifie que pour les jours suivants la référence produit est bien disponible également
							$collection_c:=$produit_o.configuration.detail.query("reference = :1"; Form:C1466.refCourant.reference)
							
							If ($collection_c.length=1)
								$stop_b:=($collection_c[0].quantite=0)
								
								If ($stop_b=True:C214)  // La date est dépourvue en quantité restante suffisante, ça veux dire que cette référence produit a déjà été affecté à quelqu'un, reste à savoir qui... :D
									
									If (Num:C11($collection_c[0].hebergeID)#[HeberGement:5]HG_HB_ID:19)
										$nbJourFullDay_el:=outilsStockGetFullDay(Form:C1466.entitySelectionInit; date_d+$i_el; Form:C1466.refCourant.produit; Form:C1466.refCourant.reference; Num:C11($collection_c[0].hebergeID))
										$table_o:=ds:C1482.HeBerge.query("HB_ReferenceID is :1"; Num:C11($collection_c[0].hebergeID))
										
										If ($table_o.length=1)
											ALERT:C41("Impossible de bloquer la référence produit « "+Form:C1466.refCourant.reference+" » car pour la période du "+String:C10(date_d+$i_el)+" au "+String:C10(date_d+$i_el+$nbJourFullDay_el-1)+" celle-ci est déjà affectée à "+$table_o[0].HB_Nom+" "+$table_o[0].HB_Prénom)
										Else 
											ALERT:C41("Impossible de bloquer la référence produit « "+Form:C1466.refCourant.reference+" » car pour la période du "+String:C10(date_d+$i_el)+" au "+String:C10(date_d+$i_el+$nbJourFullDay_el-1)+" celle-ci est déjà affectée à un hébergé")
										End if 
										
									End if 
									
								End if 
								
							Else 
								ALERT:C41("Impossible de bloquer la référence produit « "+Form:C1466.refCourant.reference+" » car pour la journée du "+String:C10(date_d+$i_el)+" celle-ci n'existe pas")
							End if 
							
						Else 
							ALERT:C41("Impossible de bloquer la référence produit « "+Form:C1466.refCourant.reference+" » car pour la journée du "+String:C10(date_d+$i_el)+" le produit « "+Form:C1466.refCourant.produit+" » n'existe pas")
						End if 
						
						If ($stop_b=True:C214)
							$i_el:=$nbJour_el
						End if 
						
					End for 
					
					If ($stop_b=False:C215)  // Toutes les dates sont pourvus en produit et en référence produit suffisament importante et la référence produit n'a pas déjà été affectée
						outilsStockGestion(2; date_d; date_d+$nbJour_el; Form:C1466; $produit_o; Form:C1466.refCourant; 1)
						
						ACCEPT:C269
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 