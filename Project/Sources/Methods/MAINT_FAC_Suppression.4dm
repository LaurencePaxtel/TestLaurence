//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 08/03/20, 20:18:59
// ----------------------------------------------------
// Method: MAINT_FAC_Suppression
// Description
// 
//
// Parameters
// ----------------------------------------------------

CONFIRM:C162("Attention, vous êtes entrain de supprimer toutes les factures (définitives et provisoires). Voulez-vous continuer ?"; "Oui"; "Non")

If (OK=1)
	
	C_LONGINT:C283($i)
	C_BOOLEAN:C305($continu)
	C_TEXT:C284($msg)
	
	$continu:=True:C214
	$msg:=""
	
	START TRANSACTION:C239
	
	READ ONLY:C145([Factures:86])
	QUERY:C277([Factures:86]; [Factures:86]Ref_Structure:19=<>ref_soc_active)
	
	ARRAY LONGINT:C221($tb_ids; 0)
	SELECTION TO ARRAY:C260([Factures:86]ID:1; $tb_ids)
	
	READ WRITE:C146([Factures:86])
	READ WRITE:C146([Factures_Lignes:87])
	READ WRITE:C146([HeberGement:5])
	READ WRITE:C146([Numerotation:88])
	
	For ($i; 1; Size of array:C274($tb_ids))
		
		QUERY:C277([Factures:86]; [Factures:86]ID:1=$tb_ids{$i})
		
		If (Records in selection:C76([Factures:86])=1)
			
			If (Not:C34(Locked:C147([Factures:86])))
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
				MultiSoc_Filter(->[Factures_Lignes:87])
				
				While (Not:C34(End selection:C36([Factures_Lignes:87])))
					
					ARRAY TEXT:C222($tb_données; 0)
					UTL_Cut_Text(->[Factures_Lignes:87]FACL_Service_Ids:30; ->$tb_données; ";")
					ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
					
					For ($j; 1; Size of array:C274($tb_données))
						$tb_donnees_num{$j}:=Num:C11($tb_données{$j})
					End for 
					
					READ WRITE:C146([HeberGement:5])
					
					QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
					
					APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=False:C215)
					
					USE SET:C118("LockedSet")
					
					If (Records in set:C195("LockedSet")>0)
						$continu:=False:C215
					End if 
					
					NEXT RECORD:C51([Factures_Lignes:87])
				End while 
				
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
				MultiSoc_Filter(->[Factures_Lignes:87])
				
				DELETE RECORD:C58([Factures:86])
				DELETE SELECTION:C66([Factures_Lignes:87])
				
			Else 
				$continu:=False:C215
				$msg:="Enregistrements verrouillés, veuillez réssayer plus tard."
			End if 
			
		Else 
			$continu:=False:C215
		End if 
		
		
	End for 
	
	If ($continu)
		
		//QUERY([Numerotation];[Numerotation]Ref_Structure=<>ref_soc_active;*)
		//QUERY([Numerotation]; & ;[Numerotation]NUM_Table_No=Table(->[Factures]))
		
		//DELETE SELECTION([Numerotation])
		
		VALIDATE TRANSACTION:C240
		ALERT:C41("Opération effectuée avec succès")
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41($msg)
	End if 
	
End if 
