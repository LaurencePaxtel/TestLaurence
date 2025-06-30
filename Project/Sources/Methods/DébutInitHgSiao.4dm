//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : DébutInitHgSiao
//{          Vendredi 6 janvier 2012 à 13:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_TEXT:C284($vt_Dummy)
Case of 
	: ($1=0)
		<>va_HG_SIAODossier:=""
		<>va_HG_SIAOPrescripteur:=""
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-25)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			$ii:=Position:C15(";"; $vt_Dummy)
			If ($ii>0)
				<>va_HG_SIAODossier:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; [DePart:1]DP_Texte:7)+1)
				$ii:=Position:C15(";"; $vt_Dummy)
				If ($ii>0)
					<>va_HG_SIAOPrescripteur:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
				End if 
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-25
			[DePart:1]DP_Libelle:6:="Données SIAO par défaut dans la fiche d'hébergement"
			[DePart:1]DP_Texte:7:=<>va_HG_SIAODossier+";"+<>va_HG_SIAOPrescripteur+";"
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
			[DePart:1]DP_Texte:7:=<>va_HG_SIAODossier+";"+<>va_HG_SIAOPrescripteur+";"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 