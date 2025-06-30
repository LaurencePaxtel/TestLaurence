//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uReportAUTO
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
i_Message("Chargement en cours…")

C_BOOLEAN:C305(<>vb_QuitterR)
<>vb_QuitterR:=False:C215

C_BOOLEAN:C305(vb_Quitter)
vb_Quitter:=True:C214


vh_ReportTicks:=?00:00:00?
vt_ReportTXT:=""
C_LONGINT:C283($ii)
$ii:=0
DébutInitReportAuto(0)

vh_ReportTicks:=vl_ReportAutoTicks/60
CLOSE WINDOW:C154

va_Titre:="Reports AUTOMATIQUES"
$vl_Fenetre:=i_FenêtreNo(466; 402; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ReportAUTO")
CLOSE WINDOW:C154($vl_Fenetre)


PR_ReportAUTO:=0
If (vb_Show)
	Général_Show
End if 