//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsDS
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Dossier social

C_LONGINT:C283($1)
C_LONGINT:C283($2)

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$1)
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])>0)
	READ WRITE:C146([LesRubriques:21])
	DELETE SELECTION:C66([LesRubriques:21])
	READ ONLY:C145([LesRubriques:21])
End if 
READ WRITE:C146([LesRubriques:21])

C_LONGINT:C283($ii)
For ($ii; 1; $2)
	CREATE RECORD:C68([LesRubriques:21])
	MultiSoc_Init_Structure(->[LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=$ii
	[LesRubriques:21]RubOrdreSaisie:14:=$ii
	[LesRubriques:21]RubFichier:3:=Table:C252(->[DossierSocial:25])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Responsable"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Responsable:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du responsable est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Conseiller social"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Assistante:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du Conseiller social est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_EtatCivil:11)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Nom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Nom:12)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Prénom:16)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_DateNéLe:18)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de naissance est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Age:17)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_LieuNéOù:19)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Langue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Langue:23)
			[LesRubriques:21]RubAlerte:7:="La saisie de Langue est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Dernier hébergement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_DernierHéber:27)
			[LesRubriques:21]RubAlerte:7:="La saisie du dernier hébergement est obligatoire !"
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="ConnuSSP"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_ConnuSSP:39)
			[LesRubriques:21]RubAlerte:7:="La saisie du Connu SSP est obligatoire !"
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Vu le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_VuLe:2)
			[LesRubriques:21]RubAlerte:7:="La saisie du vu le est obligatoire !"
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Etat matrimonial"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_EtatMatrimon:29)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat matrimonial est obligatoire !"
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Nom et prénom du conjoint"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Conjoint:21)
			[LesRubriques:21]RubAlerte:7:="La saisie du Conjoint est obligatoire !"
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="      Enfants    (nombre)"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Enfants:13)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'existance d'enfants est obligatoire !"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="      Enfants    (nombre)"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_EnfantsNb:14)
			[LesRubriques:21]RubAlerte:7:="La saisie du nombre d'enfants est obligatoire !"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Nationalité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Nationalité:22)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Nationalité est obligatoire !"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Prise en charge EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_EnChargeEMA:25)
			[LesRubriques:21]RubAlerte:7:="La saisie de la prise en charge EMA est obligatoire !"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Motif de refus de la prise en charge EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_RefusEMA:26)
			[LesRubriques:21]RubAlerte:7:="La saisie du refus de la prise en charge EMA est obligatoire !"
		: ($ii=21)
			[LesRubriques:21]RubNom:2:="Majeurs protégés"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_PersonMajeur:24)
			[LesRubriques:21]RubAlerte:7:="La saisie de Majeurs protégés est obligatoire !"
		: ($ii=22)
			[LesRubriques:21]RubNom:2:="Adresse Domiciliation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_HébergAd1:30)
			[LesRubriques:21]RubAlerte:7:="La saisie de l' Adresse Domiciliation est obligatoire !"
		: ($ii=23)
			[LesRubriques:21]RubNom:2:="rue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_HébergAd2:31)
			[LesRubriques:21]RubAlerte:7:="La saisie de la rue de secours est obligatoire !"
		: ($ii=24)
			[LesRubriques:21]RubNom:2:="C.P. et Ville"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_HébergAd3:32)
			[LesRubriques:21]RubAlerte:7:="La saisie du C.P. et Ville de secours est obligatoire !"
		: ($ii=25)
			[LesRubriques:21]RubNom:2:="Temps d'errance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_TempsErrance:35)
			[LesRubriques:21]RubAlerte:7:="La saisie du Temps d'errance est obligatoire !"
		: ($ii=26)
			[LesRubriques:21]RubNom:2:="Personne chez qui aller"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Connaissance:36)
			[LesRubriques:21]RubAlerte:7:="La saisie de la personne chez qui aller est obligatoire !"
		: ($ii=27)
			[LesRubriques:21]RubNom:2:="Compagnie actuelle 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Compagnie:37)
			[LesRubriques:21]RubAlerte:7:="La saisie de la  Compagnie actuelle 1 est obligatoire !"
		: ($ii=28)
			[LesRubriques:21]RubNom:2:="Compagnie actuelle 21"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Compagnie2:38)
			[LesRubriques:21]RubAlerte:7:="La saisie de la  Compagnie actuelle 2 est obligatoire !"
		: ($ii=29)
			[LesRubriques:21]RubNom:2:="Première SSP"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_PremièreSSP:40)
			[LesRubriques:21]RubAlerte:7:="La saisie de Première SSP est obligatoire !"
		: ($ii=30)
			[LesRubriques:21]RubNom:2:="Adresse Domicile de secours"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SecoursAd1:44)
			[LesRubriques:21]RubAlerte:7:="La saisie de l' Adresse domicile de secours est obligatoire !"
		: ($ii=31)
			[LesRubriques:21]RubNom:2:="rue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SecoursAd2:45)
			[LesRubriques:21]RubAlerte:7:="La saisie de la rue de secours est obligatoire !"
		: ($ii=32)
			[LesRubriques:21]RubNom:2:="C.P. et Ville"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SecoursAd3:46)
			[LesRubriques:21]RubAlerte:7:="La saisie du C.P. et Ville de secours est obligatoire !"
		: ($ii=33)
			[LesRubriques:21]RubNom:2:="Dernière adresse connue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_DernierAd1:41)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Dernière adresse connue est obligatoire !"
		: ($ii=34)
			[LesRubriques:21]RubNom:2:="rue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_DernierAd2:42)
			[LesRubriques:21]RubAlerte:7:="La saisie de la rue est obligatoire !"
		: ($ii=35)
			[LesRubriques:21]RubNom:2:="C.P. et Ville"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_DernierAd3:43)
			[LesRubriques:21]RubAlerte:7:="La saisie du C.P. et Ville est obligatoire !"
		: ($ii=36)
			[LesRubriques:21]RubNom:2:="CADRE Papier d'identité"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Papier d'identité"
		: ($ii=37)
			[LesRubriques:21]RubNom:2:="Papier d'identité oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_PapiersQuest:47)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité oui/non est obligatoire !"
		: ($ii=38)
			[LesRubriques:21]RubNom:2:="Papier d'identité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Papier1:48)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité 1 est obligatoire !"
		: ($ii=39)
			[LesRubriques:21]RubNom:2:="Papier d'identité 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Papier2:49)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité 2 est obligatoire !"
		: ($ii=40)
			[LesRubriques:21]RubNom:2:="CADRE Régime"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Régime"
		: ($ii=41)
			[LesRubriques:21]RubNom:2:="Régime oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_RégimeQuest:66)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime oui/non est obligatoire !"
		: ($ii=42)
			[LesRubriques:21]RubNom:2:="Régime 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Régime1:67)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime 1 est obligatoire !"
		: ($ii=43)
			[LesRubriques:21]RubNom:2:="Régime 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Régime2:68)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime 2 est obligatoire !"
		: ($ii=44)
			[LesRubriques:21]RubNom:2:="CADRE Suivi"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Suivi"
		: ($ii=45)
			[LesRubriques:21]RubNom:2:="Suivi oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SuiviSQuest:69)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi oui/non est obligatoire !"
		: ($ii=46)
			[LesRubriques:21]RubNom:2:="Suivi 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SuiviS1:70)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi 1 est obligatoire !"
		: ($ii=47)
			[LesRubriques:21]RubNom:2:="Suivi 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SuiviS2:71)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi 2 est obligatoire !"
		: ($ii=48)
			[LesRubriques:21]RubNom:2:="CADRE Couverture sociale"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Couverture sociale"
		: ($ii=49)
			[LesRubriques:21]RubNom:2:="Couverture sociale oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSocQuest:50)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Couverture sociale oui/non est obligatoire !"
		: ($ii=50)
			[LesRubriques:21]RubNom:2:="Couverture sociale 1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc1_1:51)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1_1 est obligatoire !"
		: ($ii=51)
			[LesRubriques:21]RubNom:2:="Couverture sociale 1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc1_2:52)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1_2 est obligatoire !"
		: ($ii=52)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc2_1:53)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 2_1 est obligatoire !"
		: ($ii=53)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc2_2:54)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 2_2 est obligatoire !"
		: ($ii=54)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc3_1:55)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 3_1 est obligatoire !"
		: ($ii=55)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_CouvSoc3_2:56)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 3_2 est obligatoire !"
		: ($ii=56)
			[LesRubriques:21]RubNom:2:="CADRE Ressources"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Ressources"
		: ($ii=57)
			[LesRubriques:21]RubNom:2:="Ressources oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_ResourcQuest:57)
			[LesRubriques:21]RubAlerte:7:="La saisie des Ressources oui/non est obligatoire !"
		: ($ii=58)
			[LesRubriques:21]RubNom:2:="Ressources1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour1_1:58)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource1_1 est obligatoire !"
		: ($ii=59)
			[LesRubriques:21]RubNom:2:="Ressources1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour1_2:59)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource1_2 est obligatoire !"
		: ($ii=60)
			[LesRubriques:21]RubNom:2:="Ressources2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour2_1:60)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource2_1 est obligatoire !"
		: ($ii=61)
			[LesRubriques:21]RubNom:2:="Ressources2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour2_2:61)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource2_2 est obligatoire !"
		: ($ii=62)
			[LesRubriques:21]RubNom:2:="Ressources3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour3_1:62)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource3_1 est obligatoire !"
		: ($ii=63)
			[LesRubriques:21]RubNom:2:="Ressources3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Ressour3_2:63)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource3_2 est obligatoire !"
		: ($ii=64)
			[LesRubriques:21]RubNom:2:="CADRE Sortie "
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Sortie"
		: ($ii=65)
			[LesRubriques:21]RubNom:2:="Sotie  oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_Sortie:72)
			[LesRubriques:21]RubAlerte:7:="La saisie de Sortie oui/non est obligatoire !"
		: ($ii=66)
			[LesRubriques:21]RubNom:2:="Sortie "
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SortieCtr1:73)
			[LesRubriques:21]RubAlerte:7:="La saisie de Sortie 1 est obligatoire !"
		: ($ii=67)
			[LesRubriques:21]RubNom:2:="Sortie 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_SortieCtr2:74)
			[LesRubriques:21]RubAlerte:7:="La saisie de Sortie 2 est obligatoire !"
		: ($ii=68)
			[LesRubriques:21]RubNom:2:="Liste des enfants"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]DS_EnfantsNom:15)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'identité des enfants est obligatoire !"
		: ($ii=69)
			[LesRubriques:21]RubNom:2:="Liste des référents"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSocial:25]EL_RéférentList:65)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'identité des référents est obligatoire !"
	End case 
	[LesRubriques:21]RubSaississable:5:=True:C214
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=True:C214
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=True:C214
	[LesRubriques:21]RubDéveloppeur:11:=False:C215
	[LesRubriques:21]RubNoSTR:12:=$1
	[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])