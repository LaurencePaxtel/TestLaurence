//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_StatType2
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1; $2; $3; $4; $5)

$2->:=0
$3->:=0

C_LONGINT:C283($ii)
For ($ii; 1; $1->)
	$2->:=$2->+$4->{$ii}
	$3->:=$3->+$5->{$ii}
End for 