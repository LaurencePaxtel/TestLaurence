//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15-12-18, 23:35:40
// ----------------------------------------------------
// Method: UTL_Adresse_Gere
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_POINTER:C301($id_origine; $id_table_origine)
C_BOOLEAN:C305($create)

$id_origine:=$1
$id_table_origine:=$2

READ WRITE:C146([Adresses:53])

If (Is new record:C668([LesCentres:9]))
	$create:=True:C214
Else 
	QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=$id_origine->; *)
	QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252($id_table_origine))
	
	If (Records in selection:C76([Adresses:53])=0)
		$create:=True:C214
	End if 
	
End if 

If ($create)
	CREATE RECORD:C68([Adresses:53])
	MultiSoc_Init_Structure(->[Adresses:53])
	
	[Adresses:53]AD_ID_Origine:34:=$id_origine->
	[Adresses:53]AD_ID_Table_Origine:35:=Table:C252($id_table_origine)
End if 