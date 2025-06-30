//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_uConsoTransfert
//{          Mercredi 16 mai 2012 à 11:30
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



P_Conso_Transfert("Declarer")
//DebutInitConsoTranfert (0)


$vl_Fenetre:=i_FenêtreNo(585; 462; 16; "Consolidation Transfert vers 115"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ConsoTransfert")
CLOSE WINDOW:C154($vl_Fenetre)




<>PR_ConsoTransfert:=0
If (vb_Show)
	Général_Show
End if 