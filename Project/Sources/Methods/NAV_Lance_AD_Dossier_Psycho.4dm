//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_DosPsycho) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	Process_Go(-><>PR_DoP; "Go_DossierPsycho"; "Dossier psycho"; 128)
Else 
	StrAlerte(6; "Dossier psycho")
End if 