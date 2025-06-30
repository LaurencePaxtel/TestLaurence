//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_StatType1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)

C_LONGINT:C283($Position)
$Position:=Find in array:C230($3->; $1)
If ($Position>0)
	$4->{$Position}:=$4->{$Position}+1
	If ($2)
		$5->{$Position}:=$5->{$Position}+1
	End if 
End if 