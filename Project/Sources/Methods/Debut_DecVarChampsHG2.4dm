//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG2
//{
//{          Lundi 2 février 2004 à 12:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement

C_LONGINT:C283($1)

READ WRITE:C146([LesRubriques:21])
For ($ii; 1; 5)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii+83
	[LesRubriques:21]RubOrdreSaisie:14:=$ii+83
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Fam Distri1M"
			[LesRubriques:21]RubNomNew:13:="Montant Distribution"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_FamDistri1M:118)
			[LesRubriques:21]RubAlerte:7:="La saisie du montant de la distribution 1  est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Fam  Distri2M"
			[LesRubriques:21]RubNomNew:13:="Montant Distribution 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_FamDistri2M:119)
			[LesRubriques:21]RubAlerte:7:="La saisie du montant de la distribution 2  est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Fam  Distri3M"
			[LesRubriques:21]RubNomNew:13:="Montant Distribution 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_FamDistri3M:120)
			[LesRubriques:21]RubAlerte:7:="La saisie du montant de la distribution 3  est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="Fam  Distri4M"
			[LesRubriques:21]RubNomNew:13:="Montant Distribution 4"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_FamDistri4M:121)
			[LesRubriques:21]RubAlerte:7:="La saisie du montant de la distribution 4  est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Fam  Distri5M"
			[LesRubriques:21]RubNomNew:13:="Montant Distribution 5"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_FamDistri5M:122)
			[LesRubriques:21]RubAlerte:7:="La saisie du montant de la distribution 5  est obligatoire !"
	End case 
	[LesRubriques:21]RubSaississable:5:=True:C214
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=True:C214
	[LesRubriques:21]RubPopVisible:9:=True:C214
	[LesRubriques:21]RubModifiable:10:=True:C214
	[LesRubriques:21]RubDéveloppeur:11:=False:C215
	
	[LesRubriques:21]RubNoSTR:12:=$1
	SAVE RECORD:C53([LesRubriques:21])
	
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])