//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_OccupationTab
//{
//{          Jeudi 4 décembre 2008 à 12:12
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		
		
		$ii:=0
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreLiés; $ii)
		ARRAY TEXT:C222(<>tl_Occ_EtatCivil; $ii)
		
		$ii:=0
		ARRAY LONGINT:C221(<>tl_Occ_CentreRéférence; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreRéfPère; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentreCode; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentreRepertoire; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentrePlateforme; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentreNom; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentreNomPère; $ii)
		ARRAY INTEGER:C220(<>te_Occ_CentreNbFils; $ii)
		ARRAY BOOLEAN:C223(<>tb_Occ_CentreEtat; $ii)
		
		ARRAY INTEGER:C220(<>tl_Occ_CentreCapacité; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtilisé; $ii)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséH; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséF; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséM; $ii)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreReste; $ii)
		ARRAY REAL:C219(<>tr_Occ_CentreTaux; $ii)
		
		
	: ($1=1)
		$ii:=Size of array:C274(<>tl_Occ_CentreRéférence)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreRéfPère; $ii)
		ARRAY TEXT:C222(<>ta_Occ_CentreNomPère; $ii)
		ARRAY INTEGER:C220(<>te_Occ_CentreNbFils; $ii)
		ARRAY BOOLEAN:C223(<>tb_Occ_CentreEtat; $ii)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtilisé; $ii)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséH; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséF; $ii)
		ARRAY LONGINT:C221(<>tl_Occ_CentreUtiliséM; $ii)
		
		ARRAY LONGINT:C221(<>tl_Occ_CentreReste; $ii)
		ARRAY REAL:C219(<>tr_Occ_CentreTaux; $ii)
		
	: ($1=2)
		$ii:=Size of array:C274(<>tl_Occ_CentreRéférence)+1
		INSERT IN ARRAY:C227(<>tl_Occ_CentreRéférence; $ii)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreRéfPère; $ii)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreCode; $ii)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreRepertoire; $ii)
		INSERT IN ARRAY:C227(<>ta_Occ_CentrePlateforme; $ii)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreNom; $ii)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreNomPère; $ii)
		INSERT IN ARRAY:C227(<>te_Occ_CentreNbFils; $ii)
		INSERT IN ARRAY:C227(<>tb_Occ_CentreEtat; $ii)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreCapacité; $ii)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtilisé; $ii)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséH; $ii)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséF; $ii)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséM; $ii)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreReste; $ii)
		INSERT IN ARRAY:C227(<>tr_Occ_CentreTaux; $ii)
		
		
	: ($1=3)
		$ii:=<>tl_Occ_CentreRéférence
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreRéférence; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreRéfPère; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_Occ_CentreCode; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_Occ_CentreRepertoire; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_Occ_CentrePlateforme; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_Occ_CentreNom; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_Occ_CentreNomPère; $ii; 1)
		DELETE FROM ARRAY:C228(<>te_Occ_CentreNbFils; $ii; 1)
		DELETE FROM ARRAY:C228(<>tb_Occ_CentreEtat; $ii; 1)
		
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreCapacité; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreUtilisé; $ii; 1)
		
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreUtiliséH; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreUtiliséF; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreUtiliséM; $ii; 1)
		
		DELETE FROM ARRAY:C228(<>tl_Occ_CentreReste; $ii; 1)
		DELETE FROM ARRAY:C228(<>tr_Occ_CentreTaux; $ii; 1)
		
		
	: ($1=4)
		$ii:=<>ta_Occ_CentreNom
		INSERT IN ARRAY:C227(<>tl_Occ_CentreRéférence; $ii; 1)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreRéfPère; $ii; 1)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreCode; $ii; 1)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreRepertoire; $ii; 1)
		INSERT IN ARRAY:C227(<>ta_Occ_CentrePlateforme; $ii; 1)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreNom; $ii; 1)
		INSERT IN ARRAY:C227(<>ta_Occ_CentreNomPère; $ii; 1)
		INSERT IN ARRAY:C227(<>te_Occ_CentreNbFils; $ii; 1)
		INSERT IN ARRAY:C227(<>tb_Occ_CentreEtat; $ii; 1)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreCapacité; $ii; 1)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtilisé; $ii; 1)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséH; $ii; 1)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséF; $ii; 1)
		INSERT IN ARRAY:C227(<>tl_Occ_CentreUtiliséM; $ii; 1)
		
		INSERT IN ARRAY:C227(<>tl_Occ_CentreReste; $ii; 1)
		INSERT IN ARRAY:C227(<>tr_Occ_CentreTaux; $ii; 1)
		
End case 