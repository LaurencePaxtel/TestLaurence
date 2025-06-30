//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=$1)
MultiSoc_Filter(->[ReferenceUnique:2])
$ii:=Records in selection:C76([ReferenceUnique:2])
Case of 
	: ($ii=0)
		
		READ WRITE:C146([ReferenceUnique:2])
		CREATE RECORD:C68([ReferenceUnique:2])
		MultiSoc_Init_Structure(->[ReferenceUnique:2])
		[ReferenceUnique:2]RU_ReferenceID:1:=0
		[ReferenceUnique:2]RU_Fichier:2:=$1
		[ReferenceUnique:2]RU_Numero:3:=$2+1
		[ReferenceUnique:2]RU_ValeurApha:4:=""
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
		READ ONLY:C145([ReferenceUnique:2])
		
	: ($ii=1)
		
		READ WRITE:C146([ReferenceUnique:2])
		Repeat 
			LOAD RECORD:C52([ReferenceUnique:2])
		Until (Not:C34(Locked:C147([ReferenceUnique:2])))
		[ReferenceUnique:2]RU_Numero:3:=$2+1
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
		READ ONLY:C145([ReferenceUnique:2])
		
	: ($ii>1)
		
		READ WRITE:C146([ReferenceUnique:2])
		DELETE SELECTION:C66([ReferenceUnique:2])
		CREATE RECORD:C68([ReferenceUnique:2])
		MultiSoc_Init_Structure(->[ReferenceUnique:2])
		[ReferenceUnique:2]RU_ReferenceID:1:=0
		[ReferenceUnique:2]RU_Fichier:2:=$1
		[ReferenceUnique:2]RU_Numero:3:=$2+1
		[ReferenceUnique:2]RU_ValeurApha:4:=""
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
		READ ONLY:C145([ReferenceUnique:2])
		
End case 