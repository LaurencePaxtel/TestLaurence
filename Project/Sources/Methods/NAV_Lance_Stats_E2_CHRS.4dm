//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:24:30
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_CHRS
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatDASS) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// DDASS
	Process_Go(-><>PR_StatC; "Go_StatDASS"; "StatA"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 