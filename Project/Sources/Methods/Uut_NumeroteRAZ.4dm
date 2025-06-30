//%attributes = {}
C_POINTER:C301($1)
C_TIME:C306($h)
C_LONGINT:C283($0)
If (Is a variable:C294($1))
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=$1->)
	$FileToCreat:=$1->
Else 
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1))
	$FileToCreat:=Table name:C256($1)
End if 
MultiSoc_Filter(->[ReferenceUnique:2])

If (Records in selection:C76([ReferenceUnique:2])=1)  //Ce n'est pas la première fiche
	READ WRITE:C146([ReferenceUnique:2])
	While (Locked:C147([ReferenceUnique:2]))
		$h:=Current time:C178
		While ($h=Current time:C178)
		End while 
		LOAD RECORD:C52([ReferenceUnique:2])
	End while 
	[ReferenceUnique:2]RU_Numero:3:=1
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	
End if 