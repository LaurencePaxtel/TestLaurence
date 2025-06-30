//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:22:25
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_TO
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Taux d'occupation
	If (<>PR_Occupation=0)
		<>PR_Occupation:=New process:C317("Go_Occupation"; 0; "Occupation"; *)
	Else 
		Process_Show(<>PR_Occupation)
	End if 
	
End if 