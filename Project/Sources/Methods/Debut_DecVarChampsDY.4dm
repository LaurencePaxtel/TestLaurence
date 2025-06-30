//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsDY
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Psycho-social

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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[DossierPsycho:28])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="Responsable"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Responsable:7)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom du responsable est obligatoire !"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Opérateur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Opérateur:8)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'opérateur est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Infirmier"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Infirmier:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom de l'infirmier est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="N° EMA"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_EMA:11)
			[LesRubriques:21]RubAlerte:7:="La saisie du N° EMA est obligatoire !"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Etat civil"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_EtatCivil:12)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'état civil est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Nom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Nom:13)
			[LesRubriques:21]RubAlerte:7:="La saisie du nom est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Prénom"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Prénom:14)
			[LesRubriques:21]RubAlerte:7:="La saisie du prénom est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="Date de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_DateNéLe:16)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de naissance est obligatoire !"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Age"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Age:15)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'age est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Lieu de naissance"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_LieuNéOù:17)
			[LesRubriques:21]RubAlerte:7:="La saisie du lieu de naissance est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Vu le"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_VuLe:2)
			[LesRubriques:21]RubAlerte:7:="La saisie de vu le est obligatoire !"
		: ($ii=12)
			[LesRubriques:21]RubNom:2:="Motif de la prise en charge"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_ChargeMotif:19)
			[LesRubriques:21]RubAlerte:7:="La saisie du Motif de la prise en charge est obligatoire !"
		: ($ii=13)
			[LesRubriques:21]RubNom:2:="Etat psychiatrique et souffrance psychique"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_EtatPsyTypes:23)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'Etat psychiatrique est obligatoire !"
		: ($ii=14)
			[LesRubriques:21]RubNom:2:="Antécédents"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_AntéTypes:21)
			[LesRubriques:21]RubAlerte:7:="La saisie des Antécédents est obligatoire !"
		: ($ii=15)
			[LesRubriques:21]RubNom:2:="Suivi secteur"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_SuiviSecteur:24)
			[LesRubriques:21]RubAlerte:7:="La saisie du suivi secteur est obligatoire !"
		: ($ii=16)
			[LesRubriques:21]RubNom:2:="Suivi lieu"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_SuiviLieu:25)
			[LesRubriques:21]RubAlerte:7:="La saisie du suivi lieu est obligatoire !"
		: ($ii=17)
			[LesRubriques:21]RubNom:2:="Suivi médecin"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_SuiviMédecin:26)
			[LesRubriques:21]RubAlerte:7:="La saisie du suivi médecin est obligatoire !"
		: ($ii=18)
			[LesRubriques:21]RubNom:2:="Suivi Ressources"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_SuiviRessour:27)
			[LesRubriques:21]RubAlerte:7:="La saisie du suivi ressources est obligatoire !"
		: ($ii=19)
			[LesRubriques:21]RubNom:2:="Orientation"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Orientation1:28)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation 1 est obligatoire !"
		: ($ii=20)
			[LesRubriques:21]RubNom:2:="Orientation 2"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[DossierPsycho:28]DY_Orientation2:30)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'orientation 2 est obligatoire !"
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