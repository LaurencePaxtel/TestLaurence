//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportFlux
//{
//{          Lundi 19 janvier 2004 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //J ou N
C_LONGINT:C283($2)

[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)

If ([HeberGement:5]HG_ER_Excuse:124)
	[HeberGement:5]HG_CléFax:69:=[HeberGement:5]HG_CléFax:69+"E"
End if 

va_LC_Stop:=""

If ([HeberGement:5]HG_Cloturée:67) & ([HeberGement:5]HG_LC_ID:61>0)  // Nouvelle fiche
	va_LC_Stop:=F_CL_LitsDispoAffecterA([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; $1; $2; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
End if 