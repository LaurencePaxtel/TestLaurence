//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy - remy@connect-io.fr
// Date et heure : 05/08/22, 14:09:11
// ----------------------------------------------------
// Méthode : NAV_Lance_Hebergement_JourNuit
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (<>PR_Hébergement=0)
	<>PR_Hébergement:=New process:C317("Go_Hébergement"; 0; "FicheSignal"; "JN"; "")  // BS 200516 64*1024
Else 
	Process_Show(<>PR_Hébergement)
End if 