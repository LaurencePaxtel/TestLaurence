//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:27:15
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_E_D_S
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatSpécifique) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Etude Dossier social
	Process_Go(-><>PR_StatEDS; "Go_StatDosSocEtude"; "StatDoSEtude"; 0)  // Go_StatMaraude
Else 
	StrAlerte(6; "'Statistique'")
End if 