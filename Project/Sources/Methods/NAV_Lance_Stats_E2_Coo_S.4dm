//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:25:53
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Coo_S
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatCoorS) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Coordinateur S
	Process_Go4(-><>PR_StatC2; "Go_StatCoordinateurS"; "StatC2"; 0; "Coordinateur S")
Else 
	StrAlerte(6; "'Statistique'")
End if 