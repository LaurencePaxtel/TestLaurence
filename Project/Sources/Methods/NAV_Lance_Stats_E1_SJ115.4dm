//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:21:16
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_SJ115
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision journalière 115
	Process_Go3(-><>PR_Stat_TroisFoisRien; "Go_StatTroisFoisRien"; "Stat3Rien"; 0; "Anonyme")
End if 