//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BoutonDépart  
//{          Vendredi 5 novembre 2004 à 16:07:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Oui Non
C_POINTER:C301($2)  //La variable
C_LONGINT:C283($3)  //Couleur avant plan
C_LONGINT:C283($4)  //Couleur arrière plan
C_LONGINT:C283($4)  //Style
If ($1=0)
	//CHOIX COULEUR($2->;($3+(256*$4)))
	//CHANGER STYLE($2->;$5)
	$2->:=""
End if 