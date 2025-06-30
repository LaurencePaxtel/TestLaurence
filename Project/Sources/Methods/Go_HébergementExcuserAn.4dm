//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementExcuserAn
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

<>vl_PourExcuseRéfCT:=0

$vl_Fenetre:=i_FenêtreNo(450; 15; -((16*45))-2; "Message SSP™"; 20; "")

GOTO XY:C161(1; 0)
MESSAGE:C88(va_Titre)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=<>vd_PourExcuseDate)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_ER_RemplaceQuiRéf:131=<>vl_PourExcuseRéfHB)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_ER_Remplaçant:130=True:C214)
MultiSoc_Filter(->[HeberGement:5])
vL_NbFiches:=Records in selection:C76([HeberGement:5])
If (vL_NbFiches>0)
	If (vL_NbFiches>1)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=<>vd_PourExcuseNuit)
		MultiSoc_Filter(->[HeberGement:5])
	End if 
	If (Records in selection:C76([HeberGement:5])=1)
		$vb_OK:=True:C214
	Else 
		<>vl_PourExcuseRéfCT:=-1
	End if 
Else 
	<>vl_PourExcuseRéfCT:=-1
End if 

If ($vb_OK)
	
	va_Titre:="Annulation du remplacement… : "
	READ WRITE:C146([HeberGement:5])
	GOTO XY:C161(1; 0)
	MESSAGE:C88(va_Titre)
	Repeat 
		LOAD RECORD:C52([HeberGement:5])
	Until (Not:C34(Locked:C147([HeberGement:5])))
	
	[HeberGement:5]HG_Cloturée:67:=False:C215
	P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
	If ([HeberGement:5]HG_Cloturée:67)
		[HeberGement:5]HG_EnAttente:64:=False:C215
	Else 
		If ([HeberGement:5]HG_Transmis:65=True:C214) | ([HeberGement:5]HG_Cloturée:67=True:C214)
		Else 
			[HeberGement:5]HG_EnAttente:64:=True:C214
		End if 
	End if 
	<>vl_PourExcuseRéfCT:=[HeberGement:5]HG_LC_ID:61
	P_CL_LitsExcusésAnnulé([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; (("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))))
	[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)
	[HeberGement:5]HG_ER_Remplaçant:130:=False:C215
	[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=0
	[HeberGement:5]HG_ER_RemplaceQui:132:=""
	
	[HeberGement:5]HG_AutreSolutio:88:="Remplacement annulé"
	[HeberGement:5]HG_AutreSolSuite:123:=""
	[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
	
	SAVE RECORD:C53([HeberGement:5])
	UNLOAD RECORD:C212([HeberGement:5])
	
	READ ONLY:C145([HeberGement:5])
End if 

CLOSE WINDOW:C154($vl_Fenetre)

<>vd_PourExcuseEnCours:=True:C214

<>PR_HébergementExc:=0


If (vb_Show)
	Général_Show
End if 

