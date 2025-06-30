//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 13/06/2020, 18:24:14
// ----------------------------------------------------
// Method: Web_Save_Custom
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_POINTER:C301($table; $json_data)

$table:=$1
$json_data:=$2

Case of 
	: ($table=->[Equipement:107])
		STK_Stock_MAJ([Equipement:107]ID:1; [Equipement:107]ID:1; [Equipement:107]ID:1; "entree"; [Equipement:107]EQU_Quantite_Initiale:14; True:C214; "Quantité initiale"; ""; ""; ->[Equipement:107])
End case 

$0:=True:C214