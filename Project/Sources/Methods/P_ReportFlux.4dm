//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportFlux
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_TEXT:C284($1; $T_Type_Jour_Nuit)  //J ou N
$T_Type_Jour_Nuit:=$1  // #20170628-2
C_LONGINT:C283($2)


[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)
If ([HeberGement:5]HG_ER_Excuse:124)
	[HeberGement:5]HG_CléFax:69:=[HeberGement:5]HG_CléFax:69+"E"
End if 

va_LC_Stop:=""
//Nouvelle fiche
If ([HeberGement:5]HG_Cloturée:67) & ([HeberGement:5]HG_LC_ID:61>0)
	va_LC_Stop:=F_CL_LitsDispoAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; $T_Type_Jour_Nuit; $2; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
End if 