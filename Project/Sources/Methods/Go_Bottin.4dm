//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Bottin
//{
//{          Mercredi 1 juillet 2009 à 11:00:00
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


ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="Importer"
ta_Page{2}:="Exporter"

C_LONGINT:C283(vl_Demande_Fiches; vl_Demande_Items; vl_Adresse_Fiches; vl_Adresse_Items; vl_Situation_Fiches; vl_Situation_Items; vl_Assoc_Fiches; vl_Assoc_Items)

QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_DemP)
MultiSoc_Filter(->[GIP:13])
vl_Demande_Fiches:=Records in selection:C76([GIP:13])
vl_Demande_Items:=Size of array:C274(<>ta_DemP)
QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_AdUtil)
MultiSoc_Filter(->[GIP:13])
vl_Adresse_Fiches:=Records in selection:C76([GIP:13])
vl_Adresse_Items:=Size of array:C274(<>ta_AdUtil)
QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_SitPar)
MultiSoc_Filter(->[GIP:13])
vl_Situation_Fiches:=Records in selection:C76([GIP:13])
vl_Situation_Items:=Size of array:C274(<>ta_SitPar)
vl_Assoc_Fiches:=Records in table:C83([Assocs:14])
vl_Assoc_Items:=0

C_TEXT:C284(vt_Demande_Chemin; vt_Adresse_Chemin; vt_Situation_Chemin; vt_Assoc_Chemin)
vt_Demande_Chemin:=""
vt_Adresse_Chemin:=""
vt_Situation_Chemin:=""
vt_Assoc_Chemin:=""



$vl_Fenetre:=i_FenêtreNo(585; 342; 16; "Bottin social"; 3; "")
DIALOG:C40([DiaLogues:3]; "DL_Bottin")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])



<>PR_Bottin:=0
If (vb_Show)
	Général_Show
End if 

