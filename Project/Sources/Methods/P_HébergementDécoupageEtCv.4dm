//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécoupageEtCv
//{
//{          Mardi 29 Décembre 2009 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $Position)

C_TEXT:C284($vt_Dummy)
Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-64)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Les 'Etat civil' sélectionnés pour la recherche des familles")
			Else 
				[DePart:1]DP_Libelle:6:="Les 'Etat civil' sélectionnés pour la recherche des familles"
				SAVE RECORD:C53([DePart:1])
			End if 
			vt_ii:=[DePart:1]DP_Texte:7
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-64
			[DePart:1]DP_Libelle:6:="Les 'Etat civil' sélectionnés pour la recherche des familles"
			[DePart:1]DP_Texte:7:=""
			vt_ii:=[DePart:1]DP_Texte:7
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-64)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=vt_ii
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=2)
		
		
		If (vt_ii>"")
			
			For ($ii; 1; Size of array:C274(ta_CritEtCiv))
				te_CritEtCiv{$ii}:=0
			End for 
			
			Repeat 
				$vt_Dummy:=""
				$Position:=Position:C15(<>va_CR; vt_ii)
				If ($Position>0)
					$vt_Dummy:=Substring:C12(vt_ii; 1; $Position-1)
					vt_ii:=Substring:C12(vt_ii; $Position+1)
				Else 
					If (vt_ii>"")
						$vt_Dummy:=vt_ii
					End if 
					vt_ii:=""
				End if 
				If ($vt_Dummy>"")
					$ii:=Find in array:C230(<>ta_TBEtCiv; $vt_Dummy)
					If ($ii>0)
						te_CritEtCiv{$ii}:=1
					End if 
				End if 
			Until (vt_ii="")
		End if 
		
End case 