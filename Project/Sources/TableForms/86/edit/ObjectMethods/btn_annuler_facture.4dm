// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 30/10/2020, 12:18:45
// ----------------------------------------------------
// Method: [Factures].edit.btn_annuler_facture
// Description
// demande laurence du 28/10/2020
// pour annuler les factures
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If ([Factures:86]FAC_No_Piece:2#"")
			
			C_BOOLEAN:C305($continu)
			C_LONGINT:C283($id_facture)
			$continu:=True:C214
			START TRANSACTION:C239
			
			[Factures:86]FAC_Statut:16:="Annulée"
			SAVE RECORD:C53([Factures:86])
			
			$id_facture:=[Factures:86]ID:1
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			ARRAY LONGINT:C221($tb_lig_id; 0)
			SELECTION TO ARRAY:C260([Factures_Lignes:87]ID:1; $tb_lig_id)
			
			For ($j; 1; Size of array:C274($tb_lig_id))
				
				READ WRITE:C146([Factures_Lignes:87])
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$id_facture; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]ID:1=$tb_lig_id{$j})
				MultiSoc_Filter(->[Factures_Lignes:87])
				
				$ids_hebergements:=[Factures_Lignes:87]FACL_Service_Ids:30
				[Factures_Lignes:87]FACL_Service_Ids:30:=""
				SAVE RECORD:C53([Factures_Lignes:87])
				
				//=============================
				// Annulation des fiches d'hébergement facturées
				//=============================
				ARRAY TEXT:C222($tb_données; 0)
				UTL_Cut_Text(->$ids_hebergements; ->$tb_données; ";")
				ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
				
				For ($k; 1; Size of array:C274($tb_données))
					$tb_donnees_num{$k}:=Num:C11($tb_données{$k})
				End for 
				
				READ WRITE:C146([HeberGement:5])
				
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
				
				APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=False:C215)
				
				USE SET:C118("LockedSet")
				
				If (Records in set:C195("LockedSet")>0)
					$continu:=False:C215
				End if 
				
			End for 
			
			If ($continu)
				VALIDATE TRANSACTION:C240
				ALERT:C41("Fiches d'hébergements vérrouillées. Veuillez réessayer plus tard.")
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
		End if 
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Current user:C182="apaxtel")
			OBJECT SET VISIBLE:C603(*; "btn_annuler_facture"; True:C214)
			OBJECT SET ENABLED:C1123(*; "btn_annuler_facture"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "btn_annuler_facture"; False:C215)
			OBJECT SET ENABLED:C1123(*; "btn_annuler_facture"; False:C215)
		End if 
		
End case 