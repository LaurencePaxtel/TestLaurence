//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsMR
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Maraude


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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[Maraude:24])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Conseiller"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Conseiller:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du conseiller est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Chef de bord"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_ChefBord:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du chef de bord est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="N° EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_EMA:11)
			[LesRubriques:21]RubAlerte:7:="La saisie du n° EMA est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Nuit ou Jour"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Nuit:2)
			[LesRubriques:21]RubAlerte:7:="La saisie de Nuit ou Jour est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Fiche sociale"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_SocialOK:38)
			[LesRubriques:21]RubAlerte:7:="La saisie de la fiche sociale est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Signalement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Signalt:12)
			[LesRubriques:21]RubAlerte:7:="La saisie du signalement est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Signalement suite"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_SignaltSuite:13)
			[LesRubriques:21]RubAlerte:7:="La saisie du signalement suite est obligatoire !"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Emplacement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Emplacement:14)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'emplacement est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Emplacement 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Emplacement2:78)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'emplacement 2 est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Code postal (arrondisement)"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_ArrondCP:15)
			[LesRubriques:21]RubAlerte:7:="La saisie du code postal (arrondissement) est obligatoire !"
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="Heure début de la rencontre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_HeureDebut:22)
			[LesRubriques:21]RubAlerte:7:="La saisie del'Heure début de la rencontre est obligatoire !"
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Heure fin de la rencontre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_HeureFin:23)
			[LesRubriques:21]RubAlerte:7:="La saisie del'Heure fin de la rencontre est obligatoire !"
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Demande"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Demande:24)
			[LesRubriques:21]RubAlerte:7:="La saisie de la demande est obligatoire !"
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Durée de la rencontre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DuréRencontr:79)
			[LesRubriques:21]RubAlerte:7:="La saisie de la durée de la rencontre est obligatoire !"
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="Motif du refus de prise en charge"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Motif:25)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif du refus de prise en charge est obligatoire !"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_EtatCivil:16)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Identité"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Nom:17)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Prénom:18)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DateNéLe:20)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de  naissance est obligatoire !"
		: ($ii=21)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Age:19)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
		: ($ii=22)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_LieuNéOù:21)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
		: ($ii=23)
			[LesRubriques:21]RubNom:2:="Etat général"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_EtatGénéral:26)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat général est obligatoire !"
		: ($ii=24)
			[LesRubriques:21]RubNom:2:="Etat cutané"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_EtatCutané:27)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat cutané est obligatoire !"
		: ($ii=25)
			[LesRubriques:21]RubNom:2:="Relation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Relation:28)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Relation est obligatoire !"
		: ($ii=26)
			[LesRubriques:21]RubNom:2:="Langue"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Lange1:29)
			[LesRubriques:21]RubAlerte:7:="La saisie de la  Langue 1 est obligatoire !"
		: ($ii=27)
			[LesRubriques:21]RubNom:2:="Langue 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Lange2:30)
			[LesRubriques:21]RubAlerte:7:="La saisie de la  Langue 2 est obligatoire !"
		: ($ii=28)
			[LesRubriques:21]RubNom:2:="Langue 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Lange3:31)
			[LesRubriques:21]RubAlerte:7:="La saisie de la  Langue 3 est obligatoire !"
		: ($ii=29)
			[LesRubriques:21]RubNom:2:="Orientation sociale oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrSocial:35)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation sociale est obligatoire !"
		: ($ii=30)
			[LesRubriques:21]RubNom:2:="Orientation sociale"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrSoc:36)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation sociale 1 est obligatoire !"
		: ($ii=31)
			[LesRubriques:21]RubNom:2:="Orientation sociale 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrSocSuite:37)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation sociale 2 est obligatoire !"
		: ($ii=32)
			[LesRubriques:21]RubNom:2:="Orientation médicale oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrMédical:32)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation médicale est obligatoire !"
		: ($ii=33)
			[LesRubriques:21]RubNom:2:="Orientation médicale"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrMéd:33)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation médicale 1 est obligatoire !"
		: ($ii=34)
			[LesRubriques:21]RubNom:2:="Orientation médicale 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_OrMédSuite:34)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation médicale 2 est obligatoire !"
		: ($ii=35)
			[LesRubriques:21]RubNom:2:="Prise en charge EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_EnChargeEMA:43)
			[LesRubriques:21]RubAlerte:7:="La saisie de la prise en charge est obligatoire !"
		: ($ii=36)
			[LesRubriques:21]RubNom:2:="Motif de Refus de prise en charge"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_RefusEMA:44)
			[LesRubriques:21]RubAlerte:7:="La saisie du refus de la prise en charge est obligatoire !"
		: ($ii=37)
			[LesRubriques:21]RubNom:2:="Dernierlieu d'Hébergement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DernierHéber:45)
			[LesRubriques:21]RubAlerte:7:="La saisie du dernier hébergement est obligatoire !"
		: ($ii=38)
			[LesRubriques:21]RubNom:2:="Dernier lieu d'hébergement : Quand et Où"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DernierHéb1:46)
			[LesRubriques:21]RubAlerte:7:="La saisie du dernier hébergement : Quand est obligatoire !"
		: ($ii=39)
			[LesRubriques:21]RubNom:2:="Dernier lieu d'hébergement : Où"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DernierHéb2:47)
			[LesRubriques:21]RubAlerte:7:="La saisie du dernier hébergement : Où est obligatoire !"
		: ($ii=40)
			[LesRubriques:21]RubNom:2:="Quel mode"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Mode1:48)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode 1  est obligatoire !"
		: ($ii=41)
			[LesRubriques:21]RubNom:2:="Quel mode 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Mode2:49)
			[LesRubriques:21]RubAlerte:7:="La saisie du Mode 2 est obligatoire !"
		: ($ii=42)
			[LesRubriques:21]RubNom:2:="Temps d'errance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_TempsErrance:50)
			[LesRubriques:21]RubAlerte:7:="La saisie du Temps d'errance est obligatoire !"
		: ($ii=43)
			[LesRubriques:21]RubNom:2:="Personne chez qui aller"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Connaissance:51)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Personne chez qui aller est obligatoire !"
		: ($ii=44)
			[LesRubriques:21]RubNom:2:="Compagnie actuelle"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Compagnie:52)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Compagnie actuelle 1 est obligatoire !"
		: ($ii=45)
			[LesRubriques:21]RubNom:2:="Compagnie actuelle 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Compagnie2:53)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Compagnie actuelle 2 est obligatoire !"
		: ($ii=46)
			[LesRubriques:21]RubNom:2:="CADRE Couverture sociale"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE de la Couverture sociale"
		: ($ii=47)
			[LesRubriques:21]RubNom:2:="Couverture sociale oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSocQuest:57)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale est obligatoire !"
		: ($ii=48)
			[LesRubriques:21]RubNom:2:="Couverture sociale 1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc1_1:58)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1_1 est obligatoire !"
		: ($ii=49)
			[LesRubriques:21]RubNom:2:="Couverture sociale 1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc1_2:59)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 1_2 est obligatoire !"
		: ($ii=50)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc2_1:60)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 2_1 est obligatoire !"
		: ($ii=51)
			[LesRubriques:21]RubNom:2:="Couverture sociale 2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc2_2:61)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 2_2 est obligatoire !"
		: ($ii=52)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc3_1:62)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 3_1 est obligatoire !"
		: ($ii=53)
			[LesRubriques:21]RubNom:2:="Couverture sociale 3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_CouvSoc3_2:63)
			[LesRubriques:21]RubAlerte:7:="La saisie de Couverture sociale 3_2 est obligatoire !"
		: ($ii=54)
			[LesRubriques:21]RubNom:2:="CADRE Papier d'identité"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE des Papiers d'identité"
		: ($ii=55)
			[LesRubriques:21]RubNom:2:="Papier d'identité oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_PapiersQuest:54)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité est obligatoire !"
		: ($ii=56)
			[LesRubriques:21]RubNom:2:="Papier d'identité 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Papier1:55)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité 1 est obligatoire !"
		: ($ii=57)
			[LesRubriques:21]RubNom:2:="Papier d'identité 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Papier2:56)
			[LesRubriques:21]RubAlerte:7:="La saisie de Papier d'identité 2 est obligatoire !"
		: ($ii=58)
			[LesRubriques:21]RubNom:2:="CADRE Ressources"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE des Ressources"
		: ($ii=59)
			[LesRubriques:21]RubNom:2:="Ressources oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_ResourcQuest:64)
			[LesRubriques:21]RubAlerte:7:="La saisie de Ressources est obligatoire !"
		: ($ii=60)
			[LesRubriques:21]RubNom:2:="Ressources1_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour1_1:65)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource1_1 est obligatoire !"
		: ($ii=61)
			[LesRubriques:21]RubNom:2:="Ressources1_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour1_2:66)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource1_2 est obligatoire !"
		: ($ii=62)
			[LesRubriques:21]RubNom:2:="Ressources2_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour2_1:67)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource2_1 est obligatoire !"
		: ($ii=63)
			[LesRubriques:21]RubNom:2:="Ressources2_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour2_2:68)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource2_2 est obligatoire !"
		: ($ii=64)
			[LesRubriques:21]RubNom:2:="Ressources3_1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour3_1:69)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource3_1 est obligatoire !"
		: ($ii=65)
			[LesRubriques:21]RubNom:2:="Ressources3_2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Ressour3_2:70)
			[LesRubriques:21]RubAlerte:7:="La saisie de la Ressource3_2 est obligatoire !"
		: ($ii=66)
			[LesRubriques:21]RubNom:2:="CADRE Régime"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE du Régime"
		: ($ii=67)
			[LesRubriques:21]RubNom:2:="Régime oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_RégimeQuest:71)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime est obligatoire !"
		: ($ii=68)
			[LesRubriques:21]RubNom:2:="Régime 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Régime1:72)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime 1 est obligatoire !"
		: ($ii=69)
			[LesRubriques:21]RubNom:2:="Régime 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Régime2:73)
			[LesRubriques:21]RubAlerte:7:="La saisie du Régime 2 est obligatoire !"
		: ($ii=70)
			[LesRubriques:21]RubNom:2:="CADRE Suivi social"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE du Suivi social"
		: ($ii=71)
			[LesRubriques:21]RubNom:2:="Suivi oui/non"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_SuiviSQuest:75)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi est obligatoire !"
		: ($ii=72)
			[LesRubriques:21]RubNom:2:="Suivi 1"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_SuiviS1:76)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi 1 est obligatoire !"
		: ($ii=73)
			[LesRubriques:21]RubNom:2:="Suivi 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_SuiviS2:77)
			[LesRubriques:21]RubAlerte:7:="La saisie du Suivi 2 est obligatoire !"
			
			
		: ($ii=74)
			[LesRubriques:21]RubNom:2:="Hygiène"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Hygiène:81)
			[LesRubriques:21]RubAlerte:7:="La saisie d'hygiene est obligatoire !"
			
		: ($ii=75)
			[LesRubriques:21]RubNom:2:="Handicap"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_Handicap:82)
			[LesRubriques:21]RubAlerte:7:="La saisie du handicap est obligatoire !"
			
		: ($ii=76)
			[LesRubriques:21]RubNom:2:="Detail du motif"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_MotifDétail:83)
			[LesRubriques:21]RubAlerte:7:="La saisie du détail du motif est obligatoire !"
			
		: ($ii=77)
			[LesRubriques:21]RubNom:2:="Date de rencontre"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[Maraude:24]MR_DateRencontre:84)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de rencontre est obligatoire !"
			
	End case 
	[LesRubriques:21]RubSaississable:5:=True:C214
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubVisible:8:=True:C214
	[LesRubriques:21]RubModifiable:10:=True:C214
	[LesRubriques:21]RubDéveloppeur:11:=False:C215
	
	[LesRubriques:21]RubNoSTR:12:=$1
	[LesRubriques:21]RubNomNew:13:=[LesRubriques:21]RubNom:2
	SAVE RECORD:C53([LesRubriques:21])
	
	UNLOAD RECORD:C212([LesRubriques:21])
End for 
READ ONLY:C145([LesRubriques:21])