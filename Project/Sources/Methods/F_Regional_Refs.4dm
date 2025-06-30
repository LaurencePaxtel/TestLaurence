//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Regional_Refs
//{          Vendredi 28 janvier 2011 à 11:45
//{          Modifiée : 4 novembre 2008 à 17:33
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_POINTER:C301($1)  //Pointeur sur le tableau
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)

//•(1) (◊ve_ConsoRegion_Mode=1)  `28/1/2011 : Export pour le régional
$vb_OK:=(<>ve_ConsoRegion_Mode=1)

If ($vb_OK)
	$ii:=Size of array:C274($1->)+1
	
	INSERT IN ARRAY:C227($1->; $ii)
	$1->{$ii}:=$2
End if 