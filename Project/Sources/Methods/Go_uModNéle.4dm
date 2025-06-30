//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uModNéle  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
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


C_TEXT:C284(va_IDT_Typ1)
va_IDT_Typ1:=""

C_DATE:C307(vd_Item0)
C_DATE:C307(vd_Item1)
C_DATE:C307(vd_Item2)
vd_Item0:=!00-00-00!
vd_Item1:=!00-00-00!
vd_Item2:=!00-00-00!

C_LONGINT:C283(vl_ItemNb)
vl_ItemNb:=0

C_TEXT:C284(va_Sex)
va_Sex:=""



READ WRITE:C146([DiaLogues:3])
va_Titre:="Modification des date de naissance"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Simple")
FORM SET INPUT:C55([DiaLogues:3]; "DL_NéleMod")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_ModNé:=0

If (vb_Show)
	Général_Show
End if 
