//%attributes = {}
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

READ ONLY:C145([TypesTables:11])

QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=$1->)
MultiSoc_Filter(->[TypesTables:11])

If (Records in selection:C76([TypesTables:11])=1)
	$2->:=String:C10([TypesTables:11]TT_RéférenceID:1; "000")+"/1@"
Else 
	READ WRITE:C146([TypesTables:11])
	
	CREATE RECORD:C68([TypesTables:11])
	MultiSoc_Init_Structure(->[TypesTables:11])
	
	[TypesTables:11]TT_RéférenceID:1:=Uut_Numerote(->[TypesTables:11])
	[TypesTables:11]TT_Libellé:4:=$1->
	[TypesTables:11]TT_NbNiveaux:2:=$3
	
	SAVE RECORD:C53([TypesTables:11])
	
	$2->:=String:C10([TypesTables:11]TT_RéférenceID:1; "000")+"/1@"
	
	UNLOAD RECORD:C212([TypesTables:11])
	READ ONLY:C145([TypesTables:11])
End if 