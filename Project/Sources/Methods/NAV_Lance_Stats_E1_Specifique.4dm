//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:21:39
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_Specifique
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Spécifique
	Process_Go(-><>PR_StatS; "Go_StatSpécific"; "StatS"; 0)
End if 