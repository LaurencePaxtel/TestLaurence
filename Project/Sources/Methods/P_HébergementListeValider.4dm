//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementListeValider
//{
//{          Mardi 9 mars 2004 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
If ($1=1)
	If ([HeberGement:5]HG_ReferenceID:1>0)
		<>va_MessageAE_HG:=<>va_MessageAE_HGRemp
		<>vl_ER_RemplaceQuiRéf:=[HeberGement:5]HG_HB_ID:19
		<>vl_ER_LC_ID:=[HeberGement:5]HG_LC_ID:61
		<>va_ER_RemplaceQui:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
		
		<>ve_ER_NuitEnCours:=[HeberGement:5]HG_ER_NuitEnCours:127
		<>ve_ER_NuitTotal:=[HeberGement:5]HG_ER_NuitTotal:128
		<>ve_ER_NuitReste:=[HeberGement:5]HG_ER_NuitReste:129
		
		
		
		CANCEL:C270
		POST OUTSIDE CALL:C329($2)
	Else 
		StrAlerte(5; "")
	End if 
Else 
	
	[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=<>vl_ER_RemplaceQuiRéf
	[HeberGement:5]HG_ER_RemplaceQui:132:=<>va_ER_RemplaceQui
	[HeberGement:5]HG_LC_ID:61:=<>vl_ER_LC_ID
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
	MultiSoc_Filter(->[LesCentres:9])
	[HeberGement:5]HG_CentreNom:62:=[LesCentres:9]LC_Nom:4
	[HeberGement:5]HG_CentreARR:63:=[LesCentres:9]LC_Lieu:5
	[HeberGement:5]HG_Médicalisé:56:=[LesCentres:9]LC_LitMédicalis:47
	[HeberGement:5]HG_AutreSolSuite:123:=<>va_ER_RemplaceQui
	
	[HeberGement:5]HG_NuitenCours:92:=1
	[HeberGement:5]HG_NuitTOTAL:93:=(<>ve_ER_NuitTotal-<>ve_ER_NuitEnCours+1)
	[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
	//06/09/2004
	[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
	
	If ([HeberGement:5]HG_NuitTOTAL:93>1)
		[HeberGement:5]HG_Réservation:91:=True:C214
	End if 
	P_HG_StatutEnCharge
End if 