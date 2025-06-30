//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG100
//{
//{          Jeudi 3 janvier 2008 à 16:22
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement

C_LONGINT:C283($1)

READ WRITE:C146([LesRubriques:21])
CREATE RECORD:C68([LesRubriques:21])
MultiSoc_Init_Structure(->[LesRubriques:21])
[LesRubriques:21]NuméroTri:1:=100
[LesRubriques:21]RubOrdreSaisie:14:=100
[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])

[LesRubriques:21]RubNoSTR:12:=$1

[LesRubriques:21]RubNom:2:="Plateforme"
[LesRubriques:21]RubNomNew:13:="Plateforme"
[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Plateforme:139)
[LesRubriques:21]RubAlerte:7:="La saisie de la Plateforme est obligatoire !"


[LesRubriques:21]RubSaississable:5:=True:C214
[LesRubriques:21]RubObligatoire:6:=False:C215
[LesRubriques:21]RubVisible:8:=True:C214
[LesRubriques:21]RubPopVisible:9:=False:C215
[LesRubriques:21]RubModifiable:10:=True:C214
[LesRubriques:21]RubDéveloppeur:11:=False:C215


SAVE RECORD:C53([LesRubriques:21])
UNLOAD RECORD:C212([LesRubriques:21])
READ ONLY:C145([LesRubriques:21])