//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/12/22, 15:27:29
// ----------------------------------------------------
// Méthode : Debut_DecVarChampsHGj200
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($ii)

$ii:=$1

Case of 
	: ($ii=101)
		[LesRubriques:21]RubNom:2:="PlateformeCentre"
		[LesRubriques:21]RubNomNew:13:="Plateforme Centre"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_PlateformeCentre:140)
		[LesRubriques:21]RubAlerte:7:=""
	: ($ii=102)
		[LesRubriques:21]RubNom:2:="Trans_DDASS"
		[LesRubriques:21]RubNomNew:13:="DDASS"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Trans_DDASS:141)
		[LesRubriques:21]RubAlerte:7:="Pas d'alerte le champ ne doit pas être obligatoire"
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
	: ($ii=110)
		[LesRubriques:21]RubNom:2:="DateCréationFiche"
		[LesRubriques:21]RubNomNew:13:="Date de création de la fiche"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)
		[LesRubriques:21]RubAlerte:7:="Champ réservé"
	: ($ii=111)
		[LesRubriques:21]RubNom:2:="CléCodée_Etat"
		[LesRubriques:21]RubNomNew:13:="La clé est-elle codée"
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
		[LesRubriques:21]RubNomNew:13:="Type de place"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_de_Place:167)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de place est obligatoire !"
	: ($ii=128)
		[LesRubriques:21]RubNom:2:="HG_Type_de_Place"
		[LesRubriques:21]RubNomNew:13:="Type de place"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Type_de_Place:167)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Type de place est obligatoire !"
	: ($ii=129)
		[LesRubriques:21]RubNom:2:="Orientation1Suite"
		[LesRubriques:21]RubNomNew:13:="Orientation1Suite"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Orientation1Suite:59)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Orientation1suite est obligatoire !"
	: ($ii=130)
		[LesRubriques:21]RubNom:2:="ReservationDateFin"
		[LesRubriques:21]RubNomNew:13:="Date de fin (inclue)"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_RéservationDateFin:134)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Date de fin de réservation est obligatoire !"
	: ($ii=131)  // #HPOP2017
		[LesRubriques:21]RubNom:2:="HG_AutreSolSuite"
		[LesRubriques:21]RubNomNew:13:="Autres solutions suite"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_AutreSolSuite:123)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Autres solutions suite est obligatoire !"
	: ($ii=132)
		// Modifié par : Scanu Rémy (23/02/2023)
		[LesRubriques:21]RubNom:2:="HG_Montant"
		[LesRubriques:21]RubNomNew:13:="Montant"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Montant:179)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Montant est obligatoire !"
	: ($ii=133)
		// Modifié par : LPC (05/12/2023)
		[LesRubriques:21]RubNom:2:="HG_Commentaires"
		[LesRubriques:21]RubNomNew:13:="Commentaires"
		[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Commentaires:181)
		[LesRubriques:21]RubAlerte:7:="La saisie du champ Commentaires est obligatoire !"
End case 