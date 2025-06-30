//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_SIAO) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
	If (<>PR_SIAO=0)
		
		If (F_CNIL_ChampLibre(<>ve_T_CNILMessage))
			<>PR_SIAO:=New process:C317("Go_SIAO"; 0; "SIAO")
		End if 
		
	Else 
		Process_Show(<>PR_SIAO)
	End if 
	
Else 
	StrAlerte(6; "")
End if 

