//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_TransfertReport
//{
//{          Jeudi 4 décembre 2008 à 14:42
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


SET MENU BAR:C67(1)
READ ONLY:C145(*)
MESSAGES OFF:C175
C_DATE:C307(vd_Date1)
C_LONGINT:C283(vl_ii)
C_LONGINT:C283($vl_Fenetre; vl_Fiches)
C_TEXT:C284(va_Titre; va_DateMaJ)
va_DateMaJ:=""
vl_Fiches:=0

C_BOOLEAN:C305(vb_ReporEnCours)
vb_ReporEnCours:=False:C215

vd_Date1:=Current date:C33
P_TransfertReportFind

If (7=8)  //Pour les test
	$vb_T_ModeCHRS:=<>vb_T_ModeCHRS
	$vb_T_FullDuplex:=<>vb_T_FullDuplex
	<>vb_T_ModeCHRS:=True:C214
	<>vb_T_FullDuplex:=True:C214
End if 


va_Titre:="Reprise du transfert"
$vl_Fenetre:=i_FenêtreNo(466; 266; 16; va_Titre; 3; "Quit_TransReport")
DIALOG:C40([DiaLogues:3]; "DL_TransReport")
CLOSE WINDOW:C154($vl_Fenetre)

If (7=8)  //Pour les test
	<>vb_T_ModeCHRS:=$vb_T_ModeCHRS
	<>vb_T_FullDuplex:=$vb_T_FullDuplex
End if 



<>PR_TransReport:=0


