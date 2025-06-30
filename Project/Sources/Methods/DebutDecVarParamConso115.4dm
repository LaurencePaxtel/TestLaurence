//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDecVarParamConso115
//{
//{          Vendredi 7 novembre 2008 à 13:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305(<>vb_Conso115Auto)
C_LONGINT:C283(<>vl_Conso115Auto)
C_TIME:C306(<>vh_Conso115Auto1)
C_TIME:C306(<>vh_Conso115Auto2)
C_LONGINT:C283(<>ve_Conso115Minutes)
C_LONGINT:C283(<>vl_Conso115Ticks)
C_TIME:C306(<>vh_Conso115Ticks)
C_BOOLEAN:C305(<>vb_Conso115ServeurAuto)


C_BOOLEAN:C305(<>vb_Conso115Clt)
C_LONGINT:C283(<>vl_Conso115Clt)
C_TIME:C306(<>vh_Conso115Clt1)
C_TIME:C306(<>vh_Conso115Clt2)
C_LONGINT:C283(<>ve_Conso115CltMinutes)
C_LONGINT:C283(<>vl_Conso115CltTicks)
C_TIME:C306(<>vh_Conso115CltTicks)
C_BOOLEAN:C305(<>vb_Conso115ServeurCltAuto)



C_LONGINT:C283(<>ve_Conso115Di)
C_LONGINT:C283(<>ve_Conso115Lu)
C_LONGINT:C283(<>ve_Conso115Ma)
C_LONGINT:C283(<>ve_Conso115Me)
C_LONGINT:C283(<>ve_Conso115Je)
C_LONGINT:C283(<>ve_Conso115Ve)
C_LONGINT:C283(<>ve_Conso115Sa)
C_TEXT:C284(<>vt_Conso115TXT)


C_TEXT:C284(<>vt_Buffer)
C_TEXT:C284(<>vt_Conso_Chemin)
C_TEXT:C284(<>vt_Conso_CheminDossier)
C_TEXT:C284(<>vt_Conso_Dossier)
C_TEXT:C284(<>t_Conso_Document)
C_TEXT:C284(<>vt_Conso_Titre)


C_TEXT:C284(<>va_Conso_FicheSiteCode)
C_TEXT:C284(<>va_Conso_FicheSite)
C_DATE:C307(<>vd_Conso_FicheDate)
C_TEXT:C284(<>va_Conso_FicheJour)
C_TEXT:C284(<>va_Conso_FicheNo)
C_TEXT:C284(<>va_Conso_FicheET)
C_TEXT:C284(<>va_Conso_FicheGenre)
C_TEXT:C284(<>va_Conso_FicheAge)


C_LONGINT:C283(<>vl_Conso_Lignes)
ARRAY INTEGER:C220(<>te_Conso_Ligne; 0)
ARRAY TEXT:C222(<>tt_Conso_LeDocument; 0)
ARRAY TEXT:C222(<>ta_Conso_Titre; 0)
ARRAY TEXT:C222(<>tt_Conso_Valeur; 0)
ARRAY INTEGER:C220(<>te_Conso_Table; 0)
ARRAY INTEGER:C220(<>te_Conso_Champ; 0)
ARRAY INTEGER:C220(<>te_Conso_ChampType; 0)
ARRAY TEXT:C222(<>ta_Conso_ChampType; 0)


C_TEXT:C284(<>va_Conso_Chrono)
C_TEXT:C284(<>va_Conso_ChronoTrans)
C_TEXT:C284(<>va_ConsoR_ChronoTrans)