//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:24:01
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Centres
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatDirection) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Centres
	Process_Go(-><>PR_StatCtr; "Go_StatCentre"; "Statctr"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 