//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesRU
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

C_LONGINT:C283(vL_Nb_HG_F; $vl_EcranL)
C_BOOLEAN:C305(vb_OK)
vb_OK:=False:C215



va_Titre:="Liste des fiches [RéférenceUnique]: "
READ ONLY:C145([ReferenceUnique:2])
FORM SET OUTPUT:C54([ReferenceUnique:2]; "V_Développeur")
ALL RECORDS:C47([ReferenceUnique:2])
MultiSoc_Filter(->[ReferenceUnique:2])
vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
FIRST RECORD:C50([ReferenceUnique:2])
$vl_EcranL:=522+15

$vl_Fenetre:=i_FenêtreNo($vl_EcranL; <>vl_EcranH-60; 8; va_Titre+String:C10(vL_Nb_HG_F); 1; "Quit_Simple")
DISPLAY SELECTION:C59([ReferenceUnique:2]; *)
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesRU:=0
If (vb_Show)
	Général_Show
End if 