//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:25:28
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Coo_Centre
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatCoorS) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Coordinateur Centre
	Process_Go(-><>PR_StatC3; "Go_StatCoordinateurC"; "StatC32"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 