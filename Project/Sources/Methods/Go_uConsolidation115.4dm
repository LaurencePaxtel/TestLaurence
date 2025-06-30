//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uConsolidation115
//{
//{          Venderdi 7 novembre 2008 à 10:20
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
<>vh_Conso115Ticks:=?00:00:00?
<>vt_Conso115TXT:=""
DébutInitConso115(0)

$vl_Fenetre:=i_FenêtreNo(466; 432; 16; "Consolidation 115"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_Conso115")
CLOSE WINDOW:C154($vl_Fenetre)




<>PR_ConsoParam:=0
If (vb_Show)
	Général_Show
End if 