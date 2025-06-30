//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:27:35
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_E_Maraude
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatSpécifique) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Etude maraude
	Process_Go(-><>PR_StatEM; "Go_StatMaraudeEtude"; "StatMarEtude"; 0)  // Go_StatMaraude
Else 
	StrAlerte(6; "'Statistique'")
End if 