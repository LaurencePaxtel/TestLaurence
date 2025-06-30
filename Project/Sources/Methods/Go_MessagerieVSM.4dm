//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Messagerie
//{
//{          Mardi 30 Novembre 2004 à 14:33
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
C_TEXT:C284(vaTitreMes)
C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
vaTitreMes:="VST - VSM "
P_MessagerieVSM

FORM SET INPUT:C55([MessagerieVSM:39]; "MV_EcranSaisie")
FORM SET OUTPUT:C54([MessagerieVSM:39]; "MV_EcranListe")
$vl_Fenetre:=i_FenêtreNo(475; 448; 4; vaTitreMes+" : "+String:C10(Records in selection:C76([MessagerieVSM:39])); 4; "Quit_Simple")
MODIFY SELECTION:C204([MessagerieVSM:39]; *)

CLOSE WINDOW:C154($vl_Fenetre)
<>PR_MessagerieVSM:=0

If (vb_Show)
	Général_Show
End if 