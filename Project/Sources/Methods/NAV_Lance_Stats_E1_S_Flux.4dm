//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:20:12
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_S_Flux
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision des flux
	Process_Go3(-><>PR_Stat_Flux; "Go_StatFlux"; "StatCFlux"; 0; "Anonyme")
End if 