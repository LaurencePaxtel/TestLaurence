//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG110
//{
//{          Vendredi 31 octobre 2008 à 13:21
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement

C_LONGINT:C283($1)
C_LONGINT:C283($2)

READ WRITE:C146([LesRubriques:21])
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$1; *)
QUERY:C277([LesRubriques:21];  & ; [LesRubriques:21]NuméroTri:1=110)
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])=1)
	[LesRubriques:21]RubOrdreSaisie:14:=110
	[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
	
	
	
	[LesRubriques:21]RubSaississable:5:=False:C215
	[LesRubriques:21]RubObligatoire:6:=False:C215
	[LesRubriques:21]RubVisible:8:=False:C215
	[LesRubriques:21]RubPopVisible:9:=False:C215
	[LesRubriques:21]RubModifiable:10:=False:C215
	[LesRubriques:21]RubDéveloppeur:11:=True:C214
	
	
	[LesRubriques:21]RubNom:2:="DateCréationFiche"
	[LesRubriques:21]RubNomNew:13:="Date de création de la fiche"
	[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)
	[LesRubriques:21]RubAlerte:7:="Champ réservé"
	SAVE RECORD:C53([LesRubriques:21])
End if 


UNLOAD RECORD:C212([LesRubriques:21])
READ ONLY:C145([LesRubriques:21])
