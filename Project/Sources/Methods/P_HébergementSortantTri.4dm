//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_HébergementSortant
//{
//{          Lundi 17 janvier 2011 à 13:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
vL_NoTri:=$1

Case of 
	: (vL_NoTri=1)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		
	: (vL_NoTri=2)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Plateforme:139; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		
	: (vL_NoTri=3)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_NuitReste:95; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		
	: (vL_NoTri=4)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
End case 


FIRST RECORD:C50([HeberGement:5])