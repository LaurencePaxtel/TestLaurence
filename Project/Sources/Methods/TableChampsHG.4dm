//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableChampsHG
//{
//{          Vendredi : 6 octobre 2008 à 11:30
//{          Modifiée : 6 octobre 2008 à 11:30
//{          Développement : GABBAY Jean-Guy
//{==================================================}


//$vl_STR:=30100+1  `{1}:="Hébergement"
//$vl_STR:=30100+8  `{8}:="Hébergement Asile"
//$vl_STR:=30100+9  `{9}:="Hébergement externe"
//$vl_STR:=30100+10  `{10}:="Hébergement externe permanencier"
//$vl_STR:=30100+12  `{12}:="Hébergement Prestations"

//{=Mise à jour des champs 101 à 10

C_LONGINT:C283($ii; $vl_STR)

If (7=8)
	READ WRITE:C146([LesRubriques:21])
	
	$vl_STR:=30100+8
	For ($ii; 101; 109)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR; *)
		QUERY:C277([LesRubriques:21];  & ; [LesRubriques:21]NuméroTri:1=$ii)
		MultiSoc_Filter(->[LesRubriques:21])
		
		If (Records in selection:C76([LesRubriques:21])=1)
			LOAD RECORD:C52([LesRubriques:21])
		Else 
			CREATE RECORD:C68([LesRubriques:21])
			MultiSoc_Init_Structure(->[LesRubriques:21])
			[LesRubriques:21]NuméroTri:1:=$ii
			[LesRubriques:21]RubOrdreSaisie:14:=$ii
			[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
			[LesRubriques:21]RubNoSTR:12:=$vl_STR
		End if 
		
		[LesRubriques:21]RubSaississable:5:=False:C215
		[LesRubriques:21]RubObligatoire:6:=False:C215
		[LesRubriques:21]RubVisible:8:=False:C215
		[LesRubriques:21]RubPopVisible:9:=False:C215
		[LesRubriques:21]RubModifiable:10:=False:C215
		[LesRubriques:21]RubDéveloppeur:11:=True:C214
		
		Case of 
			: ($ii=101)
				[LesRubriques:21]RubNom:2:="PlateformeCentre"
				[LesRubriques:21]RubNomNew:13:="Plateforme Centre"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_PlateformeCentre:140)
				[LesRubriques:21]RubAlerte:7:="La saisie de la Plateforme est obligatoire !"
				
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=True:C214
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
				
			: ($ii=102)
				[LesRubriques:21]RubNom:2:="Trans_DDASS"
				[LesRubriques:21]RubNomNew:13:="DDASS"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_DDASS:141)
				[LesRubriques:21]RubAlerte:7:="Pas d'alerte le champ ne doit pas être obligatoire"
				
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=True:C214
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
				
			: ($ii=103)
				[LesRubriques:21]RubNom:2:="Trans_Référence"
				[LesRubriques:21]RubNomNew:13:="Transfert Référence"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_RéférenceID:142)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=104)
				[LesRubriques:21]RubNom:2:="Trans_FicheNo"
				[LesRubriques:21]RubNomNew:13:="Transfert Fiche no"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_FicheNuméro:143)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=105)
				[LesRubriques:21]RubNom:2:="Trans_HB_ID"
				[LesRubriques:21]RubNomNew:13:="Transfert Hébergé"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_HB_ID:144)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=106)
				[LesRubriques:21]RubNom:2:="Trans_LC_ID"
				[LesRubriques:21]RubNomNew:13:="Transfert Centre référence"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_LC_ID:145)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=107)
				[LesRubriques:21]RubNom:2:="Trans_CentreNom"
				[LesRubriques:21]RubNomNew:13:="Transfert Centre nom"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_CentreNom:146)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=108)
				[LesRubriques:21]RubNom:2:="Trans_FamClé"
				[LesRubriques:21]RubNomNew:13:="Transfert Clé de famille"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_FamClé:147)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
				
			: ($ii=109)
				[LesRubriques:21]RubNom:2:="Trans_Plateforme"
				[LesRubriques:21]RubNomNew:13:="Transfert de la plateforme"
				[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_Plateforme:148)
				[LesRubriques:21]RubAlerte:7:="Champ réservé"
		End case 
		SAVE RECORD:C53([LesRubriques:21])
		UNLOAD RECORD:C212([LesRubriques:21])
	End for 
	READ ONLY:C145([LesRubriques:21])
End if 