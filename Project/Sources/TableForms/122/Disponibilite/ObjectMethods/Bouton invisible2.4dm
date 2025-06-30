C_LONGINT:C283($nbJour_el; $i_el)
C_OBJECT:C1216($table_o; $produit_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.refCourant#Null:C1517)
			$nbJour_el:=outilsGetNbJour(date_d; [HeberGement:5]HG_RéservationDateFin:134)
			CONFIRM:C162("Êtes-vous certain de vouloir désaffecté la référence produit « "+Form:C1466.refCourant.reference+" » pour "+String:C10($nbJour_el+1)+" jour(s) à compter de la date du "+String:C10(date_d)+" ?"; "Oui"; "Non")
			
			If (OK=1)
				
				For ($i_el; 0; $nbJour_el)
					$table_o:=Form:C1466.entitySelectionInit.query("date = :1 AND produit = :2"; date_d+$i_el; Form:C1466.refCourant.produit)
					
					If ($table_o.length=1)  // Le produit est bien dans le stock pour date_d+$i_el
						$produit_o:=$table_o[0]
						$produit_o.reload()
						
						// On vérifie que pour les jours suivants la référence produit est bien disponible également
						$collection_c:=$produit_o.configuration.detail.query("reference = :1"; Form:C1466.refCourant.reference)
						
						If ($collection_c.length=1)
							
							If (Num:C11($collection_c[0].hebergeID)=[HeberGement:5]HG_HB_ID:19)
								outilsStockGestion(2; date_d; date_d+$nbJour_el; Form:C1466; $produit_o; Form:C1466.refCourant; -1)
							End if 
							
						End if 
						
					End if 
					
				End for 
				
				POST OUTSIDE CALL:C329(Current process:C322)
			End if 
			
		Else 
			ALERT:C41("Merci de sélectionner au moins une référence produit")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 