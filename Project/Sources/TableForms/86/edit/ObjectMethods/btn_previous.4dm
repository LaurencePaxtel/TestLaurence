// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/03/20, 19:10:47
// ----------------------------------------------------
// Method: [Factures].edit.btn_previous
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If ((selected_row_number>2) & (selected_row_number-1<=Size of array:C274(tb_fac_id)))
			
			selected_row_number:=selected_row_number-1
			
			If (Read only state:C362([Factures:86]))
				READ WRITE:C146([Factures:86])
			End if 
			QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{selected_row_number})
			
			LOAD RECORD:C52([Factures:86])
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
			
			If (AGL_Is_Locked(->[Factures:86]))
				
				OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "btn_annuler"; True:C214)
				OBJECT SET ENABLED:C1123(*; "tab@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_imprimer@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_next@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_previous@"; True:C214)
				
			Else 
				If ([Factures:86]FAC_No_Piece:2="")
					If ([Factures:86]FAC_Adresse_Facturation:14="")
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures:86]FAC_Destinataire_ID:11)
						[Factures:86]FAC_Adresse_Facturation:14:=UTL_Get_Adresse(->[HeBerge:4]ID:65; ->[HeBerge:4])
					End if 
				End if 
			End if 
			
		End if 
		
End case 
