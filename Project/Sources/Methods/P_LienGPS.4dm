//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uAutreSolD
//{
//{          Vendredi 21 mai 2004 à 09:14:00
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

C_TEXT:C284(vt_LienGPS)


vt_LienGPS:=<>vt_LienGPS
va_Titre:="Paramétrage de l'adresse du lien GPS"
$vl_Fenetre:=i_FenêtreNo(466; 272; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_LienGPS")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
If (vb_Show)
	Général_Show
End if 
<>PR_LienGPS:=0