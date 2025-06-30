//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:29:07
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_EMA
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatDASS) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// EMA
	Process_Go(-><>PR_StatEMA; "Go_StatEMA"; "StatEMA"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 