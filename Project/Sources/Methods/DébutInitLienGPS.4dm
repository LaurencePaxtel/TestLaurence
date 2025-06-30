//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitASol  
//{          Vendredi 21 mai 2004 à 9:29:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-55)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Valeurs par défaut du lien GPS")
			Else 
				[DePart:1]DP_Libelle:6:="Valeurs par défaut du lien GPS"
				SAVE RECORD:C53([DePart:1])
			End if 
			If (Length:C16([DePart:1]DP_Texte:7)>0)
				<>vt_LienGPS:=[DePart:1]DP_Texte:7
			Else 
				<>vt_LienGPS:=""
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-55
			[DePart:1]DP_Libelle:6:="Valeurs par défaut du lien GPS"
			[DePart:1]DP_Texte:7:=<>vt_LienGPS
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-55)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=<>vt_LienGPS
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 