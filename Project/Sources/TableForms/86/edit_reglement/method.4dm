var $montantARegle_r : Real
var $facture_o : Object
var $facture_c; $heberge_c; $reglement_c : Collection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var reg_is_new_record : Boolean
		var montant_regle_sauve : Real
		
		montant_regle_sauve:=0
		
		START TRANSACTION:C239
		
		If (reg_is_new_record)
			var transact_continu : Boolean
			
			transact_continu:=True:C214
			
			CREATE RECORD:C68([Reglements:93])
			MultiSoc_Init_Structure(->[Reglements:93])
			
			[Reglements:93]REG_Date_Piece:4:=Current date:C33(*)
			[Reglements:93]REG_Date_Echeance:8:=Add to date:C393(Current date:C33(*); 0; 0; 10)
			[Reglements:93]REG_Mode_Reglement:7:=<>ta_GL_ModesReglements{<>ta_GL_ModesReglements}
			[Reglements:93]REG_Origine_Table_No:19:=Table:C252(->[Factures:86])
			[Reglements:93]REG_No_Piece:3:="RC/"+UTL_Numerotation_Piece(->[Reglements:93]REG_Date_Piece:4)
			[Reglements:93]REG_Libelle:28:="Règlement"
			
			// Modifié par : Scanu Rémy (20/04/2023)
			// Utilisation d'une collection plutôt que les tableaux plus facile à trier
			$facture_c:=New collection:C1472
			$heberge_c:=New collection:C1472
			
			ARRAY TO COLLECTION:C1563($facture_c; \
				tb_fac_choix; "checked"; \
				tb_fac_destinataire_id; "destinataireID"; \
				tb_fac_numero_piece; "numFact"; \
				tb_fac_id; "factureID"; \
				tb_fac_mois; "mois"; \
				tb_fac_annee; "annee")
			
			// On tri par hébergé et par date décroissante pour ne prendre que la plus récente par hébergé
			$facture_c:=$facture_c.query("checked = :1"; True:C214).orderBy("destinataireID asc, annee desc, mois desc")
			
			If ($facture_c.distinct("destinataireID").length>1)
				transact_continu:=False:C215
				ALERT:C41("Impossible de faire un réglement sur plusieurs hébergés")
			End if 
			
			$reglement_c:=$facture_c.query("numFact = :1"; "RC/@")
			
			If ($reglement_c.length>0)
				transact_continu:=False:C215
				ALERT:C41("Impossible de faire un réglement sur des règlements, veuillez les déselectionner.")
			End if 
			
			If (transact_continu=True:C214)
				
				For each ($facture_o; $facture_c) Until (transact_continu=False:C215)
					[Reglements:93]REG_Origine_IDS:21:=[Reglements:93]REG_Origine_IDS:21+String:C10($facture_o.factureID)+";"
					[Reglements:93]REG_Origine_ID:18:=$facture_o.destinataireID
					
					[Reglements:93]REG_Libelle_Plus_1:29:=[Reglements:93]REG_Libelle_Plus_1:29+" "+$facture_o.numFact
					
					If ($heberge_c.indexOf($facture_o.destinataireID)=-1)
						$heberge_c.push($facture_o.destinataireID)
						
						READ WRITE:C146([Factures:86])
						QUERY:C277([Factures:86]; [Factures:86]ID:1=$facture_o.factureID)
						
						$montantARegle_r:=([Factures:86]FAC_Montant_TTC:8-[Factures:86]FAC_Solde_Regle:26)
						[Reglements:93]REG_Montant:5:=[Reglements:93]REG_Montant:5+$montantARegle_r
						
						If (Records in selection:C76([Factures:86])=1)
							
							If (Not:C34(Locked:C147([Factures:86])))
								
								If ([Factures:86]FAC_No_Piece:2#"")
									
									// Modifié par : Scanu Rémy (27/09/2023)
									// On autorise finalement des réglements sur des factures déjà indiquées comme "Réglée"
									[Reglements:93]REG_Destinataire_Nom:11:=[Factures:86]FAC_Destinataire_Nom:13
									
/*
Si ([Factures]FAC_Regle=Faux)
[Reglements]REG_Destinataire_Nom:=[Factures]FAC_Destinataire_Nom
Sinon 
transact_continu:=Faux
ALERTE("La facture avec l'id « "+Chaîne([Factures]ID)+" » est déjà réglée, impossible d'appliquer un réglement dessus")
Fin de si 
*/
									
								Else 
									transact_continu:=False:C215
									ALERT:C41("La facture avec l'id « "+String:C10([Factures:86]ID:1)+" » est provisoire, impossible d'appliquer un réglement dessus")
								End if 
								
							Else 
								transact_continu:=False:C215
								ALERT:C41("La facture avec l'id « "+String:C10([Factures:86]ID:1)+" » est verrouillé, impossible d'appliquer un réglement dessus.")
							End if 
							
						Else 
							transact_continu:=False:C215
							ALERT:C41("La facture avec l'id « "+String:C10([Factures:86]ID:1)+" » n'a pas pu être trouvée dans la base de donnée.")
						End if 
						
						UNLOAD RECORD:C212([Factures:86])
						READ ONLY:C145([Factures:86])
					End if 
					
				End for each 
				
			End if 
			
			If (Not:C34(transact_continu))
				CANCEL:C270
			End if 
			
			OBJECT SET ENTERABLE:C238(*; "Field6"; True:C214)
		Else 
			montant_regle_sauve:=[Reglements:93]REG_Montant:5
		End if 
		
	: (Form event code:C388=Sur case de fermeture:K2:21)
		CANCEL TRANSACTION:C241
		CANCEL:C270
End case 