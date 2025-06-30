//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampAttribut 
//{
//{          Vendredi : 17 août 2001 à 15:46
//{          Modifiée : 17 janvier 2005 à 11:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283(<>STR_ECR_Numero; <>vlSTR; <>vlSTR_HG; <>vlSTR_HG1; <>vlSTR_MR; <>vlSTR_DS; <>vlSTR_AA; <>vlSTR_DI; <>vlSTR_DY; \
<>vlSTR_DM; <>vlSTR_HGE; <>vlSTR_HGEP; <>vlSTR_DE)

ARRAY TEXT:C222(<>ta_vDSLibel; 12)

<>vlSTR:=30100
<>vlSTR_HG:=30101
<>vlSTR_HG1:=30101
<>vlSTR_MR:=30102
<>vlSTR_DS:=30103
<>vlSTR_AA:=30104
<>vlSTR_DI:=30105
<>vlSTR_DY:=30106
<>vlSTR_DM:=30107
<>vlSTR_HGE:=30109
<>vlSTR_HGEP:=30110
<>vlSTR_DE:=30111
<>vlSTR_HGPS:=30112

<>ta_vDSLibel{1}:="Hébergement"
<>ta_vDSLibel{2}:="Maraude"
<>ta_vDSLibel{3}:="Dossier social"
<>ta_vDSLibel{4}:="Actions sociales"
<>ta_vDSLibel{5}:="Dossier infirmier"
<>ta_vDSLibel{6}:="Dossier psycho-social"
<>ta_vDSLibel{7}:="Dossier médical"
<>ta_vDSLibel{8}:="Hébergement Asile"
<>ta_vDSLibel{9}:="Hébergement externe"
<>ta_vDSLibel{10}:="Hébergement externe permanencier"
<>ta_vDSLibel{11}:="Dossier Santé"
<>ta_vDSLibel{12}:="Hébergement Prestations"

TableChamps(0; 0)
TableChampsAttributs(0; 12; 0)

Debut_DecVarChampCharger