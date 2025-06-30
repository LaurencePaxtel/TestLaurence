//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/03/20, 14:53:23
// ----------------------------------------------------
// Method: MAINT_Factures_Orphelines
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($compteur)
ARRAY LONGINT:C221($tb_ids; 0)

ALL RECORDS:C47([Factures_Lignes:87])

$compteur:=0

While (Not:C34(End selection:C36([Factures_Lignes:87])))
	
	QUERY:C277([Factures:86]; [Factures:86]ID:1=[Factures_Lignes:87]FACL_Piece_ID:3)
	
	If (Records in selection:C76([Factures:86])=0)
		APPEND TO ARRAY:C911($tb_ids; [Factures_Lignes:87]ID:1)
		$compteur:=$compteur+1
	End if 
	
	NEXT RECORD:C51([Factures_Lignes:87])
End while 

READ WRITE:C146([Factures_Lignes:87])

QUERY WITH ARRAY:C644([Factures_Lignes:87]ID:1; $tb_ids)

DELETE SELECTION:C66([Factures_Lignes:87])

ALERT:C41("opération effectuée avec succès : "+String:C10($compteur)+" lignes supprimées.")