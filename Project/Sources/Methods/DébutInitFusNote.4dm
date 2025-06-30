//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitProLg  
//{          Samedi 18 septembre 2004 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)


Case of 
	: ($1=0)
		<>vb_FusNote_Notes:=False:C215
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-35)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Fusion : fusion des notes")
			Else 
				[DePart:1]DP_Libelle:6:="Fusion : fusion des notes"
				SAVE RECORD:C53([DePart:1])
			End if 
			If (Length:C16([DePart:1]DP_Texte:7)>0)
				<>vb_FusNote_Notes:=([DePart:1]DP_Texte:7[[1]]="1")
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-35
			[DePart:1]DP_Libelle:6:="Fusion : fusion des notes"
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_FusNote_Notes))
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-35)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_FusNote_Notes))
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 
