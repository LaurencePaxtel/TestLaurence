//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_BoolHeureCommute
//{
//{          Lundi 05 Janvier 1998 à 14:37:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_POINTER:C301($2)

If ($1->=True:C214)
	$2->:=Current time:C178
Else 
	$2->:=?00:00:00?
End if 