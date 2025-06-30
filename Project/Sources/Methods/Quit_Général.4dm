//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : Quit_Général
//{          Lundi 10 mai 2010 à 15:46:00
//{          Lundi 16 juillet 2012 à 11:07:00
//{          Développement : GABBAY Jean-Guy
//{==================================================} 

CONFIRM:C162("Vous allez quitter l'application !"+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	//$vb_Quitter:=True  // #OPT20170522-1
	QUIT 4D:C291
End if 
