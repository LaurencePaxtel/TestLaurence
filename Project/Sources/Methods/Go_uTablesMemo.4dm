//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesTType
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
i_Message("Chargement en cours…")
C_LONGINT:C283(vL_Nb_HG_F; $vl_EcranL)
C_BOOLEAN:C305(vb_OK)
vb_OK:=False:C215
C_TEXT:C284(vt_Champs)
vt_Champs:=""
C_LONGINT:C283(ve_Genre; ve_GenreHB)
ve_Genre:=0
ve_GenreHB:=-1

C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)

CLOSE WINDOW:C154

va_Titre:="Liste des Mémos : "
READ ONLY:C145([MemO:30])
FORM SET OUTPUT:C54([MemO:30]; "V_Développeur")
ALL RECORDS:C47([MemO:30])
MultiSoc_Filter(->[MemO:30])
vL_Nb_HG_F:=Records in selection:C76([MemO:30])
FIRST RECORD:C50([MemO:30])
If (<>vl_EcranL>(771+15))
	$vl_EcranL:=(771+15)
Else 
	$vl_EcranL:=<>vl_EcranL-10
End if 
$vl_Fenetre:=i_FenêtreNo($vl_EcranL; <>vl_EcranH-60; 8; va_Titre+String:C10(vL_Nb_HG_F); 1; "Quit_Simple")
DISPLAY SELECTION:C59([MemO:30]; *)
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesM0:=0
If (vb_Show)
	Général_Show
End if 