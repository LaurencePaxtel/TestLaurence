//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:35:09
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_S_Mensuelle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision par période mensuelle (typo)
	Process_Go3(-><>PR_Stat_Typologie; "Go_StatTroisTypo"; "Stat3Typo"; 0; "")
Else 
	StrAlerte(6; "'Statistique'")
End if 