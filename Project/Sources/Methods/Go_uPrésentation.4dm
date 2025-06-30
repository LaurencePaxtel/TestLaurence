//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uItemGrouper
//{
//{          Lundi 26 janvier 2009 à 13:55:00
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

C_TEXT:C284(va_LibScénario)
va_LibScénario:=<>va_LibScénario  //"Scénar1"
ARRAY TEXT:C222(ta_Page; 3)
ta_Page{1}:="Etat civil"
ta_Page{2}:="Centres d'hébergements"
ta_Page{3}:="Prestations"
ta_Page:=1

C_LONGINT:C283(vl_NbEtCv; vl_NbEtCvGpe; vl_NbEtCvNA; vl_NbEtCvItem; vl_NbEtCvLiés)
C_LONGINT:C283(vl_NbCentres; vl_NbCentresGpe; vl_NbCentresNA; vl_NbCentresItem; vl_NbCentresLiés)
C_LONGINT:C283(vl_NbPresta; vl_NbPrestaGpe; vl_NbPrestaNA; vl_NbPrestaItem; vl_NbPrestaLiés)

C_TEXT:C284(va_CodeEnum)
C_LONGINT:C283(vl_CodeEnum)
C_TEXT:C284(va_LibEnum)
C_POINTER:C301(vp_PtrTableau; vp_PtrTableau2; vp_PtrTableau2)


Tab_Présentation_EtCv(0; 0; 0)
Tab_Présentation_EtCv(2; 0; 0)

Tab_Présentation_CtrH(0; 0; 0)
Tab_Présentation_CtrH(2; 0; 0)

Tab_Présentation_CtrP(0; 0; 0)
Tab_Présentation_CtrP(2; 0; 0)

va_Titre:="Regroupement d'items (présentation)"
$vl_Fenetre:=i_FenêtreNo(816; 588; 16; va_Titre; 1; "Quit_Simple")  //876
FORM SET INPUT:C55([DePart:1]; "DP_Présentation")
ADD RECORD:C56([DePart:1]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])

<>PR_Présentation:=0
If (vb_Show)
	Général_Show
End if 