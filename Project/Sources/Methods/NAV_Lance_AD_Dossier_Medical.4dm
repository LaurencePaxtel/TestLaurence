//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_DosMédical) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	Process_Go(-><>PR_DoM; "Go_DossierMédical"; "Dossier Médical"; 128)
Else 
	StrAlerte(6; "Dossier Médical")
End if 