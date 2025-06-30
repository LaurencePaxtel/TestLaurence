//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uFusion
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

C_TEXT:C284(va_IDT_Typ1)
C_TEXT:C284(va_IDT_Typ2)
C_LONGINT:C283(vl_IDT_Réf1)
C_LONGINT:C283(vl_IDT_Réf2)
va_IDT_Typ1:=""
va_IDT_Typ2:=""
vl_IDT_Réf1:=0
vl_IDT_Réf2:=0

C_TEXT:C284(va_FusNom)
C_TEXT:C284(va_FusPré)
C_DATE:C307(vd_FusNé)
C_BOOLEAN:C305(vb_FusSex)

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Fusion")
va_Titre:="Fusion des doublons"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_Fusion:=0
If (vb_Show)
	Général_Show
End if 
