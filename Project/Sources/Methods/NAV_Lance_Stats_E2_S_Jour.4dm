//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:34:06
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_S_Jour
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision journalière
	Process_Go3(-><>PR_Stat_TroisFoisRien; "Go_StatTroisFoisRien"; "Stat3Rien"; 0; "")
Else 
	StrAlerte(6; "'Statistique'")
End if 