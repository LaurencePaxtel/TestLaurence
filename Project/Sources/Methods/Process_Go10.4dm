//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Go_Process10
//{
//{          Vendredi 10 Janvier 1997 à 12:26:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_TEXT:C284($6)
C_LONGINT:C283($7)
C_LONGINT:C283($8)
C_TEXT:C284($9)


//$4*1024
If ($1->=0)
	$1->:=New process:C317($2; 0; $3; $5; $6; $7; $8; $9)
Else 
	Process_Show($1->)
End if 