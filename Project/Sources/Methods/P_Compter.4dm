//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Compter
//{
//{          Mardi 10 mai 2005 à 14:13:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_LONGINT:C283($Position)


$Position:=Find in array:C230($2->; $5->)
If ($Position>0)
	$3->{$Position}:=$3->{$Position}+1
	If ($1)
		$4->{$Position}:=$4->{$Position}+1
	End if 
End if 