//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uConsolidationRG
//{
//{          Mardi 2 novembre 2010 à 15:30
//{          Modifiée : Lundi 15 novembre 2010
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

<>vh_ConsoRTicks:=?00:00:00?

C_LONGINT:C283(ve_ConsoProcess)
C_TEXT:C284(va_ConsoProcessEtat)
C_LONGINT:C283(p1; p2; p3; vl_Thermomètre; vl_ThermoIndice; vl_ThermoPas)
vl_Thermomètre:=0
C_BOOLEAN:C305(vb_ExportEnCours; vb_ImportEnCours; vb_SurServeur; vb_Message)
vb_Message:=False:C215
vb_ExportEnCours:=False:C215
vb_ImportEnCours:=False:C215
vb_SurServeur:=True:C214
C_DATE:C307(vd_Date1; vd_Date2)
vd_Date1:=Current date:C33
vd_Date2:=vd_Date1
ARRAY TEXT:C222(ta_Conso_Document; 0)
C_TEXT:C284(vt_Conso_Dossier; 0)

DébutInitConsoR(0)
<>ve_ConsoRegion_Mode:=2
ALERT:C41("◊ve_ConsoRegion_Mode = "+String:C10(<>ve_ConsoRegion_Mode)+" forcé.")
If ($1>!00-00-00!)
	$vl_Fenetre:=i_FenêtreNo(466; 322; 16; "Consolidation régionale : initialisation manuelle"; 3; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_RegionalManuel")
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	
	$vl_Fenetre:=i_FenêtreNo(466; 462; 16; "Consolidation régionale"; 3; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_Regional")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 

<>PR_ConsoRParam:=0
If (vb_Show)
	Général_Show
End if 
