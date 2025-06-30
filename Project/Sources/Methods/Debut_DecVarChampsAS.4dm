//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsAS
//{
//{          Vendredi 17 aôut 2001 à 15:46
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Actions sociales

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
	[LesRubriques:21]RubFichier:3:=Table:C252(->[ActionSociale:26])
	Case of 
		: ($ii=1)
			[LesRubriques:21]RubNom:2:="CADRE Domaine"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Domaine"
		: ($ii=2)
			[LesRubriques:21]RubNom:2:="Domaine"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_Domaine:3)
			[LesRubriques:21]RubAlerte:7:="La saisie du domaine est obligatoire !"
		: ($ii=3)
			[LesRubriques:21]RubNom:2:="Evénement"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_Evénement:4)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'évenement est obligatoire !"
		: ($ii=4)
			[LesRubriques:21]RubNom:2:="CADRE Demandé"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Demandé"
		: ($ii=5)
			[LesRubriques:21]RubNom:2:="Demandé"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_Demande:5)
			[LesRubriques:21]RubAlerte:7:="La saisie de la demande est obligatoire !"
		: ($ii=6)
			[LesRubriques:21]RubNom:2:="Date"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_DateDemande:7)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de la demande est obligatoire !"
		: ($ii=7)
			[LesRubriques:21]RubNom:2:="Libellé"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_LibDemande:6)
			[LesRubriques:21]RubAlerte:7:="La saisie du libellé de la demande est obligatoire !"
		: ($ii=8)
			[LesRubriques:21]RubNom:2:="CADRE Obtenu"
			[LesRubriques:21]RubNuméro:4:=0
			[LesRubriques:21]RubAlerte:7:="CADRE Obtenu"
		: ($ii=9)
			[LesRubriques:21]RubNom:2:="Obtenu"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_Obtention:8)
			[LesRubriques:21]RubAlerte:7:="La saisie de l'obtenu est obligatoire !"
		: ($ii=10)
			[LesRubriques:21]RubNom:2:="Date"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_DateObtentio:10)
			[LesRubriques:21]RubAlerte:7:="La saisie de la date de l'obtenu est obligatoire !"
		: ($ii=11)
			[LesRubriques:21]RubNom:2:="Libellé"
			[LesRubriques:21]RubNuméro:4:=Field:C253(->[ActionSociale:26]AA_LibObtention:9)
			[LesRubriques:21]RubAlerte:7:="La saisie du libellé de l'obtenu est obligatoire !"
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