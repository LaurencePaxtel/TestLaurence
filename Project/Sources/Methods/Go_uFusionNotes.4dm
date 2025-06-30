//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : ◊PR_FusionNotes
//{
//{          Lundi 14 février 2005 à 14:19:00
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

C_BOOLEAN:C305(vb_FusNote_Notes)
C_DATE:C307(vd_FusNote_Date)


va_Titre:="Fusion : Paramètres"
$vl_Fenetre:=i_FenêtreNo(466; 266; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_FusionNotes")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_FusionNotes:=0
If (vb_Show)
	Général_Show
End if 

