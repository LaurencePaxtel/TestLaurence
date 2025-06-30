//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Go_Process4 
//{
//{          Vendredi 10 Janvier 1997 à 12:26:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

If ($1->=0)
	$1->:=New process:C317($2; 0; $3; $5)
Else 
	Process_Show($1->)
End if 