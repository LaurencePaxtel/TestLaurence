//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_uConsolidationRGClient
//{          Vendrdi 28 janvier 2011 à 17:00
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


DébutInitConsoR(0)


$vl_Fenetre:=i_FenêtreNo(466; 327; 16; "Consolidation régionale client"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ConsoRGClient")
CLOSE WINDOW:C154($vl_Fenetre)


<>PR_ConsoRGClient:=0
If (vb_Show)
	Général_Show
End if 