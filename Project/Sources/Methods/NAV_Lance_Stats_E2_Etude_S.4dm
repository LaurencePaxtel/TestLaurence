//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:30:13
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E2_Etude_S
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_StatEtude) | User in group:C338(Current user:C182; <>Groupe_Statistiques) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Etude S
	Process_Go(-><>PR_StatE; "Go_StatEtudeS"; "StatEs"; 0)
Else 
	StrAlerte(6; "'Statistique'")
End if 