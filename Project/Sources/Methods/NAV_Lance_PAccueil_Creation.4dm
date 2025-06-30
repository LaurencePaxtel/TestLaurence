//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_DosSocial) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	Process_Go(-><>PR_DoS; "Go_DossierSocial"; "Dossier social"; 128)
Else 
	StrAlerte(6; "Dossier social")
End if 


