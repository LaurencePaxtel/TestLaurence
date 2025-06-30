//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uSignalD
//{
//{          Lundi 2 février 2004 à 11:00:00
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
C_TEXT:C284(va_TxtTemp)

va_Titre:="Signalements liés aux touches F1 F2 F3"
$vl_Fenetre:=i_FenêtreNo(466; 252; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_SignalDef")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_SigltD:=0
If (vb_Show)
	Général_Show
End if 