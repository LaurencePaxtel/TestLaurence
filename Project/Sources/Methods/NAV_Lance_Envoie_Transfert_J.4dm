//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 08/07/18, 15:03:19
// ----------------------------------------------------
// Méthode : NAV_Lance_Envoie_Transfert_J
// Description
// 
//
// Paramètres
// ----------------------------------------------------


If (Accès_Groupe(<>Groupe_Transfert_J))
	//◊Vb_Nuit:=Faux
	//0 C'EST LE JOUR
	If (<>PR_TransFax=0)
		<>PR_TransFax:=New process:C317("Go_HébergementTrans"; 0; "LesTrans"; 0)  //updt
	Else 
		Process_Show(<>PR_TransFax)
	End if 
End if 