C_REAL:C285($montant_r)
C_BOOLEAN:C305($stop_b)
C_OBJECT:C1216($table_o; $enregistrement_o; $autreTable_o; $autreEnregistrement_o; $statut_o; $ds_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

If (Records in set:C195("$ReglementsSelection")>0)
	CONFIRM:C162("Voulez-vous vraiment supprimer "+Choose:C955(Records in set:C195("$ReglementsSelection")=1; "le réglement sélectionné"; "les "+String:C10(Records in set:C195("$ReglementsSelection"))+" réglements sélectionnés"); "Oui"; "Non")
	
	If (OK=1)
		USE SET:C118("$ReglementsSelection")
		$table_o:=Create entity selection:C1512([Reglements:93])
		
		UNLOAD RECORD:C212([Reglements:93])
		
		START TRANSACTION:C239
		
		$ds_o:=ds:C1482
		$ds_o.startTransaction()
		
		READ WRITE:C146([Factures:86])
		
		For each ($enregistrement_o; $table_o) Until ($stop_b=True:C214)
			$collection_c:=Split string:C1554($enregistrement_o.REG_Origine_IDS; ";")
			outilsManageCollection(1; ->$collection_c)
			
			$montant_r:=$enregistrement_o.REG_Montant
			$autreTable_o:=ds:C1482.Factures.query("ID in :1"; $collection_c)
			
			For each ($autreEnregistrement_o; $autreTable_o)
				
				If ($montant_r>0)
					
					If ($montant_r>=$autreEnregistrement_o.FAC_Solde_Regle)
						$montant_r:=$montant_r-$autreEnregistrement_o.FAC_Solde_Regle
						$autreEnregistrement_o.FAC_Solde_Regle:=0
					Else 
						$autreEnregistrement_o.FAC_Solde_Regle:=$autreEnregistrement_o.FAC_Solde_Regle-$montant_r
						CLEAR VARIABLE:C89($montant_r)
					End if 
					
					$autreEnregistrement_o.FAC_Statut:=""
					$autreEnregistrement_o.FAC_Regle:=False:C215
					
					
					Case of 
						: ($autreEnregistrement_o.FAC_Solde_Du_cal=0)  //  Réglé
							$autreEnregistrement_o.FAC_Regle_Status_Color:=0x0044FC7B
						: ($autreEnregistrement_o.FAC_Solde_Du_cal>0) & ($autreEnregistrement_o.FAC_Solde_Regle#$autreEnregistrement_o.FAC_Montant_TTC) & ($autreEnregistrement_o.FAC_Solde_Regle>0)  // Réglé partiellement
							$autreEnregistrement_o.FAC_Regle_Status_Color:=0x00FCB944
						Else   // Non réglé 
							$autreEnregistrement_o.FAC_Regle_Status_Color:=0x00FC5944
					End case 
					
					$autreEnregistrement_o.save()
					
					QUERY:C277([Factures:86]; [Factures:86]ID:1=$autreEnregistrement_o.ID)
					outilsManageFacture(30)
					
					SAVE RECORD:C53([Factures:86])
					UNLOAD RECORD:C212([Factures:86])
				End if 
				
			End for each 
			
			$enregistrement_o.reload()
			
			$statut_o:=$enregistrement_o.drop()
			$stop_b:=($statut_o.success=False:C215)
		End for each 
		
		If ($stop_b=True:C214)
			ALERT:C41(Choose:C955(Records in set:C195("$ReglementsSelection")=1; "Le réglement sélectionné n'a pas pu être supprimé"; "Les "+String:C10(Records in set:C195("$ReglementsSelection"))+\
				" réglements sélectionnés n'ont pas pu être supprimés")+", merci de recommencer la procédure de suppression !")
			
			CANCEL TRANSACTION:C241
			$ds_o.cancelTransaction()
		Else 
			VALIDATE TRANSACTION:C240
			$ds_o.validateTransaction()
			
			REG_Get_Liste
		End if 
		
	End if 
	
Else 
	ALERT:C41("Merci de sélectionner un ou plusieurs réglements à supprimer")
End if 