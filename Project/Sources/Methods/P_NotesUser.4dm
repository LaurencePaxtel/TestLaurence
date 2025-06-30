//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure P_NotesUser
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_LONGINT:C283($Pos1; $Pos2)

GET HIGHLIGHT:C209($1->; $Pos1; $Pos2)

$1->:=Insert string:C231($1->; <>va_User+" - "; $Pos1)
$Pos2:=$Pos1+Length:C16(<>va_User)+3

HIGHLIGHT TEXT:C210($1->; $Pos2; $Pos2)