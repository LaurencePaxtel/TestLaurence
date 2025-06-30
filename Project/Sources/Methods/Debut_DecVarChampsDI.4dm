//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsDI
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Dossier infirmier

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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[DossierInfirmie:27])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Responsable"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Responsable:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du responsable est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Infirmier"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Infirmier:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'infirmier est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="N° EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_EMA:11)
			[LesRubriques:21]RubAlerte:7:="La saisie du N° EMA est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_EtatCivil:12)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Nom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Nom:13)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Prénom:14)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_DateNéLe:16)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de naissance est obligatoire !"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Age:15)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_LieuNéOù:17)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Vu le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_VuLe:2)
			[LesRubriques:21]RubAlerte:7:="La saisie de vu le est obligatoire !"
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="Motif de la prise en charge"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_ChargeMotif:19)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif de la prise en charge est obligatoire !"
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Etat cutané"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_EtatCutané:21)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat cutané est obligatoire !"
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Indices"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_IndicesTypes:23)
			[LesRubriques:21]RubAlerte:7:="La saisie des indices est obligatoire !"
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Dépendances"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_DépendTypes:25)
			[LesRubriques:21]RubAlerte:7:="La saisie des Dépendances est obligatoire !"
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="Date Hôpital"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_HospitalDate:26)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de l'hospitalisation est obligatoire !"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="Lieu de la dernière hospitalisation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_HospitalLieu:27)
			[LesRubriques:21]RubAlerte:7:="La saisie de la prise en charge EMA est obligatoire !"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Date lit infirmier"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_LitDate:28)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date du lit infirmier est obligatoire !"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Lieu du dernier séjour en lit infirmier"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_LitLieu:29)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu du lit infirmier est obligatoire !"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Pathologies"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_PathoTypes:31)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu des Pathologies est obligatoire !"
		: ($ii=21)
			[LesRubriques:21]RubNom:2:="Traitement en cours"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Traitement1:32)
			[LesRubriques:21]RubAlerte:7:="La saisie du traitement 1 est obligatoire !"
		: ($ii=22)
			[LesRubriques:21]RubNom:2:="Traitement 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Traitement2:33)
			[LesRubriques:21]RubAlerte:7:="La saisie du traitement 2 est obligatoire !"
		: ($ii=23)
			[LesRubriques:21]RubNom:2:="Traitement 3"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierInfirmie:27]DI_Traitement3:34)
			[LesRubriques:21]RubAlerte:7:="La saisie du traitement 3 est obligatoire !"
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