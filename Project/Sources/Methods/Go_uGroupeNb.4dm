//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uGroupeNb
//{
//{          Lundi 8 mars 2004 à 18:50:00
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

va_Titre:="Nombre maximum de membres par familles et groupes"
$vl_Fenetre:=i_FenêtreNo(466; 192; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_GroupeNb")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_GpeNb:=0
If (vb_Show)
	Général_Show
End if 