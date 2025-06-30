//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDecVarParamRepAuto
//{
//{          Vendrdi 31 octobre 2008 à 15:00
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_LONGINT:C283(<>vl_ReportAuto)
C_LONGINT:C283(<>vl_ReportAutoTicks)
C_TIME:C306(<>vh_ReportTicks)
C_LONGINT:C283(<>ve_ReportAutoDi)
C_LONGINT:C283(<>ve_ReportAutoLu)
C_LONGINT:C283(<>ve_ReportAutoMa)
C_LONGINT:C283(<>ve_ReportAutoMe)
C_LONGINT:C283(<>ve_ReportAutoJe)
C_LONGINT:C283(<>ve_ReportAutoVe)
C_LONGINT:C283(<>ve_ReportAutoSa)
C_TEXT:C284(<>vt_ReportTXT)
var vb_ReportAuto : Boolean
vb_ReportAuto:=False:C215
<>vh_ReportTicks:=?00:00:00?
<>vt_ReportTXT:=""