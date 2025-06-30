//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampsHG5
//{
//{          Jeudi 5 juillet 2007 à 11:08
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Hébergement

C_LONGINT:C283($1)

READ WRITE:C146([LesRubriques:21])

CREATE RECORD:C68([LesRubriques:21])
MultiSoc_Init_Structure(->[LesRubriques:21])
[LesRubriques:21]NuméroTri:1:=99
[LesRubriques:21]RubOrdreSaisie:14:=99
[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])

[LesRubriques:21]RubNom:2:="Participation"
[LesRubriques:21]RubNomNew:13:="Participation"
[LesRubriques:21]RubNuméro:4:=Field:C253(->[HeberGement:5]HG_Participation:138)
[LesRubriques:21]RubAlerte:7:=""


[LesRubriques:21]RubSaississable:5:=True:C214
[LesRubriques:21]RubObligatoire:6:=False:C215
[LesRubriques:21]RubVisible:8:=True:C214
[LesRubriques:21]RubPopVisible:9:=True:C214
[LesRubriques:21]RubModifiable:10:=True:C214
[LesRubriques:21]RubDéveloppeur:11:=False:C215

[LesRubriques:21]RubNoSTR:12:=$1
SAVE RECORD:C53([LesRubriques:21])

UNLOAD RECORD:C212([LesRubriques:21])

READ ONLY:C145([LesRubriques:21])