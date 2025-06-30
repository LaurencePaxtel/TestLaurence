//%attributes = {}
C_LONGINT:C283($1)
C_TEXT:C284($va_DP_Texte; $va_Version)
If ($1=0)
	//Procédure : DebutDecDépart
	READ ONLY:C145([DePart:1])
	QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])=1)
		
	Else 
		READ WRITE:C146([DePart:1])
		CREATE RECORD:C68([DePart:1])
		MultiSoc_Init_Structure(->[DePart:1])
		[DePart:1]DP_Libelle:6:="Fiche message"
		[DePart:1]DP_ReferenceID:1:=-1
		[DePart:1]DP_Texte:7:=""
		
		SAVE RECORD:C53([DePart:1])
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	End if 
	//P_GénéralShow 
	//◊PR_HBTexteF:=0
End if 


If ($1=1)
	READ ONLY:C145([DePart:1])
	QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])=1)
		If (([DePart:1]DP_Texte:7>"") & (Length:C16([DePart:1]DP_Texte:7)=5))
			$va_DP_Texte:=[DePart:1]DP_Texte:7[[1]]+","+[DePart:1]DP_Texte:7[[3]]+[DePart:1]DP_Texte:7[[5]]
		Else 
			$va_DP_Texte:="0"
		End if 
		If ((<>va_Version>"") & (Length:C16(<>va_Version)=5))
			$va_Version:=<>va_Version[[1]]+","+<>va_Version[[3]]+<>va_Version[[5]]
		Else 
			$va_Version:="0"
		End if 
		
		
		Case of 
			: (Num:C11($va_DP_Texte)=Num:C11($va_Version))
				
			: (Num:C11($va_DP_Texte)<Num:C11($va_Version))
				READ WRITE:C146([DePart:1])
				QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
				MultiSoc_Filter(->[DePart:1])
				If (Records in selection:C76([DePart:1])=1)
					Repeat 
						LOAD RECORD:C52([DePart:1])
					Until (Not:C34(Locked:C147([DePart:1])))
					[DePart:1]DP_Texte:7:=<>va_Version
					SAVE RECORD:C53([DePart:1])
					UNLOAD RECORD:C212([DePart:1])
				End if 
				READ ONLY:C145([DePart:1])
				
			: (Num:C11($va_DP_Texte)>Num:C11($va_Version))
				If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
					CONFIRM:C162("Attention - Fichier et programme Non compatibles"+Char:C90(13)+"Voulez-vous mettre à jour le n° de version ?")
					If (OK=1)
						READ WRITE:C146([DePart:1])
						QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
						MultiSoc_Filter(->[DePart:1])
						If (Records in selection:C76([DePart:1])=1)
							Repeat 
								LOAD RECORD:C52([DePart:1])
							Until (Not:C34(Locked:C147([DePart:1])))
							[DePart:1]DP_Texte:7:=<>va_Version
							SAVE RECORD:C53([DePart:1])
							UNLOAD RECORD:C212([DePart:1])
						End if 
						READ ONLY:C145([DePart:1])
						
					End if 
				Else 
					ALERT:C41("Fichier et programme Non compatibles !!!")
					QUIT 4D:C291
				End if 
		End case 
	End if 
End if 


If ($1=-21)
	//Procédure : DebutDecDépart
	QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>1)
		READ WRITE:C146([DePart:1])
		DELETE SELECTION:C66([DePart:1])
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	End if 
End if 