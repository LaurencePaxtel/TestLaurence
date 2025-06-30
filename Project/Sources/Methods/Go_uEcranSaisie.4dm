//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uEcranSaisie
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)

C_LONGINT:C283(vl_vDSLibel)
C_BOOLEAN:C305(vb_Show)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215

If (vb_Show)
	Général_Hide
End if 

i_Message("Chargement en cours…")

vl_vDSLibel:=0

<>ta_vDSLibel:=1
vl_vDSLibel:=1

<>ta_vDSLibel{0}:=<>ta_vDSLibel{1}
TableChamps(2; 1)

CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_EcranSaisie")  // #HPOP2017

va_Titre:="Statut et attributs des champs"

$vl_Fenetre:=i_FenêtreNo(1200; 600; 4; va_Titre; 1; "")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur

CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145([DiaLogues:3])

<>PR_Rubrique:=0

If (vb_Show)
	Général_Show
End if 