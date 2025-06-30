//%attributes = {}
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		<>va_HG_SignalF1:=""
		<>va_HG_SignalF2:=""
		<>va_HG_SignalF3:=""
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-27)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Les trois libellés de Signalement par défaut")
			Else 
				[DePart:1]DP_Libelle:6:="Les trois libellés de Signalement par défaut"
				SAVE RECORD:C53([DePart:1])
			End if 
			$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
			If ($ii>0)
				<>va_HG_SignalF1:=Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)
				[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
				$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
				If ($ii>0)
					<>va_HG_SignalF2:=Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)
					<>va_HG_SignalF3:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
				Else 
					<>va_HG_SignalF2:=[DePart:1]DP_Texte:7
				End if 
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-27
			[DePart:1]DP_Libelle:6:="Les trois libellés de Signalement par défaut"
			[DePart:1]DP_Texte:7:=<>va_HG_SignalF1+";"+<>va_HG_SignalF2+";"+<>va_HG_SignalF3
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-27)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=<>va_HG_SignalF1+";"+<>va_HG_SignalF2+";"+<>va_HG_SignalF3
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 