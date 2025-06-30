//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG116
//{
//{          Mardi 29 novembre 2011 à 13:40
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
C_LONGINT:C283($1)

C_LONGINT:C283($ii)


READ WRITE:C146([LesRubriques:21])
For ($ii; 117; 124)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii
	[LesRubriques:21]RubOrdreSaisie:14:=$ii
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	
	[LesRubriques:21]RubNoSTR:12:=$1
	
	[LesRubriques:21]RubSaississable:5:=True:C214
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=True:C214
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=True:C214
	[LesRubriques:21]RubDéveloppeur:11:=False:C215
	
	Case of 
		: ($ii=117)
			[LesRubriques:21]RubNom:2:="Flag_CapaciteAcces"
			[LesRubriques:21]RubNomNew:13:="Capacité d'accès"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_CapaciteAcces:158)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag Capacité d'cces est conseillée !"
			
		: ($ii=118)
			[LesRubriques:21]RubNom:2:="Flag_DAHO"
			[LesRubriques:21]RubNomNew:13:="Priorité DAHO"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_DAHO:156)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag DAHO est conseillée !"
			
		: ($ii=119)
			[LesRubriques:21]RubNom:2:="Flag_FemViolence"
			[LesRubriques:21]RubNomNew:13:="Victime de violences"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_FemViolence:157)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag femme violences est conseillée !"
			
		: ($ii=120)
			[LesRubriques:21]RubNom:2:="Flag_LogAutonome"
			[LesRubriques:21]RubNomNew:13:="Logement autonome"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_LogAutonome:159)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag LogAutonome est conseillée !"
			
		: ($ii=121)
			[LesRubriques:21]RubNom:2:="Flag_OrientCorrespondant"
			[LesRubriques:21]RubNomNew:13:="Orientation correspondante"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_OrientCorrespondant:161)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag Orientation correspondante est conseillée !"
			
		: ($ii=122)
			[LesRubriques:21]RubNom:2:="Flag_RefusParStructure"
			[LesRubriques:21]RubNomNew:13:="Refus par la structure"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_RefusParStructure:162)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag Refus par la structure est conseillée !"
			
		: ($ii=123)
			[LesRubriques:21]RubNom:2:="Flag_RefusParDemandeur"
			[LesRubriques:21]RubNomNew:13:="Refus par le demandeur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_RefusParDemandeur:163)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag Refus par le demandeur est conseillée !"
			
		: ($ii=124)
			[LesRubriques:21]RubNom:2:="Flag_Souhait"
			[LesRubriques:21]RubNomNew:13:="Logement souhaité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_Souhait:160)
			[LesRubriques:21]RubAlerte:7:="La saisie du Flag Logement souhaité est conseillée !"
	End case 
	
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])
