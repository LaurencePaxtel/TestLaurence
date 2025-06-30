//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:31:30
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_S_Famille
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Famille avec enfants moins de trois ans
	Process_Go3(-><>PR_Stat_TroisEnfants; "Go_StatTroisEnfants"; "Stat3Child"; 0; "")
Else 
	StrAlerte(6; "'Statistique'")
End if 
