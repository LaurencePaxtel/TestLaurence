// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/03/20, 21:35:17
// ----------------------------------------------------
// Method: [Factures].factures_liste.btn_validation
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($msg)
C_LONGINT:C283($i; $pos)
C_BOOLEAN:C305($continu)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$continu:=True:C214
		$pos:=Find in array:C230(tb_fac_choix; True:C214)
		
		If ($pos>0)
			CONFIRM:C162("Vous êtes entrain de clôturer les factures sélectionnées, voulez-vous continuer ?"; "Oui"; "Non")
			
			If (ok=1)
				START TRANSACTION:C239
				
				For ($i; 1; Size of array:C274(tb_fac_id))
					
					If (tb_fac_choix{$i})
						READ WRITE:C146([Factures:86])
						
						QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i})
						MultiSoc_Filter(->[Factures:86])
						
						If (Records in selection:C76([Factures:86])=1)
							
							If (Not:C34(Locked:C147([Factures:86])))
								
								If ([Factures:86]FAC_No_Piece:2="")
									[Factures:86]FAC_No_Piece:2:=SO_Facture_Prefixe+"/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
									[Factures:86]FAC_Cloture:10:=True:C214
									[Factures:86]FAC_Statut:16:="Clôturée"
									[Factures:86]FAC_Type:21:="Définitive"
									
									SAVE RECORD:C53([Factures:86])
								Else 
									$continu:=False:C215
									$msg:="Les factures sélectionnées sont déja approuvées."
								End if 
								
							Else 
								$continu:=False:C215
								$msg:="Impossible de clôturer  les factures sélectionnées"
							End if 
							
						Else 
							$continu:=False:C215
						End if 
						
					End if 
					
				End for 
				
				If ($msg="")
					$msg:="Impossible de clôturer  les factures sélectionnées"
				End if 
				
				If (Not:C34($continu))
					CANCEL TRANSACTION:C241
					
					ALERT:C41($msg)
				Else 
					VALIDATE TRANSACTION:C240
					
					FAC_Get_Liste_Factures
					ALERT:C41("Opération effectuée avec succès")
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs factures")
		End if 
		
End case 