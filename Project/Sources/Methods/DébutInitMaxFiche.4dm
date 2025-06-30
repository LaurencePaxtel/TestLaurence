//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Début_InitMaxFiche
//{
//{          Jeudi 2 août 2007 à 10:44:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=0)
		
		<>vb_MaxFichesHG:=True:C214
		<>vl_MaxFichesHG_J:=1
		<>vl_MaxFichesHG_N:=100
		<>vl_MaxFichesHG:=<>vl_MaxFichesHG_J+<>vl_MaxFichesHG_N
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-36)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Nombre maximum de fiches d'hébergement")
			Else 
				[DePart:1]DP_Libelle:6:="Nombre maximum de fiches d'hébergement"
				SAVE RECORD:C53([DePart:1])
			End if 
			If (Length:C16([DePart:1]DP_Texte:7)>0)
				$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
				If ($ii>0)
					<>vl_MaxFichesHG_J:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1))
					[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
					$ii:=Position:C15("="; [DePart:1]DP_Texte:7)
					If ($ii>0)
						<>vl_MaxFichesHG_N:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1))
						[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
						<>vb_MaxFichesHG:=([DePart:1]DP_Texte:7="1")
					Else 
						<>vl_MaxFichesHG_N:=Num:C11([DePart:1]DP_Texte:7)
					End if 
					<>vl_MaxFichesHG:=<>vl_MaxFichesHG_J+<>vl_MaxFichesHG_N
				End if 
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-36
			[DePart:1]DP_Libelle:6:="Nombre maximum de fiches d'hébergement"
			[DePart:1]DP_Texte:7:=String:C10(<>vl_MaxFichesHG_J)+";"+String:C10(<>vl_MaxFichesHG_N)+"="+String:C10(Num:C11(<>vb_MaxFichesHG))
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-36)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=String:C10(<>vl_MaxFichesHG_J)+";"+String:C10(<>vl_MaxFichesHG_N)+"="+String:C10(Num:C11(<>vb_MaxFichesHG))
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 