//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesRB
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
CLOSE WINDOW:C154

va_Titre:="Liste des attributs des champs : "
READ ONLY:C145([LesRubriques:21])
FORM SET OUTPUT:C54([LesRubriques:21]; "V_Développeur")
ALL RECORDS:C47([LesRubriques:21])
MultiSoc_Filter(->[LesRubriques:21])
vL_Nb_HG_F:=Records in selection:C76([LesRubriques:21])
FIRST RECORD:C50([LesRubriques:21])
If (<>vl_EcranL>(1148+15))
	$vl_EcranL:=(1148+15)
Else 
	$vl_EcranL:=<>vl_EcranL-10
End if 
$vl_Fenetre:=i_FenêtreNo($vl_EcranL; <>vl_EcranH-60; 8; va_Titre+String:C10(vL_Nb_HG_F); 1; "Quit_Simple")
DISPLAY SELECTION:C59([LesRubriques:21]; *)
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesRB:=0
If (vb_Show)
	Général_Show
End if 