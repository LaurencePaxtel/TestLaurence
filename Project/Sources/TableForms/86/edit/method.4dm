// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/01/20, 13:02:43
// ----------------------------------------------------
// Method: [Factures].edit
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_REAL:C285(montantTTCAvantModif_r)
		
		txt_titre_fenetre_face:="Modification/Visualisation"
		montantTTCAvantModif_r:=[Factures:86]FAC_Montant_TTC:8
		
		GES_Definition_Champs("facture")
		
		START TRANSACTION:C239
		
		If (Records in selection:C76([Factures:86])=1)
			
			If ([Factures:86]FAC_No_Piece:2="")
				
				If ([Factures:86]FAC_Adresse_Facturation:14="")
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures:86]FAC_Destinataire_ID:11)
					
					[Factures:86]FAC_Adresse_Facturation:14:=UTL_Get_Adresse(->[HeBerge:4]ID:65; ->[HeBerge:4])
				End if 
				
			End if 
			
			If ([Factures:86]FAC_Cloture:10)
				
				If ([Factures:86]FAC_Montant_TTC:8>0)
					txt_titre_fenetre_face:="Facture N° "+[Factures:86]FAC_No_Piece:2+" : Visualisation"
				Else 
					txt_titre_fenetre_face:="Avoir N° "+[Factures:86]FAC_No_Piece:2
				End if 
				
				OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "@"; False:C215)
				
				OBJECT SET ENABLED:C1123(*; "btn_annuler"; True:C214)
				OBJECT SET ENABLED:C1123(*; "tab@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_imprimer@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_next@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_previous@"; True:C214)
				
				If ([Factures:86]FAC_Montant_TTC:8<0)
					OBJECT SET ENABLED:C1123(*; "btn_valider"; True:C214)
					OBJECT SET ENABLED:C1123(*; "txt_fac_date"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "txt_fac_date"; True:C214)
					OBJECT SET ENABLED:C1123(*; "txt_fac_date_echeance"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "txt_fac_date_echeance"; True:C214)
					OBJECT SET ENABLED:C1123(*; "txt_fac_commentaires"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "txt_fac_commentaires"; True:C214)
					
					//demande laurence du 28/10/2020
					// possibilité de modifier des avoirs
					OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "@"; True:C214)
				End if 
				
			Else 
				
				If ([Factures:86]FAC_Montant_TTC:8>0)
					txt_titre_fenetre_face:="Facture provisoire : Modification"
				Else 
					txt_titre_fenetre_face:="Avoir : Modification"
				End if 
				
			End if 
			
		End if 
	: (Form event code:C388=Sur case de fermeture:K2:21)
		CANCEL TRANSACTION:C241
		
		CANCEL:C270
End case 