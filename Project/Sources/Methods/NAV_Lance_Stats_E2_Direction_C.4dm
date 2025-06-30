//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:26:50
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Direction_C
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatDirection) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Direction centre
	Process_Go(-><>PR_StatD2; "Go_StatDirection2"; "StatD2"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 