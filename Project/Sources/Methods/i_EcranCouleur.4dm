//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{
//{          Procédure : i_EcranCouleur
//{
//{          Vendredi 9 juillet 1999 à 14:56:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  //◊vl_ProfondeurEcran 
C_POINTER:C301($2)  //◊va_ProfondeurEcran
C_POINTER:C301($3)  //◊vl_CouleurEcran
C_POINTER:C301($4)  //◊va_CouleurEcran

SCREEN DEPTH:C439($1->; $3->)
Case of 
	: ($1->=0)
		$2->:="Noir et blanc"
	: ($1->=2)
		$2->:="4 couleurs"
	: ($1->=4)
		$2->:="16 couleurs"
	: ($1->=8)
		$2->:="256 couleurs"
	: ($1->=16)
		$2->:="Milliers de couleurs"
	: ($1->=24)
		$2->:="Million de couleurs 24 bits"
	: ($1->=32)
		$2->:="Million de couleurs 32 bits"
End case 
Case of 
	: ($3->=0)
		$4->:="Niveaux de gris"
	: ($3->=1)
		$4->:="Couleurs"
End case 
