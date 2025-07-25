//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsDE
//{
//{          Mercredi 05 février 2003 à 16:26
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Dossier santé

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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[DossierSante:33])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Centre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Centre:11)
			[LesRubriques:21]RubAlerte:7:="La saisie du centre est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Centre"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Responsable"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Responsable:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du responsable est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="Infirmier (ère)"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Infirmier:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'infirmier est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Médecin"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Médecin:12)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du médecin est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Cadre identité"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:=""
			[LesRubriques:21]RubNomNew:13:="Identité"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatCivil:13)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Nom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Nom:14)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Prénom:15)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DateNéLe:17)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de naissance est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_LieuNéOù:18)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Age:16)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Genre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Genre:19)
			[LesRubriques:21]RubAlerte:7:="La saisie du genre est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Nationalité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Nationalité:20)
			[LesRubriques:21]RubAlerte:7:="La saisie de la nationalité est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Langue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Langue:21)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Langue est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="Enfants Oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Enfant:22)
			[LesRubriques:21]RubAlerte:7:="La saisie des Enfants est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Enfants"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="Enfants Nombre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EnfantNombre:23)
			[LesRubriques:21]RubAlerte:7:="La saisie du nombre d'Enfants est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Nb"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Situation de famille"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_SitFamiliale:24)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Situation de Famille est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Sit.famille"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Dernier hébergement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DernierHébergement:25)
			[LesRubriques:21]RubAlerte:7:="La saisie du Dernier hébergement  est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Der. hébergement"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Dernière adresse connue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DernièreAdrConnue:26)
			[LesRubriques:21]RubAlerte:7:="La saisie du la Dernière adresse connue  est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Dernière adresse connue"
		: ($ii=21)
			[LesRubriques:21]RubNom:2:="Der.Adr. connue Rue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DernièreAdrConnueRue:27)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Rue est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Rue"
		: ($ii=22)
			[LesRubriques:21]RubNom:2:="Der.Adr. connue CP et ville"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DernièreAdrConnueVille:28)
			[LesRubriques:21]RubAlerte:7:="La saisie du CP et ville est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="CP et ville"
		: ($ii=23)
			[LesRubriques:21]RubNom:2:="Adresse domiciliation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Domiciliation:29)
			[LesRubriques:21]RubAlerte:7:="La saisie du l'Adresse domiciliation  est obligatoire !"
			[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
		: ($ii=24)
			[LesRubriques:21]RubNom:2:="Domiciliation Rue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DomiciliationRue:30)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Rue est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Rue"
		: ($ii=25)
			[LesRubriques:21]RubNom:2:="Domiciliation CP et ville"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DomiciliationVille:31)
			[LesRubriques:21]RubAlerte:7:="La saisie du CP et ville est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="CP et ville"
		: ($ii=26)
			[LesRubriques:21]RubNom:2:="Cadre Situation sociale"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:=""
			[LesRubriques:21]RubNomNew:13:="Situation sociale"
		: ($ii=27)
			[LesRubriques:21]RubNom:2:="Papiers1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers1_1:32)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 1 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers"
		: ($ii=28)
			[LesRubriques:21]RubNom:2:="Papiers1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers1_2:33)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 1_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers1_2"
		: ($ii=29)
			[LesRubriques:21]RubNom:2:="Papiers2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers2_1:34)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 2_1 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers 2"
		: ($ii=30)
			[LesRubriques:21]RubNom:2:="Papiers2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers2_2:35)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 2_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers2_2"
		: ($ii=31)
			[LesRubriques:21]RubNom:2:="Papiers3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers3_1:36)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 3 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers 3"
		: ($ii=32)
			[LesRubriques:21]RubNom:2:="Papiers3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Papiers3_2:37)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier identité 3_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Papiers3_2"
		: ($ii=33)
			[LesRubriques:21]RubNom:2:="Couverture sociale  1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture1_1:38)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale"
		: ($ii=34)
			[LesRubriques:21]RubNom:2:="Couverture sociale 1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture1_2:39)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale 1_2"
		: ($ii=35)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture2_1:40)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale 2"
		: ($ii=36)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture2_2:41)
			[LesRubriques:21]RubAlerte:7:="La saisie du Cadre suivi social 2_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale 2_2"
		: ($ii=37)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture3_1:42)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 3 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale 3"
		: ($ii=38)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Couverture3_2:43)
			[LesRubriques:21]RubAlerte:7:="La saisie du Cadre suivi social 3_2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Couverture sociale 3_2"
		: ($ii=39)
			[LesRubriques:21]RubNom:2:="Suivi social"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Suivi1_1:44)
			[LesRubriques:21]RubAlerte:7:="La saisie de Suivi social est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Suivi social"
		: ($ii=40)
			[LesRubriques:21]RubNom:2:="Suivi social 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Suivi1_2:45)
			[LesRubriques:21]RubAlerte:7:="La saisie de Suivi social 2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Suivi social 2"
		: ($ii=41)
			[LesRubriques:21]RubNom:2:="Temps d'errance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_TempsErrance:46)
			[LesRubriques:21]RubAlerte:7:="La saisie du Temps d'errance est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Temps d'errance"
		: ($ii=42)
			[LesRubriques:21]RubNom:2:="Cadre Evaluation de l'état de santé"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:=""
			[LesRubriques:21]RubNomNew:13:="Evaluation de l'état de santé"
		: ($ii=43)
			[LesRubriques:21]RubNom:2:="Etat général"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_Etatgénéral:47)
			[LesRubriques:21]RubAlerte:7:="La saisie de l' Etat général est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Etat général"
		: ($ii=44)
			[LesRubriques:21]RubNom:2:="Etat cutané"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatCutané:48)
			[LesRubriques:21]RubAlerte:7:="La saisie de l' Etat cutané est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Etat cutané"
		: ($ii=45)
			[LesRubriques:21]RubNom:2:="Etat Relation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatRelation:49)
			[LesRubriques:21]RubAlerte:7:="La saisie de laRelation est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Relation"
		: ($ii=46)
			[LesRubriques:21]RubNom:2:="Etat Autonomie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatAutonomie:50)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Autonomie est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Autonomie"
		: ($ii=47)
			[LesRubriques:21]RubNom:2:="Etat Dépendance 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatDépendance1:51)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Autonomie est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Dépendance"
		: ($ii=48)
			[LesRubriques:21]RubNom:2:="Etat Dépendance 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatDépendance2:52)
			[LesRubriques:21]RubAlerte:7:="La saisie de Dépendance2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Dépendance 2"
		: ($ii=49)
			[LesRubriques:21]RubNom:2:="Etat Dépendance 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatDépendance3:53)
			[LesRubriques:21]RubAlerte:7:="La saisie de Dépendance3 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Dépendance 3"
		: ($ii=50)
			[LesRubriques:21]RubNom:2:="Etat Parasitose 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatParasitose1:54)
			[LesRubriques:21]RubAlerte:7:="La saisie de Parasitose est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Parasitose"
		: ($ii=51)
			[LesRubriques:21]RubNom:2:="Etat Parasitose 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatParasitose2:55)
			[LesRubriques:21]RubAlerte:7:="La saisie de Parasitose2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Parasitose 2"
		: ($ii=52)
			[LesRubriques:21]RubNom:2:="Etat Parasitose 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatParasitose3:56)
			[LesRubriques:21]RubAlerte:7:="La saisie de Parasitose3 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Parasitose 3"
		: ($ii=53)
			[LesRubriques:21]RubNom:2:="Etat Allergie 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatAllergie1:57)
			[LesRubriques:21]RubAlerte:7:="La saisie de Allergie est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Allergie"
		: ($ii=54)
			[LesRubriques:21]RubNom:2:="Etat Parasitose 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatAllergie2:58)
			[LesRubriques:21]RubAlerte:7:="La saisie de Allergie2 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Allergie 2"
		: ($ii=55)
			[LesRubriques:21]RubNom:2:="Etat Allergie 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatAllergie3:59)
			[LesRubriques:21]RubAlerte:7:="La saisie de Allergie3 est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Allergie 3"
		: ($ii=56)
			[LesRubriques:21]RubNom:2:="Etat poids à l'entrée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatPoidsEntrée:60)
			[LesRubriques:21]RubAlerte:7:="La saisie de poids à l'entrée est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Poids à l'entrée"
		: ($ii=57)
			[LesRubriques:21]RubNom:2:="Etat poids à la sortie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EtatPoidsSortie:61)
			[LesRubriques:21]RubAlerte:7:="La saisie de poids à la sortie est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Poids à la sortie"
		: ($ii=58)
			[LesRubriques:21]RubNom:2:="Cadre Séjour"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:=""
			[LesRubriques:21]RubNomNew:13:="Séjour"
		: ($ii=59)
			[LesRubriques:21]RubNom:2:="Date d'entrée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EntréeDate:62)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date d'entrée est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Date d'entrée"
		: ($ii=60)
			[LesRubriques:21]RubNom:2:="Heure d'entrée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EntréeHeure:63)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Heure d'entrée est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Heure"
		: ($ii=61)
			[LesRubriques:21]RubNom:2:="Mode d'entrée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EntréeMode:64)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode d'entrée est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Mode d'entrée"
		: ($ii=62)
			[LesRubriques:21]RubNom:2:="Motif d'entrée"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_EntréeMotif:65)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'entrée est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Motif d'entrée"
		: ($ii=63)
			[LesRubriques:21]RubNom:2:="Estimation de la durée du séjour"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_DuréeSéjourEstimé:66)
			[LesRubriques:21]RubAlerte:7:="La saisie de Estimation de la durée du séjour est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Estimation du séjour"
		: ($ii=64)
			[LesRubriques:21]RubNom:2:="Objectif du Patient"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_ObjectifPatient:67)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Objectif Patient est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Objectif du Patient"
		: ($ii=65)
			[LesRubriques:21]RubNom:2:="Objectif de l'équipe"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_ObjectifEquipe:68)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Objectif de l'équipe est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Objectif de l'équipe"
		: ($ii=66)
			[LesRubriques:21]RubNom:2:="Date de sortie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_SortieDate:69)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de sortie est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Sortie le"
		: ($ii=67)
			[LesRubriques:21]RubNom:2:="Orientation à la sortie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_SortieOrientation:70)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Orientation est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Orientation"
		: ($ii=68)
			[LesRubriques:21]RubNom:2:="Vu le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierSante:33]DE_VuLe:2)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date Vu le est obligatoire !"
			[LesRubriques:21]RubNomNew:13:="Vu le"
		: ($ii=69)
			[LesRubriques:21]RubNom:2:="Cadre Questions médicales"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:=""
			[LesRubriques:21]RubNomNew:13:="Recueil"
		: ($ii>69) & ($ii<123)
			Debut_DecVarChampsDEsuite($ii)
	End case 
	[LesRubriques:21]RubSaississable:5:=True:C214
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=True:C214
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=True:C214
	[LesRubriques:21]RubDéveloppeur:11:=False:C215
	[LesRubriques:21]RubNoSTR:12:=$1
	If ($ii=88)
		[LesRubriques:21]RubSaississable:5:=False:C215
		[LesRubriques:21]RubObligatoire:6:=False:C215
		[LesRubriques:21]RubVisible:8:=False:C215
		[LesRubriques:21]RubPopVisible:9:=False:C215
		[LesRubriques:21]RubModifiable:10:=False:C215
	End if 
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])