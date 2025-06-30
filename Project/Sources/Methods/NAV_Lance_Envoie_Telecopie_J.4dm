//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 08/07/18, 15:01:43
// ----------------------------------------------------
// Méthode : NAV_Lance_Envoie_Telecopie_J
// Description
// 
//
// Paramètres
// ----------------------------------------------------

If (Accès_Groupe(<>Groupe_FaxJour))
	//◊Vb_Nuit:=Faux
	//0 C'EST LE JOUR
	If (<>PR_Fax=0)
		<>PR_Fax:=New process:C317("Go_HébergementFAX"; 0; "LesFax"; 0)  //updt
	Else 
		Process_Show(<>PR_Fax)
	End if 
End if 
