//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uConsolidationClient
//{
//{          mardi 7 juillet 2009 à 17:10
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


DébutInitConsoClient(0)




$vl_Fenetre:=i_FenêtreNo(466; 327; 16; "Consolidation client 115"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ConsoClient")
CLOSE WINDOW:C154($vl_Fenetre)


<>PR_ConsoClient:=0
If (vb_Show)
	Général_Show
End if 