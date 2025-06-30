//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesDocumentsTableau
//{          Lundi 15 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=True:C214
C_LONGINT:C283($1)
C_LONGINT:C283($2)
ARRAY TEXT:C222(ta_Conso_P_Titre; $1)
ARRAY TEXT:C222(ta_Conso_P_Valeur; $1)
ARRAY INTEGER:C220(te_Conso_P_Table; $1)
ARRAY INTEGER:C220(te_Conso_P_Champ; $1)
ARRAY INTEGER:C220(te_Conso_P_ChampType; $1)

ARRAY TEXT:C222(ta_Conso_H_Titre; $2)
ARRAY TEXT:C222(ta_Conso_H_Valeur; $2)
ARRAY INTEGER:C220(te_Conso_H_Table; $2)
ARRAY INTEGER:C220(te_Conso_H_Champ; $2)
ARRAY INTEGER:C220(te_Conso_H_ChampType; $2)