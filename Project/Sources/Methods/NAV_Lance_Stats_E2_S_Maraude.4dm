//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:34:34
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_S_Maraude
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatSpécifique) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Spécifique maraude
	Process_Go(-><>PR_StatSM; "Go_StatMaraude"; "StatMarSpé"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 