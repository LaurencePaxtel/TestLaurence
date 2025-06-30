//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure P_NotesHeure
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
$Pos1:=0
$Pos2:=0
GET HIGHLIGHT:C209($1->; $Pos1; $Pos2)

$1->:=Insert string:C231($1->; String:C10(Current time:C178)+" - "; $Pos1)
$Pos2:=$Pos1+12

HIGHLIGHT TEXT:C210($1->; $Pos2; $Pos2)