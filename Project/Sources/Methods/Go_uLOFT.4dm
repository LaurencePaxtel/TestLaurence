//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uLOFT
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
C_TEXT:C284(va_CtrLib)
va_CtrLib:=""

va_RH_Typ1:=""
va_RH_Typ2:=""
vl_RH_RéfID:=0
vb_RH_Médic:=False:C215
va_RH_PlateF:=""

C_LONGINT:C283($ii)
$ii:=0
DébutInitLoft(0)
CLOSE WINDOW:C154

va_Titre:="Centre d'hébergement LOFT"
$vl_Fenetre:=i_FenêtreNo(466; 252; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_CentreLOFT")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_LOFT:=0
If (vb_Show)
	Général_Show
End if 