//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:26:20
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Direction
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatDirection) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Direction
	Process_Go(-><>PR_StatD; "Go_StatDirection"; "StatD"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 