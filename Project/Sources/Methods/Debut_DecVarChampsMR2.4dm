//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsMR2
//{
//{          Vendredi 2 juillet 2004 à 14:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Maraude

C_LONGINT:C283($1)

READ WRITE:C146([LesRubriques:21])
For ($ii; 1; 1)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii+73
	[LesRubriques:21]RubOrdreSaisie:14:=$ii+73
	[LesRubriques:21]RubFichier:3:=Table:C252(->[Maraude:24])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Date de rencontre"
			[LesRubriques:21]RubNomNew:13:="Date de rencontre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DateRencontre:84)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de rencontre 2 est obligatoire !"
			
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