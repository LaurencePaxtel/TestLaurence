//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uFusionEtCv
//{
//{          Mercredi 6 avril 2005 à 11:06:00
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
ta_Page{1}:="Equivalences"
ta_Page{2}:="Fusions"
ta_Page:=1

C_LONGINT:C283(vl_NbEtCv; vl_NbItems)

C_TEXT:C284(va_CodeEnum)
C_TEXT:C284(va_LibEnum)
//Etat civil
va_CodeEnum:="EtaCv"
va_LibEnum:=""

//Etat civil
Tab_FusionOrigine(0; 0; 0)
Tab_FusionOrigine(2; 0; 0)

Tab_FusionDestination(0; 0; 0)
Tab_FusionDestination(2; 0; 0)


Tab_FusionOrigine(3; 0; 0)
Tab_FusionDestination(3; 0; 0)

READ WRITE:C146([DePart:1])
va_Titre:="Fusion : Etat civil"
$vl_Fenetre:=i_FenêtreNo(786; 508; 16; va_Titre; 3; "Quit_Simple")
//$vl_Fenetre:=i_FenêtreNo (786;800;16;va_Titre;3;"Quit_Simple")
FORM SET INPUT:C55([DePart:1]; "DP_FusionEtCv")
ADD RECORD:C56([DePart:1]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])

<>PR_FusionEtCv:=0
If (vb_Show)
	Général_Show
End if 

