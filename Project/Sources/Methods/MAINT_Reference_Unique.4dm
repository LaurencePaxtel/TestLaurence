//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19/11/19, 16:57:46
// ----------------------------------------------------
// Method: MAINT_Reference_Unique
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($uid; $ref_unique)
C_BOOLEAN:C305($continu)

$continu:=False:C215

READ ONLY:C145([ReferenceUnique:2])
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1))
ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Numero:3; <)
$uid:=[ReferenceUnique:2]ID:5

READ WRITE:C146([ReferenceUnique:2])
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1); *)
QUERY:C277([ReferenceUnique:2];  & ; [ReferenceUnique:2]ID:5#$uid)

DELETE SELECTION:C66([ReferenceUnique:2])

Case of 
	: ($1=->[HeberGement:5])
		ALL RECORDS:C47([HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1; <)
		$ref_unique:=[HeberGement:5]HG_ReferenceID:1
		$continu:=True:C214
End case 

If ($continu)
	
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1); *)
	QUERY:C277([ReferenceUnique:2];  & ; [ReferenceUnique:2]ID:5=$uid)
	
	If ([ReferenceUnique:2]RU_Numero:3<$ref_unique)
		[ReferenceUnique:2]RU_Numero:3:=$ref_unique
		SAVE RECORD:C53([ReferenceUnique:2])
	End if 
	
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	
End if 