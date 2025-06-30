//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uConsolidation115Voir
//{
//{          Venderdi 14 novembre 2008 à 15:20
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
P_VarParamConsoVoir(1)
P_VarParamConsoVoir(2)
C_TEXT:C284(vt_TitreDocument; vt_FullDuplexDossier)

C_TEXT:C284(vt_DTitreDocument; vt_DTitreDocumentLu)
vt_TitreDocument:=""
vt_FullDuplexDossier:=""
If (7=8)
	$vl_Fenetre:=i_FenêtreNo(846; 578; 16; "Consolidation 115"; 3; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_Fiche")
Else 
	$vl_Fenetre:=i_FenêtreNo(1005; 645; 16; "Consolidation 115"; 1; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_Fiche_Conso")
End if 


CLOSE WINDOW:C154($vl_Fenetre)

<>PR_Conso115Voir:=0
If (vb_Show)
	Général_Show
End if 