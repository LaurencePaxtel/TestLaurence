//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uMaxFiche
//{
//{          Jeudi 2 août 2007 à 10:44:00
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

va_Titre:="Nombre maximum de fiches d'hébergement"
$vl_Fenetre:=i_FenêtreNo(466; 192; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_MaxFiche")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_MaxFiche:=0
If (vb_Show)
	Général_Show
End if 