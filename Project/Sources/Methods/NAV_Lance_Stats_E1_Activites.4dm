//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:17:11
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_Activites
// Description
// 
//
// Paramètres
// ---------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Activités
	Process_Go(-><>PR_Stat_Activite; "Go_StatActivite"; "StatActivite"; 0)
End if 