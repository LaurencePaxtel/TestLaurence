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
		<>va_HG_AutreSolStd:=""
		<>va_HG_AutreSolExc:=""
		<>va_HG_AutreSolRemp:=""
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-31)
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Valeurs par défaut autres")
			Else 
				[DePart:1]DP_Libelle:6:="Valeurs par défaut autres"
				SAVE RECORD:C53([DePart:1])
			End if 
			If (Length:C16([DePart:1]DP_Texte:7)>0)
				$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
				If ($ii>0)
					<>va_HG_AutreSolStd:=Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)
					[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
					$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
					<>va_HG_AutreSolExc:=Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)
					<>va_HG_AutreSolRemp:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
				End if 
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-31
			[DePart:1]DP_Libelle:6:="Valeurs par défaut autres"
			[DePart:1]DP_Texte:7:=<>va_HG_AutreSolStd+";"+<>va_HG_AutreSolExc+";"+<>va_HG_AutreSolRemp
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-31)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=<>va_HG_AutreSolStd+";"+<>va_HG_AutreSolExc+";"+<>va_HG_AutreSolRemp
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 