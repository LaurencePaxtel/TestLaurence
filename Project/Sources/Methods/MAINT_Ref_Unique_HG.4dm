//%attributes = {}


C_LONGINT:C283($uid; $ref_unique)
C_BOOLEAN:C305($continu)

$continu:=False:C215

READ ONLY:C145([ReferenceUnique:2])
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2="HG2001")
ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Numero:3; <)
$uid:=[ReferenceUnique:2]ID:5

READ WRITE:C146([ReferenceUnique:2])
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2="HG2001"; *)
QUERY:C277([ReferenceUnique:2];  & ; [ReferenceUnique:2]ID:5#$uid)

DELETE SELECTION:C66([ReferenceUnique:2])


//ALL RECORDS([HeberGement])
//QUERY([HeberGement];[HeberGement]HG_FicheNuméro="@N2001@")
//ORDER BY([HeberGement];[HeberGement]HG_FicheNuméro;<)

$ref_unique:=9108
$continu:=True:C214


If ($continu)
	
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2="HG2001"; *)
	QUERY:C277([ReferenceUnique:2];  & ; [ReferenceUnique:2]ID:5=$uid)
	
	If ([ReferenceUnique:2]RU_Numero:3<$ref_unique)
		[ReferenceUnique:2]RU_Numero:3:=$ref_unique
		SAVE RECORD:C53([ReferenceUnique:2])
	End if 
	
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	
End if 