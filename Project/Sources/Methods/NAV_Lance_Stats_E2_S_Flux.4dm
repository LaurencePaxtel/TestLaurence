//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:33:33
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_S_Flux
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision des flux
	Process_Go3(-><>PR_Stat_Flux; "Go_StatFlux"; "StatCFlux"; 0; "")
Else 
	StrAlerte(6; "'Statistique'")
End if 