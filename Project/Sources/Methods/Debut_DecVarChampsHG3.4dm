//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG3
//{
//{          Jeudi 6 mai 2004 à 14:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement

C_LONGINT:C283($1)

READ WRITE:C146([LesRubriques:21])
For ($ii; 1; 9)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii+88
	[LesRubriques:21]RubOrdreSaisie:14:=$ii+88
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="ER_Excuse"
			[LesRubriques:21]RubNomNew:13:="Excusé"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_Excuse:124)
			[LesRubriques:21]RubAlerte:7:=""
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="ER_DateDébut"
			[LesRubriques:21]RubNomNew:13:="Excusé Du"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_DateDébut:125)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de début  est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="ER_DateFin"
			[LesRubriques:21]RubNomNew:13:="Excusé Au"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_DateFin:126)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de fin  est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="ER_NuitEnCours"
			[LesRubriques:21]RubNomNew:13:="Excusé nuit en cours"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_NuitEnCours:127)
			[LesRubriques:21]RubAlerte:7:="La saisie du no de nuit en cours est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="ER_NuitTotal"
			[LesRubriques:21]RubNomNew:13:="Excusé Total des nuits"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_NuitTotal:128)
			[LesRubriques:21]RubAlerte:7:="La saisie du nombre total de nuits est obligatoire !"
			
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="ER_NuitReste"
			[LesRubriques:21]RubNomNew:13:="Excusé Nuits restantes"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_NuitReste:129)
			[LesRubriques:21]RubAlerte:7:="La saisie du nombre total de nuits restantes est obligatoire !"
			
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="ER_Remplaçant"
			[LesRubriques:21]RubNomNew:13:="Remplaçant"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_Remplaçant:130)
			[LesRubriques:21]RubAlerte:7:=""
			
			
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="ER_RemplaceQuiRéf"
			[LesRubriques:21]RubNomNew:13:="Référence"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_RemplaceQuiRéf:131)
			[LesRubriques:21]RubAlerte:7:=""
			
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="ER_RemplaceQui"
			[LesRubriques:21]RubNomNew:13:="Clé"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_ER_RemplaceQui:132)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de la personne excusée est obligatoire !"
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