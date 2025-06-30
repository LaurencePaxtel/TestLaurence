//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27-12-18, 15:55:14
// ----------------------------------------------------
// Method: Web_Piece_Lignes_Valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $table)
C_LONGINT:C283($2; $id)

$table:=$1
$id:=$2

Case of 
	: ($table=->[Factures:86])
		
		READ WRITE:C146([Factures_Lignes:87])
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$id)
		APPLY TO SELECTION:C70([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Statut:17:="")
		
	Else 
		
End case 