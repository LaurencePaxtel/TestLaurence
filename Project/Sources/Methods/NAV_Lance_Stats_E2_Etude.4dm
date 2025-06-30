//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:29:47
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Etude
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatEtude) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Etude
	Process_Go(-><>PR_StatE; "Go_StatEtude"; "StatE"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 