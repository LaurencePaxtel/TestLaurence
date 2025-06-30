//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DisposSomme
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
//Général_Hide 
C_DATE:C307($1)

C_LONGINT:C283(vl_CHCapaJ)
C_LONGINT:C283(vl_CHCapaN)

C_LONGINT:C283(vl_CHRepor)
C_LONGINT:C283(vl_CHReporJ)
C_LONGINT:C283(vl_CHReporN)

C_LONGINT:C283(vl_CHDispjJ)
C_LONGINT:C283(vl_CHDispjN)
C_LONGINT:C283(vl_CHDispTJ)
C_LONGINT:C283(vl_CHDispTN)

C_LONGINT:C283(vl_CHDistrJ)
C_LONGINT:C283(vl_CHDistrN)


C_LONGINT:C283(vl_CHRest)
C_LONGINT:C283(vl_CHRestJ)
C_LONGINT:C283(vl_CHRestN)
C_LONGINT:C283(vl_CHReste)
C_LONGINT:C283(vl_CHResteJ)
C_LONGINT:C283(vl_CHResteN)


C_LONGINT:C283(vl_CHWait)
C_LONGINT:C283(vl_CHWaitN)
C_LONGINT:C283(vl_CHWaitJ)


C_LONGINT:C283(vl_CHDispo)
C_LONGINT:C283(vl_CHAttrib)
C_LONGINT:C283(vl_CHDistri)
C_LONGINT:C283(vl_CHReste)
C_LONGINT:C283(vl_CHDispoN)
C_LONGINT:C283(vl_CHAttriN)
C_LONGINT:C283(vl_CHDistrN)
C_LONGINT:C283(vl_CHRestN)
C_LONGINT:C283(vl_Page)

C_LONGINT:C283(vl_CHResteJ)
C_LONGINT:C283(vl_CHResteN)

C_LONGINT:C283(vl_Attente)
C_LONGINT:C283(vl_AttenteN)
C_LONGINT:C283(vl_AttenteJ)
C_DATE:C307(vd_DtJour)
C_TEXT:C284(va_DateType)
vd_DtJour:=$1
<>vd_DtJour:=$1
<>va_RepE:=""  //Libellé du Report effectué



va_Titre:="Disponibilités"
Rec_CL_DispoCalc(vd_DtJour)
$vl_Fenetre:=i_FenêtreNo(532; 330; 16; va_Titre; 18; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_CtrDispoSomme")
CLOSE WINDOW:C154


<>PR_Disponible:=0
//Général_Show 