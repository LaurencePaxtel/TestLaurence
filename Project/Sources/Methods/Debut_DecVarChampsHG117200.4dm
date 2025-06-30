//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Debut_DecVarChampsHG1 
//{          lundi 19 décembre 2011 à 18:10
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement
C_LONGINT:C283($1)
C_LONGINT:C283($ii)

Case of 
	: ($ii=117)
		[LesRubriques:21]RubNom:2:="Flag_CapaciteAcces"
		[LesRubriques:21]RubNomNew:13:="Capacite d'accès"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_CapaciteAcces:158)
		[LesRubriques:21]RubAlerte:7:="La saisie du Flag CapaciteAcces est conseillée !"
		
	: ($ii=118)
		[LesRubriques:21]RubNom:2:="Flag_DAHO"
		[LesRubriques:21]RubNomNew:13:="Priorité DAHO"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_DAHO:156)
		[LesRubriques:21]RubAlerte:7:="La saisie du Flag DAHO est conseillée !"
		
	: ($ii=119)
		[LesRubriques:21]RubNom:2:="Flag_FemViolence"
		[LesRubriques:21]RubNomNew:13:="Violences feminines"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_FemViolence:157)
		[LesRubriques:21]RubAlerte:7:="La saisie du Flag femme violences est conseillée !"
		
	: ($ii=120)
		[LesRubriques:21]RubNom:2:="Flag_LogAutonome"
		[LesRubriques:21]RubNomNew:13:="Logement autonome"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_LogAutonome:159)
		[LesRubriques:21]RubAlerte:7:="La saisie du Flag LogAutonome est conseillée !"
		
	: ($ii=121)
		[LesRubriques:21]RubNom:2:="Flag_OrientCorrespondant"
		[LesRubriques:21]RubNomNew:13:="Orientation correspondant"
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
		[LesRubriques:21]RubNomNew:13:="Souhait"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Flag_Souhait:160)
		[LesRubriques:21]RubAlerte:7:="La saisie du Flag Souhait est conseillée !"
		
		
	: ($ii=125)
		[LesRubriques:21]RubNom:2:="DossierSIAO"
		[LesRubriques:21]RubNomNew:13:="Dossier SIAO"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DossierSIAO:164)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Dossier SIAO est obligatoire !"
		
		
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
		[LesRubriques:21]RubNomNew:13:="Type de palce"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_de_Place:167)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de place est obligatoire !"
		
		
End case 