//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
Else 
	StrAlerte(6; "")
End if 