//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uPointage
//{
//{          Lundi 12 janvier 2009 à 18:31:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284(va_CtrLib)
C_BOOLEAN:C305(vb_Show)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215

If (vb_Show)
	Général_Hide
End if 

i_Message("Chargement en cours...")

va_CtrLib:=""
va_RH_Typ1:=""
va_RH_Typ2:=""
va_RH_PlateF:=""
va_RH_FMGroupe:=""

vl_RH_RéfID:=0

vb_RH_Médic:=False:C215

DébutInitPointage(0)
CLOSE WINDOW:C154

va_Titre:="Prestation par défaut pour Pointage"
$vl_Fenetre:=i_FenêtreNo(466; 252; 16; va_Titre; 3; "Quit_Simple")

DIALOG:C40([DiaLogues:3]; "DL_PrestaPointage")
CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145([DiaLogues:3])
<>PR_Pointage:=0

If (vb_Show)
	Général_Show
End if 