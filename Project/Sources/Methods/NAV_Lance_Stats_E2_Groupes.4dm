//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:30:39
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Groupes
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatGroupe) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Groupe
	Process_Go(-><>PR_StatGrp; "Go_StatGroupe"; "StatGrp"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 