//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDecVarParamRepAuto2
//{
//{          Vendrdi 9 janvier 2009 à 15:00
//{          Modifiée : Vendrdi 9 janvier 2009 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TIME:C306(vh_ReportAuto1)
C_TIME:C306(vh_ReportAuto2)
C_LONGINT:C283(<>vl_ReportAutoTicks)
C_TIME:C306(<>vh_ReportTicks)
<>vh_ReportTicks:=?00:00:00?
C_TEXT:C284(<>vt_ReportTXT)
<>vt_ReportTXT:=""