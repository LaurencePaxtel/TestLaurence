// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25/01/20, 18:24:22
// ----------------------------------------------------
// Method: [Factures].edit_reglement.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $j; $montant_r; $montantARegler_r : Real


ARRAY TEXT:C222($tab_ids_factures_regles; 0)
ARRAY LONGINT:C221($tb_ids_fac_regles; 0)

SAVE RECORD:C53([Reglements:93])

$montant_r:=[Reglements:93]REG_Montant:5
transact_continu:=True:C214

UTL_Decoupe_texte(->[Reglements:93]REG_Origine_IDS:21; ->$tab_ids_factures_regles; ";")

For ($j; 1; Size of array:C274($tab_ids_factures_regles))
	APPEND TO ARRAY:C911($tb_ids_fac_regles; Num:C11($tab_ids_factures_regles{$j}))
End for 

READ WRITE:C146([Factures:86])
QUERY WITH ARRAY:C644([Factures:86]ID:1; $tb_ids_fac_regles)

// Modifié par : Scanu Rémy (19/04/2023)
// Si réglement de plusieurs factures, on prend les plus anciennes en premier
ORDER BY:C49([Factures:86]; [Factures:86]FAC_Annee:34; >; [Factures:86]FAC_Mois:33; >)

While (Not:C34(End selection:C36([Factures:86])))
	
	If (Not:C34(Locked:C147([Factures:86])))
		$montantARegler_r:=[Factures:86]FAC_Montant_TTC:8-[Factures:86]FAC_Solde_Regle:26
		
		//===============================================//
		// ANNULATION D'IMPUTATION DES FACTURES EN CAD DE MODIFICATION
		// D'UN REGLEMENTS
		//===============================================//
		If (Not:C34(reg_is_new_record))
			
			If (montant_regle_sauve>0)
				
				If (montant_regle_sauve>=[Factures:86]FAC_Montant_TTC:8)
					montant_regle_sauve:=montant_regle_sauve-[Factures:86]FAC_Montant_TTC:8
					[Factures:86]FAC_Solde_Regle:26:=0
				Else 
					[Factures:86]FAC_Solde_Regle:26:=[Factures:86]FAC_Solde_Regle:26-montant_regle_sauve
					montant_regle_sauve:=0
				End if 
				
			End if 
			
		End if 
		
		//===============================================//
		// IMPUTATION FACTURES
		//===============================================//
		If ($montant_r>0)
			
			If ($montant_r>=$montantARegler_r)
				$montant_r:=$montant_r-$montantARegler_r
				[Factures:86]FAC_Solde_Regle:26:=[Factures:86]FAC_Montant_TTC:8
			Else 
				[Factures:86]FAC_Solde_Regle:26:=[Factures:86]FAC_Solde_Regle:26+$montant_r
				CLEAR VARIABLE:C89($montant_r)
			End if 
			
		End if 
		
		If ([Factures:86]FAC_Solde_Regle:26=[Factures:86]FAC_Montant_TTC:8)
			[Factures:86]FAC_Statut:16:="Réglée"
			[Factures:86]FAC_Regle:41:=True:C214
		Else 
			[Factures:86]FAC_Statut:16:=""
			[Factures:86]FAC_Regle:41:=False:C215
		End if 
		
		Case of 
			: ([Factures:86]FAC_Regle:41=True:C214)  //  Réglé
				[Factures:86]FAC_Regle_Status_Color:44:=0x0044FC7B
			: ([Factures:86]FAC_Solde_Regle:26>0) & ([Factures:86]FAC_Solde_Regle:26#[Factures:86]FAC_Montant_TTC:8)  // Réglé partiellement
				[Factures:86]FAC_Regle_Status_Color:44:=0x00FCB944
			Else   // Non réglé 
				[Factures:86]FAC_Regle_Status_Color:44:=0x00FC5944
		End case 
		
		SAVE RECORD:C53([Factures:86])
	Else 
		transact_continu:=False:C215
	End if 
	
	If (transact_continu=False:C215)
		LAST RECORD:C200([Factures:86])
	End if 
	
	NEXT RECORD:C51([Factures:86])
End while 

If (transact_continu)
	
	VALIDATE TRANSACTION:C240
	
	UNLOAD RECORD:C212([Factures:86])
	UNLOAD RECORD:C212([Reglements:93])
	
	// Modifié par : Scanu Rémy (21/04/2023)
	If (Num:C11(Form:C1466.appel)=1)  // Bouton "Règlement" du formulaire [Factures]factures_liste
		//outilsManageFacture(30)
	End if 
	
Else 
	ALERT:C41("Une des factures sur lequel le règlement s'applique est actuellement verrouillé, impossible de valider.")
	CANCEL TRANSACTION:C241
End if 