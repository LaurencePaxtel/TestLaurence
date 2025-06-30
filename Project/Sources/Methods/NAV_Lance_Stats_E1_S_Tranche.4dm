//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:20:29
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_S_Tranche
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision par tranche
	Process_Go3(-><>PR_Stat_Tranche; "Go_StatTranche"; "Stat3Tranche"; 0; "Anonyme")
End if 