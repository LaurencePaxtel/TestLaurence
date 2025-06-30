//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_BoolHeureCommuteA
//{
//{          Lundi 19 janvier 2004 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_POINTER:C301($2)
If ($1->=True:C214)
	
	
	$2->:=vd_HeureRéelle
Else 
	$2->:=?00:00:00?
End if 