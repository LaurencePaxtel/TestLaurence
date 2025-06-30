//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:19:44
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_S_DPC
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Supervision durée de prise en charge
	Process_Go3(-><>PR_Stat_TrancheContinue; "Go_StatTrancheContinue"; "StatCTranche"; 0; "Anonyme")
End if 