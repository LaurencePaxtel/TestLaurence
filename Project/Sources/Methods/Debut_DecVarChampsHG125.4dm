//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Debut_DecVarChampsHG124
//{          Mardi 13 décembre 2011 à 10:40
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
C_LONGINT:C283($1)

C_LONGINT:C283($ii)


READ WRITE:C146([LesRubriques:21])
For ($ii; 126; 128)
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
		: ($ii=126)
			[LesRubriques:21]RubNom:2:="HG_Type_Demande"
			[LesRubriques:21]RubNomNew:13:="Type de demande"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_Demande:165)
			[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de demande est obligatoire !"
		: ($ii=127)
			[LesRubriques:21]RubNom:2:="HG_Type_Prescription"
			[LesRubriques:21]RubNomNew:13:="Type de prescripteur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_Prescripteur:166)
			[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de prescripteur est obligatoire !"
			
		: ($ii=128)
			[LesRubriques:21]RubNom:2:="HG_Type_de_Place"
			[LesRubriques:21]RubNomNew:13:="Type de place"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_de_Place:167)
			[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de place est obligatoire !"
			
			
			
	End case 
	
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])
