//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableChampsAttributs
//{
//{          Vendredi 17 Aôut 2001 à 15:53
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($vl_STR)

Case of 
	: ($1=0)
		ARRAY TEXT:C222(<>ta_RdsNom; $2; $3)
		ARRAY TEXT:C222(<>ta_RdsNomNew; $2; $3)
		ARRAY TEXT:C222(<>ta_RdsAlert; $2; $3)
		
		ARRAY INTEGER:C220(<>te_RdsTri; $2; $3)
		ARRAY INTEGER:C220(<>te_RdsFic; $2; $3)
		ARRAY INTEGER:C220(<>te_RdsRub; $2; $3)
		ARRAY INTEGER:C220(<>te_RdsOrdre; $2; $3)
		
		ARRAY LONGINT:C221(<>tl_RdsSTR; $2; $3)
		
		ARRAY BOOLEAN:C223(<>tb_RdsSais; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsObli; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsVis; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsPopVis; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsTrans; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsMod; $2; $3)
		ARRAY BOOLEAN:C223(<>tb_RdsDev; $2; $3)
	: ($1=1)
		
		// 16/02/2017 Nouvelle syntaxe avec * pour meilleure lisibilité
		SELECTION TO ARRAY:C260([LesRubriques:21]RubNoSTR:12; <>tl_RdsSTR{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]NuméroTri:1; <>te_RdsTri{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubNom:2; <>ta_RdsNom{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubNomNew:13; <>ta_RdsNomNew{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubFichier:3; <>te_RdsFic{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubNuméro:4; <>te_RdsRub{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubSaississable:5; <>tb_RdsSais{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubObligatoire:6; <>tb_RdsObli{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubVisible:8; <>tb_RdsVis{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubPopVisible:9; <>tb_RdsPopVis{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubModifiable:10; <>tb_RdsMod{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubDéveloppeur:11; <>tb_RdsDev{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubAlerte:7; <>ta_RdsAlert{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubOrdreSaisie:14; <>te_RdsOrdre{$2}; *)
		SELECTION TO ARRAY:C260([LesRubriques:21]RubTrans:15; <>tb_RdsTrans{$2})
		
		SORT ARRAY:C229(<>te_RdsTri{$2}; \
			<>tl_RdsSTR{$2}; \
			<>ta_RdsNom{$2}; \
			<>ta_RdsNomNew{$2}; \
			<>te_RdsFic{$2}; \
			<>te_RdsRub{$2}; \
			<>tb_RdsSais{$2}; \
			<>tb_RdsObli{$2}; \
			<>tb_RdsVis{$2}; \
			<>tb_RdsPopVis{$2}; \
			<>tb_RdsMod{$2}; \
			<>tb_RdsDev{$2}; \
			<>ta_RdsAlert{$2}; \
			<>te_RdsOrdre{$2}; \
			<>tb_RdsTrans{$2}; >)
	: ($1=2)
		COPY ARRAY:C226(<>ta_RdsNomNew{$2}; <>ta_RubNomNew)
		
		// _o_ARRAY TO STRING LIST(<>ta_RubNomNew;$3)
		
		// #BS Migration v15 30/05/16
		// Remplacement de la commande obsolète
		// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF
		
		// Modifié par : Scanu Rémy (25/01/2023)
		//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; $3)
		outilsCreateXliffFile($3; -><>ta_RubNomNew)
		
		//====================================================//
		// Modified by: Kevin HASSAL (12/10/2020)
		// Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
		//====================================================//
		$vl_STR:=$3
		$vl_STR:=($vl_STR*1000)+<>ID_Societe_Active
		
		// Modifié par : Scanu Rémy (25/01/2023)
		//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; $vl_STR)
		outilsCreateXliffFile($vl_STR; -><>ta_RubNomNew)
End case 