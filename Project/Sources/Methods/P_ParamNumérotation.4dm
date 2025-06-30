//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ParamNumérotation
//{
//{          Mercredi 19 février 20031 à 16:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)
Case of 
	: ($1=-1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$2)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=0)
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=$2
			[DePart:1]DP_Texte:7:=$3->
			[DePart:1]DP_Libelle:6:="Paramètre numérotation"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=0)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$2)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			LOAD RECORD:C52([DePart:1])
			If (Not:C34(Locked:C147([DePart:1])))
				[DePart:1]DP_Texte:7:=$3->
				SAVE RECORD:C53([DePart:1])
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=$2
			[DePart:1]DP_Texte:7:=$3->
			[DePart:1]DP_Libelle:6:="Paramètre numérotation"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ ONLY:C145([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$2)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$3->:=[DePart:1]DP_Texte:7
		End if 
End case 