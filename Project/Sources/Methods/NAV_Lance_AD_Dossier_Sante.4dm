//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_DosSanté) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	Process_Go(-><>PR_DoE; "Go_DossierSanté"; "Dossier santé"; 0)
Else 
	StrAlerte(6; "Dossier Santé")
End if 