// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21/01/20, 08:20:23
// ----------------------------------------------------
// Method: [Factures].edit.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($table_o; $enregistrement_o)

// Modifié par : Scanu Rémy - remy@connect-io.fr (05/07/2021)
//STOCKER ENREGISTREMENT([Adresses])

If ([Factures:86]FAC_No_Piece:2="")
	CONFIRM:C162("Voulez-vous rendre cette facture définitive ?"; "Oui"; "Non")
	
	If (OK=1)
		[Factures:86]FAC_No_Piece:2:=SO_Facture_Prefixe+"/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
		[Factures:86]FAC_Cloture:10:=True:C214
		[Factures:86]FAC_Statut:16:="Clôturée"
		[Factures:86]FAC_Type:21:="Définitive"
	End if 
	
End if 

// Modifié par : Scanu Rémy - remy@connect-io.fr (05/07/2021)
If ([Factures:86]FAC_Avoir_ID:38>0)  // Il s'agit d'une modification d'un avoir
	$table_o:=ds:C1482.Factures.query("ID is :1"; [Factures:86]FAC_Avoir_ID:38)
	
	If ($table_o.length>0)
		$enregistrement_o:=$table_o[0]
		
		
		If ($enregistrement_o.FAC_Solde_Du_cal<=0)
			$enregistrement_o.FAC_Statut:="Réglée"
			$enregistrement_o.FAC_Regle:=True:C214
		Else 
			$enregistrement_o.FAC_Statut:=""
			$enregistrement_o.FAC_Regle:=False:C215
		End if 
		
		Case of 
			: ($enregistrement_o.FAC_Solde_Du_cal<=0)  //  réglé
				$enregistrement_o.FAC_Regle_Status_Color:=0x0044FC7B
			: (($enregistrement_o.FAC_Solde_Du_cal>0) & ($enregistrement_o.FAC_Solde_Regle#$enregistrement_o.FAC_Montant_TTC))  // réglé partiellement
				$enregistrement_o.FAC_Regle_Status_Color:=0x00FCB944
			Else   // non réglé 
				$enregistrement_o.FAC_Regle_Status_Color:=0x00FC5944
		End case 
		
		$enregistrement_o.save()
	End if 
	
End if 

SAVE RECORD:C53([Factures:86])

UNLOAD RECORD:C212([Factures:86])
READ ONLY:C145([Factures:86])

VALIDATE TRANSACTION:C240

// Modifié par : Scanu Rémy - remy@connect-io.fr (09/07/2021)
//FAC_Get_Liste_Factures 