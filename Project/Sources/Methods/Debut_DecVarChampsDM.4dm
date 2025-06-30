//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsDM
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Dossier médical

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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[DossierMedical:29])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Responsable"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Responsable:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du responsable est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Médecin"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Médecin:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'infirmier est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="N° EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EMA:11)
			[LesRubriques:21]RubAlerte:7:="La saisie du N° EMA est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EtatCivil:12)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Nom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Nom:13)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Prénom:14)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_DateNéLe:16)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de naissance est obligatoire !"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Age:15)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_LieuNéOù:17)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Vu le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VuLe:2)
			[LesRubriques:21]RubAlerte:7:="La saisie de vu le est obligatoire !"
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="Genre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Genre:18)
			[LesRubriques:21]RubAlerte:7:="La saisie du genre est obligatoire !"
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Nationalité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Nationalité:20)
			[LesRubriques:21]RubAlerte:7:="La saisie de la nationalité est obligatoire !"
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Etat matrimonial"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EtatMatrimon:19)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat matrimonial est obligatoire !"
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Entrée le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_DateEntrée:23)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date d'entrée est obligatoire !"
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="Mode d'accès"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_ModeEntrée1:27)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode d'accès 1 est obligatoire !"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="Mode d'accès 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_ModeEntrée2:28)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode d'accès 2 est obligatoire !"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Sortie le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_DateSortie:25)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de sotie est obligatoire !"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Mode de sortie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_ModeSortie1:29)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode de sotie 1 est obligatoire !"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Mode de sortie 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_ModeSortie2:30)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode de sotie 2 est obligatoire !"
		: ($ii=21)
			[LesRubriques:21]RubNom:2:="Durée du séjour"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_NbJours:26)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Durée du séjour est obligatoire !"
		: ($ii=22)
			[LesRubriques:21]RubNom:2:="Poids"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_PoidsSuite:38)
			[LesRubriques:21]RubAlerte:7:="La saisie du Poids est obligatoire !"
		: ($ii=23)
			[LesRubriques:21]RubNom:2:="Poids 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Poids:37)
			[LesRubriques:21]RubAlerte:7:="La saisie du Poids 2 est obligatoire !"
		: ($ii=24)
			[LesRubriques:21]RubNom:2:="Vision de loin gauche"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionLoinGi:44)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de loin gauche est obligatoire !"
		: ($ii=25)
			[LesRubriques:21]RubNom:2:="Vision de loin gauche 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionLoinG:43)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de loin gauche 2 est obligatoire !"
		: ($ii=26)
			[LesRubriques:21]RubNom:2:="Vision de loin droit"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionLoinDi:42)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de loin droit est obligatoire !"
		: ($ii=27)
			[LesRubriques:21]RubNom:2:="Vision de loin droit 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionLoinD:41)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de loin droit 2 est obligatoire !"
		: ($ii=28)
			[LesRubriques:21]RubNom:2:="Taille"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TailleSuite:40)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Taille est obligatoire !"
		: ($ii=29)
			[LesRubriques:21]RubNom:2:="Taille 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Taille:39)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Taille 2 est obligatoire !"
		: ($ii=30)
			[LesRubriques:21]RubNom:2:="Vision de près gauche"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionPrèsGi:48)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de près gauche est obligatoire !"
		: ($ii=31)
			[LesRubriques:21]RubNom:2:="Vision de près gauche 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionPrèsG:47)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de près gauche 2 est obligatoire !"
		: ($ii=32)
			[LesRubriques:21]RubNom:2:="Vision de près droit"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionPrèsDi:46)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de près droit est obligatoire !"
		: ($ii=33)
			[LesRubriques:21]RubNom:2:="Vision de près droit 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_VisionPrèsD:45)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Vision de près droit 2 est obligatoire !"
		: ($ii=34)
			[LesRubriques:21]RubNom:2:="Antécédents 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan1_1:49)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 1 est obligatoire !"
		: ($ii=35)
			[LesRubriques:21]RubNom:2:="Antécédents 1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan1_2:50)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 1 suite est obligatoire !"
		: ($ii=36)
			[LesRubriques:21]RubNom:2:="Antécédents 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan2_1:51)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 2 est obligatoire !"
		: ($ii=37)
			[LesRubriques:21]RubNom:2:="Antécédents 2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan2_2:52)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 2 suite est obligatoire !"
		: ($ii=38)
			[LesRubriques:21]RubNom:2:="Antécédents 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan3_1:53)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 3 est obligatoire !"
		: ($ii=39)
			[LesRubriques:21]RubNom:2:="Antécédents 3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Antécédan3_2:54)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Antécédent 3 suite est obligatoire !"
		: ($ii=40)
			[LesRubriques:21]RubNom:2:="Traitement administré"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitAdmin1:31)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement administré 1 est obligatoire !"
		: ($ii=41)
			[LesRubriques:21]RubNom:2:="Traitement administré 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitAdmin2:32)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement administré 2 suite est obligatoire !"
		: ($ii=42)
			[LesRubriques:21]RubNom:2:="Traitement administré 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitAdmin3:33)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement administré 3 est obligatoire !"
		: ($ii=43)
			[LesRubriques:21]RubNom:2:="Motif d'admission"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi1_1:66)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 1 est obligatoire !"
		: ($ii=44)
			[LesRubriques:21]RubNom:2:="Motif d'admission 1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi1_2:67)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 1 suite est obligatoire !"
		: ($ii=45)
			[LesRubriques:21]RubNom:2:="Motif d'admission 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi2_1:68)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 2 est obligatoire !"
		: ($ii=46)
			[LesRubriques:21]RubNom:2:="Motif d'admission 2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi2_2:69)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 2 suite est obligatoire !"
		: ($ii=47)
			[LesRubriques:21]RubNom:2:="Motif d'admission 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi3_1:70)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 3 est obligatoire !"
		: ($ii=48)
			[LesRubriques:21]RubNom:2:="Motif d'admission 3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_MotifAdmi3_2:71)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif d'admission 3 suite est obligatoire !"
		: ($ii=49)
			[LesRubriques:21]RubNom:2:="Traitement de sortie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitSortie1:34)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement de sortie 1 est obligatoire !"
		: ($ii=50)
			[LesRubriques:21]RubNom:2:="Traitement de sortie 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitSortie2:35)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement de sortie 2 suite est obligatoire !"
		: ($ii=51)
			[LesRubriques:21]RubNom:2:="Traitement de sortie 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TraitSortie3:36)
			[LesRubriques:21]RubAlerte:7:="La saisie du Traitement de sortie 3 est obligatoire !"
		: ($ii=52)
			[LesRubriques:21]RubNom:2:="Ethylisme"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Ethylisme:56)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Ethylisme est obligatoire !"
		: ($ii=53)
			[LesRubriques:21]RubNom:2:="Ethylisme quantité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EthylismeQté:57)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Ethylisme quantité est obligatoire !"
		: ($ii=54)
			[LesRubriques:21]RubNom:2:="Ethylisme type"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EthylismeTyp:58)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Ethylisme type est obligatoire !"
		: ($ii=55)
			[LesRubriques:21]RubNom:2:="Ethylisme années"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_EthylismeAné:59)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Ethylisme années est obligatoire !"
		: ($ii=56)
			[LesRubriques:21]RubNom:2:="Tabagisme"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Tabac:60)
			[LesRubriques:21]RubAlerte:7:="La saisie du Tabagisme est obligatoire !"
		: ($ii=57)
			[LesRubriques:21]RubNom:2:="Tabagisme quantité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TabacNbPaqué:61)
			[LesRubriques:21]RubAlerte:7:="La saisie du Tabagisme  quantité est obligatoire !"
		: ($ii=58)
			[LesRubriques:21]RubNom:2:="Tabagisme années"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_TabacNbAnnée:62)
			[LesRubriques:21]RubAlerte:7:="La saisie du Tabagisme années est obligatoire !"
		: ($ii=59)
			[LesRubriques:21]RubNom:2:="Examen pratiqué"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen1:72)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Examen pratiqué 1 est obligatoire !"
		: ($ii=60)
			[LesRubriques:21]RubNom:2:="Examen pratiqué date"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen1date:73)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de l'Examen pratiqué 1 est obligatoire !"
		: ($ii=61)
			[LesRubriques:21]RubNom:2:="Examen pratiqué 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen2:74)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Examen pratiqué 2 suite est obligatoire !"
		: ($ii=62)
			[LesRubriques:21]RubNom:2:="Examen pratiqué 2 date"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen2date:75)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de l'Examen pratiqué 2 est obligatoire !"
		: ($ii=63)
			[LesRubriques:21]RubNom:2:="Examen pratiqué 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen3:76)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Examen pratiqué 3 est obligatoire !"
		: ($ii=64)
			[LesRubriques:21]RubNom:2:="Examen pratiqué 3 date"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Examen3date:77)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de l'Examen pratiqué 3 est obligatoire !"
		: ($ii=65)
			[LesRubriques:21]RubNom:2:="Toxicomanie"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Toxicomanie1:63)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Toxicomanie est obligatoire !"
		: ($ii=66)
			[LesRubriques:21]RubNom:2:="Toxicomanie 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierMedical:29]DM_Toxicomanie2:64)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Toxicomanie suite est obligatoire !"
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