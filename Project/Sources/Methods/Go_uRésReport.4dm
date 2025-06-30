//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uRésReport
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ WRITE:C146(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

ARRAY TEXT:C222(<>ta_TBItem; 0)
C_LONGINT:C283(ve_PosTB)
C_LONGINT:C283(ve_PosRub)

C_TEXT:C284(va_IDT_Typ1)
C_TEXT:C284(va_IDT_Typ2)

C_DATE:C307(vd_Item0)
C_DATE:C307(vd_Item1)
C_DATE:C307(vd_Item2)
vd_Item0:=!00-00-00!
vd_Item1:=!00-00-00!
vd_Item2:=!00-00-00!
C_LONGINT:C283(vl_ItemNb; vl_IDT_ID)
vl_ItemNb:=0
vl_IDT_ID:=0
C_TEXT:C284(va_FichesNb)
va_FichesNb:="0 fiche(s)"
C_TEXT:C284(va_Sex; va_Rés)
va_Sex:=""
va_Rés:=""
C_DATE:C307(vd_Néle1; vd_Néle2; vd_Néle3)

vd_Néle1:=!00-00-00!
vd_Néle2:=!00-00-00!
vd_Néle3:=!00-00-00!


C_TEXT:C284(va_Item)
va_Item:=""
ve_PosRub:=1

C_LONGINT:C283(rJourNuit1; rJourNuit2)
vd_Item0:=Current date:C33(*)
vd_Item1:=Current date:C33(*)
vd_Item2:=Current date:C33(*)
rJourNuit1:=1
rJourNuit2:=0


READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_RésReport")
va_Titre:="Modification des reports"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_RésReport:=0
If (vb_Show)
	Général_Show
End if 