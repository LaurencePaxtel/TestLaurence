//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementExcuserRP
//{
//{          Lundi 25 Octobre 2004 à 13:53:00
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

C_LONGINT:C283(vL_NbFiches)
vL_NbFiches:=0
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215
C_TEXT:C284(va_Titre)
va_Titre:="Recherche en cours… : "
<>vt_PourExcuseRemp:=""
$vl_Fenetre:=i_FenêtreNo(450; 15; -((16*45))-2; "Message SSP™"; 20; "")

GOTO XY:C161(1; 0)
MESSAGE:C88(va_Titre)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=<>vd_PourExcuseDate)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_ER_RemplaceQuiRéf:131=<>vl_PourExcuseRéfHB)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_ER_Remplaçant:130=True:C214)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=<>vd_PourExcuseNuit)
MultiSoc_Filter(->[HeberGement:5])
vL_NbFiches:=Records in selection:C76([HeberGement:5])

If (vL_NbFiches=1)
	<>vt_PourExcuseRemp:="Remplaçant : "+<>va_CR+"   "+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22
	
End if 


CLOSE WINDOW:C154($vl_Fenetre)

<>vd_PourExcuseEnCours:=True:C214

<>PR_HébergementRemp:=0


If (vb_Show)
	Général_Show
End if 

