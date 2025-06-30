//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:43:04
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Sejour
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatSpécifique) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Séjour
	Process_Go(-><>PR_StatSejour; "Go_StatSejour"; "StatSejour"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 