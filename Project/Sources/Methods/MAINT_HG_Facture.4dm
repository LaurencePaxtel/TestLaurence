//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/03/20, 11:51:55
// ----------------------------------------------------
// Method: MAINT_HG_Facture
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($continu)

$continu:=True:C214

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Facture:172=True:C214)
APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=False:C215)

ALL RECORDS:C47([Factures:86])

While (Not:C34(End selection:C36([Factures:86])))
	
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
		
		APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=True:C214)
		
		USE SET:C118("LockedSet")
		
		If (Records in set:C195("LockedSet")>0)
			$continu:=False:C215
		End if 
		
		NEXT RECORD:C51([Factures_Lignes:87])
	End while 
	
	
	NEXT RECORD:C51([Factures:86])
End while 

If ($continu)
	ALERT:C41("Opération effectuée avec succès")
Else 
	ALERT:C41("erreur")
End if 

