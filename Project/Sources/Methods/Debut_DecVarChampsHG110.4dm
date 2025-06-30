//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG110
//{
//{          Modifiée : 29 septembre 2009 à 11:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
C_LONGINT:C283($1)

C_LONGINT:C283($ii)


READ WRITE:C146([LesRubriques:21])
For ($ii; 110; 116)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii
	[LesRubriques:21]RubOrdreSaisie:14:=$ii
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	
	[LesRubriques:21]RubNoSTR:12:=$1
	
	[LesRubriques:21]RubSaississable:5:=False:C215
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=False:C215
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=False:C215
	[LesRubriques:21]RubDéveloppeur:11:=True:C214
	
	Case of 
			
		: ($ii=110)
			[LesRubriques:21]RubNom:2:="DateCréationFiche"
			[LesRubriques:21]RubNomNew:13:="Date de création de la fiche"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
			
		: ($ii=111)
			[LesRubriques:21]RubNom:2:="CléCodée_Etat"
			[LesRubriques:21]RubNomNew:13:="La clé est elle codée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
			
		: ($ii=112)
			[LesRubriques:21]RubNom:2:="CléCodée"
			[LesRubriques:21]RubNomNew:13:="Clé cachée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
			
		: ($ii=113)
			[LesRubriques:21]RubNom:2:="ModifDateHeures"
			[LesRubriques:21]RubNomNew:13:="Date de modification"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ModifDateHeures:152)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
		: ($ii=114)
			[LesRubriques:21]RubNom:2:="RegionalDateHeure"
			[LesRubriques:21]RubNomNew:13:="Condolidation régionale"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_RegionalDateHeure:153)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
		: ($ii=115)
			[LesRubriques:21]RubNom:2:="Regional_Departement"
			[LesRubriques:21]RubNomNew:13:="Departement du 115 d'origine"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Regional_Departement:154)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
		: ($ii=116)
			[LesRubriques:21]RubNom:2:="TransCentreID"
			[LesRubriques:21]RubNomNew:13:="Centre pendant transfert"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_TransCentreID:155)
			[LesRubriques:21]RubAlerte:7:="Champ réservé"
			
	End case 
	
	
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])
