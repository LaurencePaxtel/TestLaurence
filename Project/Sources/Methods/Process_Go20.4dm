//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Process_Go20  
//{
//{          Lundi 10 Janvier 2011 à 11:27
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_TEXT:C284($6)
C_TEXT:C284($7)

If ($1->=0)
	$1->:=New process:C317($2; 0; $3; $5; $6; $7)
Else 
	Process_Show($1->)
End if 