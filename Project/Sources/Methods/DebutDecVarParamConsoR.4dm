//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : DebutDecVarParamConsoR
//{
//{          Lundi 19 juillet 2010 à 16:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283(<>ve_ConsoRMode)
<>ve_ConsoRMode:=0  //Base de Type CHRS : acune action
<>ve_ConsoRMode:=1  //Base de Type 115 : Export vers Régional
<>ve_ConsoRMode:=2  //Base de Type Régionale : Import des données

C_BOOLEAN:C305(<>vb_ConsoRAuto)
C_LONGINT:C283(<>vl_ConsoRAuto)
C_TIME:C306(<>vh_ConsoRAuto1)
C_TIME:C306(<>vh_ConsoRAuto2)
C_TIME:C306(<>vh_ConsoR_Periode)
C_LONGINT:C283(<>ve_ConsoRMinutes)
C_LONGINT:C283(<>vl_ConsoRTicks)
C_TIME:C306(<>vh_ConsoRTicks)
C_BOOLEAN:C305(<>vb_ConsoRServeurAuto)
C_TEXT:C284(<>vt_ConsoRTXT)


C_TEXT:C284(<>va_ConsoR_Chrono)
C_TEXT:C284(<>va_ConsoR_ChronoTrans)
C_TEXT:C284(<>va_ConsoR_Site)