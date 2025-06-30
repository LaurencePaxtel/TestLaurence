//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script HG_Cloturée  
//{
//{          Lundi 28 Juillet 1997 à 17:36:01
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($nbJour_el; $i_el; $progressBar_el)
C_OBJECT:C1216($table_o; $produit_o; $refProduit_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

P_HG_StatutClôturé(1)

//26/7/2011
P_Transfert_HBAlors("Libelle")

// Modifié par : Scanu Rémy (20/01/2022)
//Form_o.entitySelectionInit.refresh()

// Modifié par : Scanu Rémy (06/02/2023)
If (Form_o.entitySelectionInit#Null:C1517) & (Form_o.reference#Null:C1517)
	
	If ([HeberGement:5]HG_Cloturée:67=False:C215) & (Form_o.entitySelectionInit.length>0) & (Form_o.reference.length>0)
		$nbJour_el:=outilsGetNbJour([HeberGement:5]HG_Date:4; [HeberGement:5]HG_RéservationDateFin:134)
		CONFIRM:C162("Êtes-vous certain de vouloir enlever les éventuelles références produit affectées précedemment à l'hébergé pour "+String:C10($nbJour_el+1)+" jour(s) à compter de la date du "+String:C10([HeberGement:5]HG_Date:4)+" ?"; "Oui"; "Non")
		
		If (OK=1)
			$progressBar_el:=Progress New  // On crée une nouvelle barre
			
			Progress SET BUTTON ENABLED($progressBar_el; True:C214)
			Progress SET ICON($progressBar_el; Storage:C1525.image["progress-bar"]; True:C214)
			
			$collection_c:=Form_o.stockHeberge.extract("produit")
			
			For each ($produit_t; $collection_c)
				Progress SET PROGRESS($progressBar_el; ($collection_c.indexOf($produit_t)+1)/$collection_c.length; "Opération en cours..."; True:C214)
				
				For ($i_el; 0; $nbJour_el)
					$table_o:=Form_o.entitySelectionInit.query("date = :1 AND produit = :2"; [HeberGement:5]HG_Date:4+$i_el; $produit_t)
					
					If ($table_o.length=1)  // Le produit est bien dans le stock pour [HeberGement]HG_Date+$i_el
						$produit_o:=$table_o[0]
						$produit_o.reload()
						
						// On vérifie que pour les jours suivants la référence produit est bien disponible également
						For each ($refProduit_o; $produit_o.configuration.detail)
							
							If (Num:C11($refProduit_o.hebergeID)=[HeberGement:5]HG_HB_ID:19)
								outilsStockGestion(2; [HeberGement:5]HG_Date:4; [HeberGement:5]HG_Date:4+$nbJour_el; Form_o; $produit_o; $refProduit_o; -1)
							End if 
							
						End for each 
						
					End if 
					
				End for 
				
			End for each 
			
			Progress QUIT($progressBar_el)
			
			Form_o.reinitialisation:=True:C214
			POST OUTSIDE CALL:C329(Current process:C322)
		End if 
		
	End if 
	
End if 