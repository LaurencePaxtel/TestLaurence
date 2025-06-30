//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementHisto
//{
//{          Mardi 24 juillet 2001 à 16:36
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305(vb_Show)
C_DATE:C307(vd_BorneDate)
C_LONGINT:C283(ve_Borne)
vd_BorneDate:=$1
ve_Borne:=$2

READ ONLY:C145(*)
SET MENU BAR:C67(1)
If (ve_Borne=-100)
	If (<>vl_NoHHisto>0)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>vl_NoHHisto; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
		FIRST RECORD:C50([HeberGement:5])
		<>vt_TransHisto:=[HeberGement:5]HG_CentreNom:62+" le "+String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)
	End if 
Else 
	vb_Show:=False:C215
	If (vb_Show)
		Général_Hide
	End if 
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementHisto")
	va_Titre:="Historique"
	$vl_Fenetre:=i_FenêtreNo(632; 436; 4; va_Titre; 3; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([DiaLogues:3])
	
	If (vb_Show)
		Général_Show
	End if 
End if 


<>PR_HébergementH:=0