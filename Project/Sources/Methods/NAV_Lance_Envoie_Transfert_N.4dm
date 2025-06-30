//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 08/07/18, 15:04:14
// ----------------------------------------------------
// Méthode : NAV_Lance_Envoie_Transfert_N
// Description
// 
//
// Paramètres
// ----------------------------------------------------
If (Accès_Groupe(<>Groupe_Transfert_N))
	//◊Vb_Nuit:=Vrai
	//1 C'EST LA NUIT
	If (<>PR_TransFax=0)
		<>PR_TransFax:=New process:C317("Go_HébergementTrans"; 0; "LesTrans"; 1)  //updt
	Else 
		Process_Show(<>PR_TransFax)
	End if 
End if 