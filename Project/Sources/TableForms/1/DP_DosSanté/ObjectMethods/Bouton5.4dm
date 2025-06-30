If (User in group:C338(Current user:C182; <>Groupe_Messagerie) | User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
	Process_Go3(-><>PR_MessagerieSté; "Go_Messagerie"; <>Va_MessagerieSté; 64; <>Va_MessagerieSté)
Else 
	StrAlerte(6; "Transmission santé")
End if 
