//%attributes = {}

If (User in group:C338(Current user:C182; <>Groupe_SIAO) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
	
	If (<>PR_SIAOListe=0)
		If (F_CNIL_ChampLibre(<>ve_T_CNILMessage))
			<>PR_SIAOListe:=New process:C317("Go_SIAOListe"; 0; "SIAO liste")
		End if 
	Else 
		Process_Show(<>PR_SIAOListe)
	End if 
Else 
	StrAlerte(6; "")
End if 

