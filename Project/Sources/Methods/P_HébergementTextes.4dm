//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementTextes
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
If ($2->=0)
	$2->:=New process:C317("Go_HébergementTextes"; 0; "Notes"; $1; $2; $3; $4)
Else 
	SHOW PROCESS:C325($2->)
	BRING TO FRONT:C326($2->)
End if 