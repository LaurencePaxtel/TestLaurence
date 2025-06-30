//%attributes = {}
If (User in group:C338(Current user:C182; <>Groupe_DosInfirmier) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	Process_Go(-><>PR_Doi; "Go_DossierInfirmier"; "Dossier infirmier"; 128)
Else 
	StrAlerte(6; "Dossier infirmier")
End if 