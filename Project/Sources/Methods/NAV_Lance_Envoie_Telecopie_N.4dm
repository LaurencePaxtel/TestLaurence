//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 08/07/18, 15:02:20
// ----------------------------------------------------
// Méthode : NAV_Lance_Envoie_Telecopie_N
// Description
// 
//
// Paramètres
// ----------------------------------------------------

If (Accès_Groupe(<>Groupe_FaxNuit))
	//◊Vb_Nuit:=Vrai
	//1 C'EST LA NUIT
	If (<>PR_Fax=0)
		<>PR_Fax:=New process:C317("Go_HébergementFAX"; 0; "LesFax"; 1)  //updt
	Else 
		Process_Show(<>PR_Fax)
	End if 
End if 