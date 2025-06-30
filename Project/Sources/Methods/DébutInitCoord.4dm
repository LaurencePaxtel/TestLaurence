//%attributes = {}
C_LONGINT:C283($1)

//C_TEXT($vt_Dummy)
Case of 
	: ($1=0)
		<>va_HG_Coordinateur:=""
		<>va_HG_Régulateur:=""
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-25)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			
			C_LONGINT:C283($ii)  // 26/2/18
			$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
			If ($ii>0)
				If ($ii=1)
					<>va_HG_Régulateur:=Substring:C12([DePart:1]DP_Texte:7; Position:C15(";"; [DePart:1]DP_Texte:7)+1)
				Else 
					<>va_HG_Coordinateur:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15(";"; [DePart:1]DP_Texte:7)-1)
					<>va_HG_Régulateur:=Substring:C12([DePart:1]DP_Texte:7; Position:C15(";"; [DePart:1]DP_Texte:7)+1)
				End if 
			Else 
				<>va_HG_Coordinateur:=[DePart:1]DP_Texte:7
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-25
			[DePart:1]DP_Libelle:6:="Coordinateur et régulateur par défaut pour LOFT"
			[DePart:1]DP_Texte:7:=<>va_HG_Coordinateur+";"+<>va_HG_Régulateur
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-25)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=<>va_HG_Coordinateur+";"+<>va_HG_Régulateur
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 