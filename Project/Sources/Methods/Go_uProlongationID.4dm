//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uProlongationID
//{
//{          Samedi 18 septembre 2004 à 13:27:00
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

C_LONGINT:C283(ve_ProLg_Le; ve_ProLg_MaxMois)

va_Titre:="Prolongations : Paramètres"
$vl_Fenetre:=i_FenêtreNo(466; 266; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ProlongationID")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_ProlongationID:=0
If (vb_Show)
	Général_Show
End if 

