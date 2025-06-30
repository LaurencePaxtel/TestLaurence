//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:20:55
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_SF
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision famille
	Process_Go3(-><>PR_Stat_TroisEnfants; "Go_StatTroisEnfants"; "Stat3Child"; 0; "Anonyme")
End if 