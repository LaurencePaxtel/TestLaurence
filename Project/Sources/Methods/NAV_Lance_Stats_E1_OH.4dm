//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:19:20
// ----------------------------------------------------
// Méthode : NAV_Lance_Stats_E1_OH
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (User in group:C338(Current user:C182; <>Groupe_SIAOAnonyme) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	P_Profil
	
	// Occupation hebdomadaire       
	If (<>PR_OccupationWeek=0)
		<>PR_OccupationWeek:=New process:C317("Go_OccupationWeek"; 0; "OccupationWeek"; 0; !00-00-00!; *)
	Else 
		Process_Show(<>PR_OccupationWeek)
	End if 
	
End if 