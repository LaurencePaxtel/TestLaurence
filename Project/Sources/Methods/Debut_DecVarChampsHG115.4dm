//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG112
//{
//{          Lundi 15 novembre 2010 à 17:40
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
C_LONGINT:C283($1)

C_LONGINT:C283($ii)


READ WRITE:C146([LesRubriques:21])
For ($ii; 116; 116)
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
