//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG102
//{
//{          Mercredi 17 septembre 2008 à 16:34
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
//a servi à mettre à jour manuellement les tables 
C_LONGINT:C283($1)
C_LONGINT:C283($vl_STR)

READ WRITE:C146([LesRubriques:21])
For ($ii; 1; 5)
	
	Case of 
		: ($ii=1)
			$vl_STR:=30100+1
		: ($ii=2)
			$vl_STR:=30100+8
		: ($ii=3)
			$vl_STR:=30100+9
		: ($ii=4)
			$vl_STR:=30100+10
		: ($ii=5)
			$vl_STR:=30100+12
	End case 
	
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR; *)
	QUERY:C277([LesRubriques:21];  & ; [LesRubriques:21]NuméroTri:1>100)
	MultiSoc_Filter(->[LesRubriques:21])
	If (Records in selection:C76([LesRubriques:21])>0)
		ORDER BY:C49([LesRubriques:21]; [LesRubriques:21]NuméroTri:1; >)
		FIRST RECORD:C50([LesRubriques:21])
		
		Repeat 
			[LesRubriques:21]RubSaississable:5:=False:C215
			[LesRubriques:21]RubObligatoire:6:=False:C215
			[LesRubriques:21]RubVisible:8:=False:C215
			[LesRubriques:21]RubPopVisible:9:=False:C215
			[LesRubriques:21]RubModifiable:10:=False:C215
			[LesRubriques:21]RubDéveloppeur:11:=True:C214
			
			Case of 
				: ([LesRubriques:21]NuméroTri:1=101)
					[LesRubriques:21]RubNom:2:="PlateformeCentre"
					[LesRubriques:21]RubNomNew:13:="Plateforme Centre"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_PlateformeCentre:140)
					[LesRubriques:21]RubAlerte:7:=""
					
					[LesRubriques:21]RubSaississable:5:=True:C214
					[LesRubriques:21]RubObligatoire:6:=False:C215
					[LesRubriques:21]RubVisible:8:=True:C214
					[LesRubriques:21]RubPopVisible:9:=False:C215
					[LesRubriques:21]RubModifiable:10:=True:C214
					[LesRubriques:21]RubDéveloppeur:11:=False:C215
					
				: ([LesRubriques:21]NuméroTri:1=102)
					[LesRubriques:21]RubNom:2:="Trans_DDASS"
					[LesRubriques:21]RubNomNew:13:="DDASS"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_DDASS:141)
					[LesRubriques:21]RubAlerte:7:=""
					
					[LesRubriques:21]RubSaississable:5:=True:C214
					[LesRubriques:21]RubObligatoire:6:=False:C215
					[LesRubriques:21]RubVisible:8:=True:C214
					[LesRubriques:21]RubPopVisible:9:=False:C215
					[LesRubriques:21]RubModifiable:10:=True:C214
					[LesRubriques:21]RubDéveloppeur:11:=False:C215
					
				: ([LesRubriques:21]NuméroTri:1=103)
					[LesRubriques:21]RubNom:2:="Trans_Référence"
					[LesRubriques:21]RubNomNew:13:="Transfert Référence"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_RéférenceID:142)
					[LesRubriques:21]RubAlerte:7:=""
					
				: ([LesRubriques:21]NuméroTri:1=104)
					[LesRubriques:21]RubNom:2:="Trans_FicheNo"
					[LesRubriques:21]RubNomNew:13:="Transfert Fiche no"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_FicheNuméro:143)
					[LesRubriques:21]RubAlerte:7:=""
					
				: ([LesRubriques:21]NuméroTri:1=105)
					[LesRubriques:21]RubNom:2:="Trans_HB_ID"
					[LesRubriques:21]RubNomNew:13:="Transfert Hébergé"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_HB_ID:144)
					[LesRubriques:21]RubAlerte:7:=""
					
				: ([LesRubriques:21]NuméroTri:1=106)
					[LesRubriques:21]RubNom:2:="Trans_LC_ID"
					[LesRubriques:21]RubNomNew:13:="Transfert Centre référence"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_LC_ID:145)
					[LesRubriques:21]RubAlerte:7:=""
					
				: ([LesRubriques:21]NuméroTri:1=107)
					[LesRubriques:21]RubNom:2:="Trans_CentreNom"
					[LesRubriques:21]RubNomNew:13:="Transfert Centre nom"
					[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_CentreNom:146)
					[LesRubriques:21]RubAlerte:7:=""
			End case 
			SAVE RECORD:C53([LesRubriques:21])
			
			UNLOAD RECORD:C212([LesRubriques:21])
			NEXT RECORD:C51([LesRubriques:21])
		Until (End selection:C36([LesRubriques:21]))
		
	End if 
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=108
	[LesRubriques:21]RubOrdreSaisie:14:=108
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	
	[LesRubriques:21]RubSaississable:5:=False:C215
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=False:C215
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=False:C215
	[LesRubriques:21]RubDéveloppeur:11:=True:C214
	
	[LesRubriques:21]RubNoSTR:12:=$vl_STR
	
	[LesRubriques:21]RubNom:2:="Trans_FamClé"
	[LesRubriques:21]RubNomNew:13:="Transfert Clé de famille"
	[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_FamClé:147)
	[LesRubriques:21]RubAlerte:7:=""
	
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])