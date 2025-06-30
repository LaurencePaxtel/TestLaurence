//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uItem
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
C_BOOLEAN:C305(vb_Show)
vb_Show:=True:C214
If (vb_Show)
	Général_Hide
End if 

i_Message("Chargement en cours…")
ARRAY TEXT:C222(<>ta_TBItem; 0)


ARRAY TEXT:C222(<>ta_TBItemCerntre; 0)
ARRAY LONGINT:C221(<>tl_TBItemCerntre; 0)
C_LONGINT:C283(<>vl_TBItemCtreID)

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

vd_Item0:=Current date:C33(*)
vd_Item1:=Current date:C33(*)
vd_Item2:=Current date:C33(*)
rJourNuit1:=1
rJourNuit2:=0


C_LONGINT:C283(vl_ItemNb)
vl_ItemNb:=0

C_TEXT:C284(va_Sex)
va_Sex:=""

C_DATE:C307(vd_Néle1; vd_Néle2; vd_Néle3)

vd_Néle1:=!00-00-00!
vd_Néle2:=!00-00-00!
vd_Néle3:=!00-00-00!

C_LONGINT:C283(ve_Age1; ve_Age2)
ve_Age1:=0
ve_Age2:=0

C_TEXT:C284(va_TitItem)
va_TitItem:=""
C_TEXT:C284(va_Item)
va_Item:=""


P_ItemRessources(0; 0)
va_TitItem:=ta_ItemRub{ta_ItemRub}
P_ItemRessources(1; ta_ItemRub)
SORT ARRAY:C229(ta_ItemRub; tp_ItemRub; >)
va_IDT_Typ1:=""
<>ta_TBItem:=1
CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Item")
va_Titre:="Modification d'item"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


ARRAY TEXT:C222(<>ta_TBItemCerntre; 0)
ARRAY LONGINT:C221(<>tl_TBItemCerntre; 0)

<>PR_Item:=0
If (vb_Show)
	Général_Show
End if 
