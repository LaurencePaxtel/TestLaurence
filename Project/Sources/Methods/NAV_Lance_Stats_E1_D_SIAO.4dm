//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:18:50
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_D_SIAO
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Dossier SIAO
	Process_Go(-><>PR_SIAOStats; "Go_SIAOStats"; "SIAO"; 0)
End if 