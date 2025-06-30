//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportReport
//{
//{          Mardi 3 février 2009 à 15:12:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307(vd_ExportReport)
C_DATE:C307(vd_ExportReportD; vd_ExportReportF)
C_LONGINT:C283(vl_ExportReport; vl_ExportJours)
C_LONGINT:C283(vl_ExportReportF1151; vl_ExportReportF1152)
C_BOOLEAN:C305(vb_ExportReportF115)
C_TEXT:C284(va_ExportReportPlateforme)
va_ExportReportPlateforme:=""
vb_ExportReport115:=(<>ve_T_CentreCode=0)
vl_ExportReportF1151:=Num:C11(vb_ExportReport115=True:C214)
vl_ExportReportF1152:=Num:C11(vb_ExportReport115=False:C215)

vd_ExportReport:=Current date:C33
vd_ExportReportD:=Current date:C33
vd_ExportReportF:=Current date:C33
vl_ExportReport:=0
vl_ExportJours:=(vd_ExportReportF-vd_ExportReportD)+1
va_Titre:="Export du  report"
$vl_Fenetre:=i_FenêtreNo(516; 282; 16; va_Titre; 2; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ExportReport")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])