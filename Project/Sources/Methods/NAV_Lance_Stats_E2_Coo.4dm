//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:25:06
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Coo
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatCoor) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Coordinateur
	Process_Go(-><>PR_StatC; "Go_StatCoordinateur"; "StatC"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 