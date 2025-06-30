//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:18:19
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_Coo_S
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Coordinateur S
	Process_Go4(-><>PR_StatC2; "Go_StatCoordinateurS"; "StatC2"; 0; "Hébergement journalier")
End if 