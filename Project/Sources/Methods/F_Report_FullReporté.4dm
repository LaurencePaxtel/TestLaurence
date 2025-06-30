//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullReporté
//{
//{          Mardi 4 novembre 2008 à 17:33
//{          Modifiée : 4 novembre 2008 à 17:33
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  //Pointeur sur le tableau
C_LONGINT:C283($2)  //vb_Serveur : Serveur ou sur le poste

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)

//•(1) Est ce une base CHRS  et y a til des fiches reportées
$vb_OK:=<>vb_T_ModeCHRS & <>vb_T_FullDuplex

If ($vb_OK)
	$ii:=Size of array:C274($1->)+1
	
	INSERT IN ARRAY:C227($1->; $ii)
	$1->{$ii}:=$2
End if 