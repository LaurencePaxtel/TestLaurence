//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : i_TableauInitEntier
//{
//{          Lundi 28 décembre 2009 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($ii; $jj)

Case of 
	: ($1=1)
		$jj:=Size of array:C274($2->)
		ARRAY INTEGER:C220($3->; $jj)
		For ($ii; 1; $jj)
			$3->{$ii}:=1
		End for 
End case 